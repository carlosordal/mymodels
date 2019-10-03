/*
 * SDS_brk_cbc_v1_private.h
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

#ifndef RTW_HEADER_SDS_brk_cbc_v1_private_h_
#define RTW_HEADER_SDS_brk_cbc_v1_private_h_
#include "rtwtypes.h"
#include "multiword_types.h"

/* ...  variable for information on a CAN channel */
extern can_tp1_canChannel* can_type1_channel_M1_C2;

/* ...  variable for information on a CAN channel */
extern can_tp1_canChannel* can_type1_channel_M1_C1;

/* ... definition of message variable for the RTICAN blocks */
#define CANTP1_M1_NUMMSG               9

extern can_tp1_canMsg* can_type1_msg_M1[CANTP1_M1_NUMMSG];

/* ... variable for taskqueue error checking                  */
extern Int32 rtican_type1_tq_error[CAN_TYPE1_NUM_MODULES]
  [CAN_TYPE1_NUM_TASKQUEUES];

/* Declaration of user indices (CAN_Type1_M1) */
#define CANTP1_M1_C2_TX_STD_0X1F3      0
#define TX_C2_STD_0X1F3                0
#undef TX_C2_STD_0X1F3
#define CANTP1_M1_C2_TX_STD_0X12A      1
#define TX_C2_STD_0X12A                1
#undef TX_C2_STD_0X12A
#define CANTP1_M1_C1_TX_STD_0X1F3      2
#define TX_C1_STD_0X1F3                2
#undef TX_C1_STD_0X1F3
#define CANTP1_M1_C1_TX_STD_0X359      3
#define TX_C1_STD_0X359                3
#undef TX_C1_STD_0X359
#define CANTP1_M1_C1_RX_STD_0X1F3      4
#define RX_C1_STD_0X1F3                4
#undef RX_C1_STD_0X1F3
#define CANTP1_M1_C1_RX_STD_0X28D      5
#define RX_C1_STD_0X28D                5
#undef RX_C1_STD_0X28D
#define CANTP1_M1_C1_RX_STD_0X2AA      6
#define RX_C1_STD_0X2AA                6
#undef RX_C1_STD_0X2AA
#define CANTP1_M1_C1_RX_STD_0X334      7
#define RX_C1_STD_0X334                7
#undef RX_C1_STD_0X334
#define CANTP1_M1_C1_RX_STD_0X35A      8
#define RX_C1_STD_0X35A                8
#undef RX_C1_STD_0X35A

/* predefine needed TX-definition code to support TX-Custom code */
extern can_tp1_canMsg* CANTP1_TX_SPMSG_M1_C2_STD;
extern can_tp1_canMsg* CANTP1_TX_SPMSG_M1_C2_XTD;

/* predefine needed TX-definition code to support TX-Custom code */
extern can_tp1_canMsg* CANTP1_TX_SPMSG_M1_C1_STD;
extern can_tp1_canMsg* CANTP1_TX_SPMSG_M1_C1_XTD;

#endif                                 /* RTW_HEADER_SDS_brk_cbc_v1_private_h_ */
