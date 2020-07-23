/*
 * SDS_mod_v1_private.h
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

#ifndef RTW_HEADER_SDS_mod_v1_private_h_
#define RTW_HEADER_SDS_mod_v1_private_h_
#include "rtwtypes.h"
#include "multiword_types.h"

/* ...  variable for information on a CAN channel */
extern can_tp1_canChannel* can_type1_channel_M1_C1;

/* ... definition of message variable for the RTICAN blocks */
#define CANTP1_M1_NUMMSG               3

extern can_tp1_canMsg* can_type1_msg_M1[CANTP1_M1_NUMMSG];

/* ... variable for taskqueue error checking                  */
extern Int32 rtican_type1_tq_error[CAN_TYPE1_NUM_MODULES]
  [CAN_TYPE1_NUM_TASKQUEUES];

/* Declaration of user indices (CAN_Type1_M1) */
#define CANTP1_M1_C1_TX_STD_0X359      0
#define TX_C1_STD_0X359                0
#undef TX_C1_STD_0X359
#define CANTP1_M1_C1_RX_STD_0X334      1
#define RX_C1_STD_0X334                1
#undef RX_C1_STD_0X334
#define CANTP1_M1_C1_RX_STD_0X35A      2
#define RX_C1_STD_0X35A                2
#undef RX_C1_STD_0X35A

/* predefine needed TX-definition code to support TX-Custom code */
extern can_tp1_canMsg* CANTP1_TX_SPMSG_M1_C1_STD;
extern can_tp1_canMsg* CANTP1_TX_SPMSG_M1_C1_XTD;

#endif                                 /* RTW_HEADER_SDS_mod_v1_private_h_ */
