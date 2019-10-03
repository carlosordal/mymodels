/*
 * SDS_brk_cbc_v1_data.c
 *
 * Code generation for model "SDS_brk_cbc_v1".
 *
 * Model version              : 1.66
 * Simulink Coder version : 9.0 (R2018b) 24-May-2018
 * C source code generated on : Wed Oct  2 13:56:06 2019
 *
 * Target selection: rti1401.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Custom Processor->Custom
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "SDS_brk_cbc_v1.h"
#include "SDS_brk_cbc_v1_private.h"

/* Block parameters (default storage) */
P_SDS_brk_cbc_v1_T SDS_brk_cbc_v1_P = {
  /* Mask Parameter: CRC_is_OK1_const
   * Referenced by: '<S24>/Constant'
   */
  0.5,

  /* Mask Parameter: CounterLimited1_uplimit
   * Referenced by: '<S21>/FixPt Switch'
   */
  15U,

  /* Mask Parameter: CounterLimited_uplimit
   * Referenced by: '<S30>/FixPt Switch'
   */
  15U,

  /* Mask Parameter: CounterLimited_uplimit_g
   * Referenced by: '<S14>/FixPt Switch'
   */
  15U,

  /* Mask Parameter: CounterLimited1_uplimit_i
   * Referenced by: '<S16>/FixPt Switch'
   */
  15U,

  /* Computed Parameter: TXstatus_Y0
   * Referenced by: '<S18>/TX status'
   */
  0.0,

  /* Computed Parameter: TXtime_Y0
   * Referenced by: '<S18>/TX time'
   */
  0.0,

  /* Computed Parameter: TXdeltatime_Y0
   * Referenced by: '<S18>/TX delta time'
   */
  0.0,

  /* Computed Parameter: TXdelaytime_Y0
   * Referenced by: '<S18>/TX delay time'
   */
  0.0,

  /* Computed Parameter: TXstatus_Y0_k
   * Referenced by: '<S19>/TX status'
   */
  0.0,

  /* Computed Parameter: TXtime_Y0_f
   * Referenced by: '<S19>/TX time'
   */
  0.0,

  /* Computed Parameter: TXdeltatime_Y0_k
   * Referenced by: '<S19>/TX delta time'
   */
  0.0,

  /* Computed Parameter: TXdelaytime_Y0_n
   * Referenced by: '<S19>/TX delay time'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S11>/CRC_SDS_Motion_Ref'
   */
  0.0,

  /* Expression: 2077
   * Referenced by: '<S11>/Long_Accel_sds_mot_ref'
   */
  2077.0,

  /* Expression: 0
   * Referenced by: '<S11>/Veh_Speed_sds_mot_ref'
   */
  0.0,

  /* Computed Parameter: TXstatus_Y0_n
   * Referenced by: '<S22>/TX status'
   */
  0.0,

  /* Computed Parameter: TXtime_Y0_o
   * Referenced by: '<S22>/TX time'
   */
  0.0,

  /* Computed Parameter: TXdeltatime_Y0_n
   * Referenced by: '<S22>/TX delta time'
   */
  0.0,

  /* Computed Parameter: TXdelaytime_Y0_i
   * Referenced by: '<S22>/TX delay time'
   */
  0.0,

  /* Computed Parameter: TXstatus_Y0_b
   * Referenced by: '<S28>/TX status'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/SDS_Engaged_State'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/DAS_EPB_APPY_RQ'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/RHSC_OpenLoopBraking_Rq'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/DAS_EPB_RELSE_RQ'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/LFC_Request_Type'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/LFC_Request'
   */
  0.0,

  /* Expression: 1
   * Referenced by: '<S1>/MC_CANC3_DAS_A3_A'
   */
  1.0,

  /* Expression: 0
   * Referenced by: '<S1>/CRC_CCAN3_DAS_A3_A'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/SDS_Brk_TX_Trigger'
   */
  0.0,

  /* Expression: 1
   * Referenced by: '<S1>/SDS_Motion_ref_Trigg'
   */
  1.0,

  /* Expression: 0
   * Referenced by: '<S1>/Brk_PreFill_Rq'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/CRC_DAS_A3_A'
   */
  0.0,

  /* Expression: 4
   * Referenced by: '<S4>/SDS_CBC_IGNPOS'
   */
  4.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_HiBmLvr'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_HAZ_SW'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_TRN-I_1L_2R_0N'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_CMD3'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_Horn'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_HDLP_Wash'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_WPR_Wash'
   */
  0.0,

  /* Expression: 3
   * Referenced by: '<S4>/SDS_CBC_IP_Dimmer'
   */
  3.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_HDLP_SW'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_RFFunct'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_WprWshSW'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_WPRSW'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_OVERLAY_REQ'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_ConvLmpRst'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/RHSC_CRC'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/SDS_CBC_CMD_TX_Trigger'
   */
  0.0,

  /* Computed Parameter: FixPtConstant_Value
   * Referenced by: '<S20>/FixPt Constant'
   */
  1U,

  /* Computed Parameter: Output_InitialCondition
   * Referenced by: '<S17>/Output'
   */
  0U,

  /* Computed Parameter: Constant_Value
   * Referenced by: '<S21>/Constant'
   */
  0U,

  /* Computed Parameter: FixPtConstant_Value_k
   * Referenced by: '<S29>/FixPt Constant'
   */
  1U,

  /* Computed Parameter: Output_InitialCondition_i
   * Referenced by: '<S27>/Output'
   */
  0U,

  /* Computed Parameter: Constant_Value_i
   * Referenced by: '<S30>/Constant'
   */
  0U,

  /* Computed Parameter: Output_InitialCondition_o
   * Referenced by: '<S7>/Output'
   */
  0U,

  /* Computed Parameter: Output_InitialCondition_p
   * Referenced by: '<S6>/Output'
   */
  0U,

  /* Computed Parameter: FixPtConstant_Value_j
   * Referenced by: '<S13>/FixPt Constant'
   */
  1U,

  /* Computed Parameter: Constant_Value_h
   * Referenced by: '<S14>/Constant'
   */
  0U,

  /* Computed Parameter: FixPtConstant_Value_a
   * Referenced by: '<S15>/FixPt Constant'
   */
  1U,

  /* Computed Parameter: Constant_Value_hb
   * Referenced by: '<S16>/Constant'
   */
  0U
};
