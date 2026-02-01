/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: cartpole_policy_codegen.h
 *
 * Code generated for Simulink model 'cartpole_policy_codegen'.
 *
 * Model version                  : 1.4
 * Simulink Coder version         : 24.2 (R2024b) 21-Jun-2024
 * C/C++ source code generated on : Fri Jan 30 01:17:10 2026
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef cartpole_policy_codegen_h_
#define cartpole_policy_codegen_h_
#ifndef cartpole_policy_codegen_COMMON_INCLUDES_
#define cartpole_policy_codegen_COMMON_INCLUDES_
#include "rtwtypes.h"
#endif                            /* cartpole_policy_codegen_COMMON_INCLUDES_ */

#include "cartpole_policy_codegen_types.h"
#include "rt_nonfinite.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

/* Block states (default storage) for system '<Root>' */
typedef struct {
  rl_codegen_policy_rlMaxQPolic_T policy;/* '<S1>/PolicyWrapper' */
  rl_codegen_model_DLNetworkMod_T gobj_1;/* '<S1>/PolicyWrapper' */
  boolean_T policy_not_empty;          /* '<S1>/PolicyWrapper' */
} DW_cartpole_policy_codegen_T;

/* External inputs (root inport signals with default storage) */
typedef struct {
  real_T obs_in[5];                    /* '<Root>/obs_in' */
} ExtU_cartpole_policy_codegen_T;

/* External outputs (root outports fed by signals with default storage) */
typedef struct {
  real_T act_out;                      /* '<Root>/act_out' */
} ExtY_cartpole_policy_codegen_T;

/* Real-time Model Data Structure */
struct tag_RTM_cartpole_policy_codeg_T {
  const char_T * volatile errorStatus;
};

/* Block states (default storage) */
extern DW_cartpole_policy_codegen_T cartpole_policy_codegen_DW;

/* External inputs (root inport signals with default storage) */
extern ExtU_cartpole_policy_codegen_T cartpole_policy_codegen_U;

/* External outputs (root outports fed by signals with default storage) */
extern ExtY_cartpole_policy_codegen_T cartpole_policy_codegen_Y;

/* Model entry point functions */
extern void cartpole_policy_codegen_initialize(void);
extern void cartpole_policy_codegen_step(void);
extern void cartpole_policy_codegen_terminate(void);

/* Real-time Model object */
extern RT_MODEL_cartpole_policy_code_T *const cartpole_policy_codegen_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'cartpole_policy_codegen'
 * '<S1>'   : 'cartpole_policy_codegen/Policy'
 * '<S2>'   : 'cartpole_policy_codegen/Policy/PolicyWrapper'
 */
#endif                                 /* cartpole_policy_codegen_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
