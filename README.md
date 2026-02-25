# CartPole RL Codegen

MATLAB/Simulink reinforcement-learning project for a DQN CartPole controller. The workflow trains a DQN agent in MATLAB/Simulink, separates the trained policy for deployment, and generates deployable C code for embedded targets.

## Contents

- `cartpole_full_project_codegen_R2024b_FINAL.m`: training, simulation, plotting, policy block generation, and codegen workflow
- `cartpole_policy_codegen.slx`: controller-only Simulink model for code generation
- `cartpole_policy_codegen_ert_rtw/*.c` and `*.h`: generated policy/controller C source

The repository keeps source and generated deployment code only. Generated caches, trained agent snapshots, plots, logs, local build metadata, and local machine paths are excluded.
