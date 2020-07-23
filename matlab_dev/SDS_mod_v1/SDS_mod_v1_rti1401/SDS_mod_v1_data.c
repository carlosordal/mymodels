/*
 * SDS_mod_v1_data.c
 *
 * Code generation for model "SDS_mod_v1".
 *
 * Model version              : 1.13
 * Simulink Coder version : 9.0 (R2018b) 24-May-2018
 * C source code generated on : Fri Aug  2 09:10:03 2019
 *
 * Target selection: rti1401.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Custom Processor->Custom
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "SDS_mod_v1.h"
#include "SDS_mod_v1_private.h"

/* Block parameters (default storage) */
P_SDS_mod_v1_T SDS_mod_v1_P = {
  /* Mask Parameter: CRC_is_OK1_const
   * Referenced by: '<S3>/Constant'
   */
  0.5,

  /* Mask Parameter: CounterLimited_uplimit
   * Referenced by: '<S13>/FixPt Switch'
   */
  15U,

  /* Computed Parameter: TXstatus_Y0
   * Referenced by: '<S11>/TX status'
   */
  0.0,

  /* Expression: 4
   * Referenced by: '<Root>/SDS_CBC_IGNPOS'
   */
  4.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_HiBmLvr'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_HAZ_SW'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_TRN-I_1L_2R_0N'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_CMD3'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_Horn'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_HDLP_Wash'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_WPR_Wash'
   */
  0.0,

  /* Expression: 3
   * Referenced by: '<Root>/SDS_CBC_IP_Dimmer'
   */
  3.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_HDLP_SW'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_RFFunct'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_WprWshSW'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_WPRSW'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_OVERLAY_REQ'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_ConvLmpRst'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/RHSC_CRC'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/SDS_CBC_CMD_TX_Trigger'
   */
  0.0,

  /* Computed Parameter: FixPtConstant_Value
   * Referenced by: '<S12>/FixPt Constant'
   */
  1U,

  /* Computed Parameter: Output_InitialCondition
   * Referenced by: '<S10>/Output'
   */
  0U,

  /* Computed Parameter: Constant_Value
   * Referenced by: '<S13>/Constant'
   */
  0U
};
