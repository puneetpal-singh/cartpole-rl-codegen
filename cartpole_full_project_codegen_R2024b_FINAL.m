%% ============================================================
%  Cart-Pole RL Project + Logging + Custom Plots + Codegen (R2024b)
%  Environment: rlPredefinedEnv("CartPoleSimscapeModel-Discrete")
%
%  Generates:
%   - CartPole_Simscape_DQN_Logged_R2024b.mat  (agent + training stats)
%   - PNG plots for report
%   - Policy block (via generatePolicyBlock)
%   - Controller-only codegen model: cartpole_policy_codegen.slx
%
%  Requirements:
%   - Reinforcement Learning Toolbox
%   - Simulink
%   - Simscape Multibody (for rlCartPoleSimscapeModel)
%   - Simulink Coder (for slbuild -> C code)
%% ============================================================

clear; clc; close all;

%% ---------------- Step 1: Reproducibility -------------------
previousRngState = rng(0,"twister");

%% ---------------- Step 2: Open model + create environment ----
mdl = "rlCartPoleSimscapeModel";
open_system(mdl);

env = rlPredefinedEnv("CartPoleSimscapeModel-Discrete");
obsInfo = getObservationInfo(env);
actInfo = getActionInfo(env);

obsDim = obsInfo.Dimension(1);

Ts = 0.02;
Tf = 25;
maxSteps = ceil(Tf/Ts);

%% ---------------- Step 3: Training / Simulation options -------
evl = rlEvaluator(NumEpisodes=10, EvaluationFrequency=100);

trainOpts = rlTrainingOptions( ...
    MaxEpisodes               = 2000, ...
    MaxStepsPerEpisode        = maxSteps, ...
    ScoreAveragingWindowLength= 20, ...
    Verbose                   = true, ...
    Plots                     = "training-progress", ...
    StopTrainingCriteria      = "EvaluationStatistic", ...
    StopTrainingValue         = -400, ...
    SaveAgentCriteria         = "EvaluationStatistic", ...
    SaveAgentValue            = -400);

simOpts = rlSimulationOptions(MaxSteps=500);

%% ---------------- Step 4: Create DQN agent --------------------
rng(0,"twister");
agent = rlDQNAgent(obsInfo, actInfo);

agent.AgentOptions.SampleTime = Ts;
agent.AgentOptions.CriticOptimizerOptions.LearnRate = 1e-3;
agent.AgentOptions.CriticOptimizerOptions.GradientThreshold = 1;
agent.AgentOptions.ExperienceBufferLength = 1e6;

agent.AgentOptions.EpsilonGreedyExploration.EpsilonDecay = 1e-4;
agent.AgentOptions.EpsilonGreedyExploration.EpsilonMin   = 0.05;

%% ---------------- Step 5: Train and LOG -----------------------
doTraining = true;   % set false after first successful training

if doTraining
    fprintf("\n=== Training Started ===\n");
    rng(0,"twister");
    tStart = tic;
    trainStats = train(agent, env, trainOpts, Evaluator=evl);
    trainTime = toc(tStart);
    fprintf("=== Training Finished. Time: %.2f seconds ===\n", trainTime);

    save("CartPole_Simscape_DQN_Logged_R2024b.mat", ...
        "agent","trainStats","trainTime","Ts","Tf","maxSteps","obsDim");
else
    load("CartPole_Simscape_DQN_Logged_R2024b.mat", ...
        "agent","trainStats","trainTime","Ts","Tf","maxSteps","obsDim");
end

%% ---------------- Step 6: Custom plots (report plots) ---------
figure('Name','Episode Reward');
plot(trainStats.EpisodeIndex, trainStats.EpisodeReward, 'LineWidth', 1);
grid on; xlabel('Episode'); ylabel('Episode Reward');
title('DQN Training: Episode Reward');
exportgraphics(gcf,"cartpole_train_episode_reward.png");

figure('Name','Moving Average Reward');
movWin = 20;
plot(trainStats.EpisodeIndex, movmean(trainStats.EpisodeReward, movWin), 'LineWidth', 2);
grid on; xlabel('Episode'); ylabel(['Moving Avg Reward (',num2str(movWin),')']);
title('DQN Training: Moving Average Reward');
exportgraphics(gcf,"cartpole_train_reward_movavg.png");

if isprop(trainStats,"EpisodeQ0") && ~isempty(trainStats.EpisodeQ0)
    figure('Name','Episode Q0');
    plot(trainStats.EpisodeIndex, trainStats.EpisodeQ0, 'LineWidth', 1.5);
    grid on; xlabel('Episode'); ylabel('Episode Q0');
    title('DQN Training: Episode Q0 (Value estimate at episode start)');
    exportgraphics(gcf,"cartpole_train_episodeQ0.png");
end

%% ---------------- Step 7: Simulate final agent (Greedy) --------
rng(0,"twister");
agent.UseExplorationPolicy = false;
experience = sim(env, agent, simOpts);

reward = experience.Reward;
totalReward = sum(reward);
fprintf("\nTotal reward of final greedy simulation: %.4f\n", totalReward);

%% ---------------- Step 8: Robust extract of obs/actions --------
obsMat = localGetObsMatrix(experience.Observation, obsDim);
actVec = localGetActVector(experience.Action);

fprintf("Decoded obsMat size: [%d x %d]\n", size(obsMat,1), size(obsMat,2));
fprintf("Decoded actVec size: [%d x %d]\n", size(actVec,1), size(actVec,2));

% Align lengths
Tobs = size(obsMat,2);
Tact = numel(actVec);
Trew = numel(reward);
T = min([Tobs, Tact, Trew]);

obsMat = obsMat(:,1:T);
actVec = actVec(1:T);
reward = reward(1:T);

