/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: cartpole_policy_codegen_types.h
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

#ifndef cartpole_policy_codegen_types_h_
#define cartpole_policy_codegen_types_h_
#include "rtwtypes.h"

/* Custom Type definition for MATLAB Function: '<S1>/PolicyWrapper' */
#ifndef struct_tag_xviDWIkgrKK5ptWTEU1YkF
#define struct_tag_xviDWIkgrKK5ptWTEU1YkF

struct tag_xviDWIkgrKK5ptWTEU1YkF
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
};

#endif                                 /* struct_tag_xviDWIkgrKK5ptWTEU1YkF */

#ifndef typedef_rl_codegen_model_DLNetworkMod_T
#define typedef_rl_codegen_model_DLNetworkMod_T

typedef struct tag_xviDWIkgrKK5ptWTEU1YkF rl_codegen_model_DLNetworkMod_T;

#endif                             /* typedef_rl_codegen_model_DLNetworkMod_T */

#ifndef struct_tag_CCFnAGX5Y6QU8EAWUFvJHH
#define struct_tag_CCFnAGX5Y6QU8EAWUFvJHH

struct tag_CCFnAGX5Y6QU8EAWUFvJHH
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  rl_codegen_model_DLNetworkMod_T *Model_;
};

#endif                                 /* struct_tag_CCFnAGX5Y6QU8EAWUFvJHH */

#ifndef typedef_rl_codegen_policy_rlMaxQPolic_T
#define typedef_rl_codegen_policy_rlMaxQPolic_T

typedef struct tag_CCFnAGX5Y6QU8EAWUFvJHH rl_codegen_policy_rlMaxQPolic_T;

#endif                             /* typedef_rl_codegen_policy_rlMaxQPolic_T */

#ifndef struct_tag_46u7hV3ec6erHTJy5qTRuD
#define struct_tag_46u7hV3ec6erHTJy5qTRuD

struct tag_46u7hV3ec6erHTJy5qTRuD
{
  real32_T Data[3];
};

#endif                                 /* struct_tag_46u7hV3ec6erHTJy5qTRuD */

#ifndef typedef_dlarray_1_cartpole_policy_cod_T
#define typedef_dlarray_1_cartpole_policy_cod_T

typedef struct tag_46u7hV3ec6erHTJy5qTRuD dlarray_1_cartpole_policy_cod_T;

#endif                             /* typedef_dlarray_1_cartpole_policy_cod_T */

/* Forward declaration for rtModel */
typedef struct tag_RTM_cartpole_policy_codeg_T RT_MODEL_cartpole_policy_code_T;

#endif                                 /* cartpole_policy_codegen_types_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
