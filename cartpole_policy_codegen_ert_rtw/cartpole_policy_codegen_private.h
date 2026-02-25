/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: cartpole_policy_codegen_private.h
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

#ifndef cartpole_policy_codegen_private_h_
#define cartpole_policy_codegen_private_h_
#include "rtwtypes.h"
#include "cartpole_policy_codegen_types.h"
#include "cartpole_policy_codegen.h"

extern void microKernel12(int32_T K, const real32_T *A, int32_T LDA, const
  real32_T *B, real32_T *C);
extern void microKernel11(int32_T K, const real32_T *A, int32_T LDA, const
  real32_T *B, real32_T *C);
extern void microKernel21(int32_T K, const real32_T *A, int32_T LDA, const
  real32_T *B, real32_T *C);
extern void macroKernel2(int32_T M, int32_T K, int32_T N, const real32_T *A,
  int32_T LDA, const real32_T *B, int32_T LDB, real32_T *C, int32_T LDC);
extern void matrixMultiply2(int32_T M, int32_T K, int32_T N, int32_T blockSizeM,
  int32_T blockSizeK, int32_T blockSizeN, const real32_T *A, const real32_T *B,
  real32_T *C);
extern void macroKernel1(int32_T M, int32_T K, int32_T N, const real32_T *A,
  int32_T LDA, const real32_T *B, int32_T LDB, real32_T *C, int32_T LDC);
extern void matrixMultiply1(int32_T M, int32_T K, int32_T N, int32_T blockSizeM,
  int32_T blockSizeK, int32_T blockSizeN, const real32_T *A, const real32_T *B,
  real32_T *C);
extern int32_T div_s32_floor(int32_T numerator, int32_T denominator);
extern int32_T div_nde_s32_floor(int32_T numerator, int32_T denominator);

#endif                                 /* cartpole_policy_codegen_private_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