t = (0:T-1) * Ts;

%% ---------------- Step 9: Decode states + plot behavior --------
% Expected ordering for this environment:
% [x; x_dot; sin(theta); cos(theta); theta_dot]
if obsDim < 5
    error("Observation dimension is %d. Expected at least 5 for CartPoleSimscapeModel.", obsDim);
end

x      = obsMat(1,:);
x_dot  = obsMat(2,:);
sinTh  = obsMat(3,:);
cosTh  = obsMat(4,:);
th_dot = obsMat(5,:);
theta  = atan2(sinTh, cosTh);

figure('Name','Cart Position');
plot(t, x, 'LineWidth', 1.5);
grid on; xlabel('Time (s)'); ylabel('Cart Position (m)');
title('Final Controller Behavior: Cart Position');
exportgraphics(gcf,"cartpole_sim_cart_position.png");

figure('Name','Pole Angle');
plot(t, theta, 'LineWidth', 1.5);
grid on; xlabel('Time (s)'); ylabel('Pole Angle (rad)');
title('Final Controller Behavior: Pole Angle');
exportgraphics(gcf,"cartpole_sim_pole_angle.png");

figure('Name','Control Force');
stairs(t, actVec, 'LineWidth', 1.5);
grid on; xlabel('Time (s)'); ylabel('Force (N)');
title('Final Controller Behavior: Control Action (Force)');
exportgraphics(gcf,"cartpole_sim_control_force.png");

%% ---------------- Step 10: Export policy block ----------------
% Policy is deployable (no training)
generatePolicyBlock(agent);
save("CartPole_Simscape_DQN_TrainedAgent_R2024b.mat","agent");

%% ---------------- Step 11: Create controller-only codegen model -
% NOTE: Simscape plant usually cannot be fully codegen'd; controller-only is safest.
codegenModel = "cartpole_policy_codegen";
if bdIsLoaded(codegenModel)
    close_system(codegenModel,0);
end
new_system(codegenModel); open_system(codegenModel);

add_block("simulink/Sources/In1", codegenModel + "/obs_in",  "Position",[60 80 100 100]);
add_block("simulink/Sinks/Out1",  codegenModel + "/act_out", "Position",[480 80 520 100]);

% Configure code generation
cs = getActiveConfigSet(codegenModel);
try
    set_param(cs,'SystemTargetFile','ert.tlc'); % Embedded Coder if available
catch
    set_param(cs,'SystemTargetFile','grt.tlc'); % Simulink Coder fallback
end
set_param(cs,'TargetLang','C');
set_param(codegenModel,'GenCodeOnly','on');
save_system(codegenModel);

fprintf("\n============================================================\n");
fprintf("CODEGEN NEXT STEPS (manual 1 minute):\n");
fprintf("1) A policy model opened from generatePolicyBlock(agent).\n");
fprintf("2) Copy the generated Policy block from that model.\n");
fprintf("3) Paste it into: %s\n", codegenModel);
fprintf("4) Connect: obs_in --> Policy --> act_out\n");
fprintf("5) Save the model.\n");
fprintf("6) Generate C code by running:\n");
fprintf("   slbuild('%s')\n", codegenModel);
fprintf("============================================================\n\n");

%% Restore RNG
rng(previousRngState);

%% ============================================================
% Local functions
%% ============================================================

function obsMat = localGetObsMatrix(obsStruct, obsDim)
% Convert experience.Observation into numeric matrix [obsDim x T]
% Supports: struct, numeric, cell, timeseries (R2024b common)

    % Extract raw container
    if isstruct(obsStruct)
        fns = fieldnames(obsStruct);
        raw = obsStruct.(fns{1});
    else
        raw = obsStruct;
    end

    % timeseries support
    if isa(raw,"timeseries")
        D = squeeze(raw.Data);   % often [T x obsDim] or [T x 1 x obsDim]
        if size(D,2) == obsDim
            obsMat = D.';        % -> [obsDim x T]
            return;
        elseif size(D,1) == obsDim
            obsMat = D;          % already [obsDim x T]
            return;
        else
            error("timeseries obs size mismatch. Data size=[%s], obsDim=%d", num2str(size(D)), obsDim);
        end
    end

    % numeric support
    if isnumeric(raw)
        A = squeeze(raw);
        if size(A,1) == obsDim
            obsMat = A;
            return;
        elseif size(A,2) == obsDim
            obsMat = A.';
            return;
        else
            error("numeric obs size mismatch. Size=[%s], obsDim=%d", num2str(size(A)), obsDim);
        end
    end

    % cell support
    if iscell(raw)
        T = numel(raw);
        obsMat = zeros(obsDim, T);
        for k = 1:T
            v = squeeze(raw{k});
            v = v(:);
            if numel(v) ~= obsDim
                error("Observation cell %d has %d elements, expected %d.", k, numel(v), obsDim);
            end
            obsMat(:,k) = v;
        end
        return;
    end

    error("Unsupported observation data type: %s", class(raw));
end

function actVec = localGetActVector(actStruct)
% Convert experience.Action into numeric vector [1 x T]
% Supports numeric, cell, timeseries

    if isstruct(actStruct)
        fns = fieldnames(actStruct);
        raw = actStruct.(fns{1});
    else
        raw = actStruct;
    end

    if isa(raw,"timeseries")
        D = squeeze(raw.Data);
        actVec = D(:).';     % row vector
        return;
    end

    if isnumeric(raw)
        raw = squeeze(raw);
        actVec = raw(:).';
        return;
    end

    if iscell(raw)
        T = numel(raw);
        actVec = zeros(1,T);
        for k = 1:T
            v = squeeze(raw{k});
            actVec(k) = v(1);
        end
        return;
    end

    error("Unsupported action data type: %s", class(raw));
end
