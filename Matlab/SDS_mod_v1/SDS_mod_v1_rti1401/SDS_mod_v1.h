/*
 * SDS_mod_v1.h
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

#ifndef RTW_HEADER_SDS_mod_v1_h_
#define RTW_HEADER_SDS_mod_v1_h_
#include <string.h>
#ifndef SDS_mod_v1_COMMON_INCLUDES_
# define SDS_mod_v1_COMMON_INCLUDES_
#include <brtenv.h>
#include <rtkernel.h>
#include <rti_assert.h>
#include <rtidefineddatatypes.h>
#include <rtican_ds1401.h>
#include <rtican_usercoding.h>
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#endif                                 /* SDS_mod_v1_COMMON_INCLUDES_ */

#include "SDS_mod_v1_types.h"

/* Shared type includes */
#include "multiword_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  ((rtm)->Timing.taskTime0)
#endif

/* Block signals (default storage) */
typedef struct {
  real_T SFunction1_o1;                /* '<S2>/S-Function1' */
  real_T SFunction1_o2;                /* '<S2>/S-Function1' */
  real_T SFunction1_o3;                /* '<S2>/S-Function1' */
  real_T SFunction1_o4;                /* '<S2>/S-Function1' */
  real_T SFunction1_o5;                /* '<S2>/S-Function1' */
  real_T SFunction1_o6;                /* '<S2>/S-Function1' */
  real_T SFunction1_o7;                /* '<S2>/S-Function1' */
  real_T SFunction1_o8;                /* '<S2>/S-Function1' */
  real_T SFunction1_o9;                /* '<S2>/S-Function1' */
  real_T SFunction1_o10;               /* '<S2>/S-Function1' */
  real_T SFunction1_o11;               /* '<S2>/S-Function1' */
  real_T SFunction1_o12;               /* '<S2>/S-Function1' */
  real_T SFunction1_o13;               /* '<S2>/S-Function1' */
  real_T SFunction1_o14;               /* '<S2>/S-Function1' */
  real_T SFunction1_o15;               /* '<S2>/S-Function1' */
  real_T SFunction1_o16;               /* '<S2>/S-Function1' */
  real_T SFunction1_o17;               /* '<S2>/S-Function1' */
  real_T SFunction1_o18;               /* '<S2>/S-Function1' */
  real_T SFunction1_o19;               /* '<S2>/S-Function1' */
  real_T SFunction1_o20;               /* '<S2>/S-Function1' */
  real_T SFunction1_o21;               /* '<S2>/S-Function1' */
  real_T SFunction1_o22;               /* '<S2>/S-Function1' */
  real_T SFunction1_o23;               /* '<S2>/S-Function1' */
  real_T SFunction1_o24;               /* '<S2>/S-Function1' */
  real_T SFunction1_o25;               /* '<S2>/S-Function1' */
  real_T SFunction1_o26;               /* '<S2>/S-Function1' */
  real_T SFunction1_o1_a;              /* '<S6>/S-Function1' */
  real_T SFunction1_o2_n;              /* '<S6>/S-Function1' */
  real_T SFunction1_o3_a;              /* '<S6>/S-Function1' */
  real_T SFunction1_o4_b;              /* '<S6>/S-Function1' */
  real_T SFunction1_o5_f;              /* '<S6>/S-Function1' */
  real_T SFunction1_o6_d;              /* '<S6>/S-Function1' */
  real_T SFunction1_o7_f;              /* '<S6>/S-Function1' */
  real_T SFunction1_o8_o;              /* '<S6>/S-Function1' */
  real_T SFunction1_o9_p;              /* '<S6>/S-Function1' */
  real_T SFunction1_o10_i;             /* '<S6>/S-Function1' */
  real_T SFunction1_o11_f;             /* '<S6>/S-Function1' */
  real_T SFunction1_o12_c;             /* '<S6>/S-Function1' */
  real_T SFunction1_o13_o;             /* '<S6>/S-Function1' */
  real_T SFunction1_o14_i;             /* '<S6>/S-Function1' */
  real_T SFunction1_o15_a;             /* '<S6>/S-Function1' */
  real_T DataTypeConversion;           /* '<S5>/Data Type Conversion' */
  real_T HiddenBuf_InsertedFor_SDS_CBC_C;
  real_T SFunction1;                   /* '<S11>/S-Function1' */
  uint8_T Output;                      /* '<S10>/Output' */
  uint8_T FixPtSum1;                   /* '<S12>/FixPt Sum1' */
  uint8_T FixPtSwitch;                 /* '<S13>/FixPt Switch' */
  boolean_T Compare;                   /* '<S3>/Compare' */
} B_SDS_mod_v1_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  int_T SFunction1_IWORK[2];           /* '<S1>/S-Function1' */
  uint8_T Output_DSTATE;               /* '<S10>/Output' */
  boolean_T SDS_CAN_Tx_Sub_MODE;       /* '<Root>/SDS _CAN_Tx_Sub ' */
} DW_SDS_mod_v1_T;

/* Parameters (default storage) */
struct P_SDS_mod_v1_T_ {
  real_T CRC_is_OK1_const;             /* Mask Parameter: CRC_is_OK1_const
                                        * Referenced by: '<S3>/Constant'
                                        */
  uint8_T CounterLimited_uplimit;      /* Mask Parameter: CounterLimited_uplimit
                                        * Referenced by: '<S13>/FixPt Switch'
                                        */
  real_T TXstatus_Y0;                  /* Computed Parameter: TXstatus_Y0
                                        * Referenced by: '<S11>/TX status'
                                        */
  real_T SDS_CBC_IGNPOS_Value;         /* Expression: 4
                                        * Referenced by: '<Root>/SDS_CBC_IGNPOS'
                                        */
  real_T SDS_CBC_HiBmLvr_Value;        /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_HiBmLvr'
                                        */
  real_T SDS_CBC_HAZ_SW_Value;         /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_HAZ_SW'
                                        */
  real_T SDS_CBC_TRNI_1L_2R_0N_Value;  /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_TRN-I_1L_2R_0N'
                                        */
  real_T SDS_CBC_CMD3_Value;           /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_CMD3'
                                        */
  real_T SDS_CBC_Horn_Value;           /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_Horn'
                                        */
  real_T SDS_CBC_HDLP_Wash_Value;      /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_HDLP_Wash'
                                        */
  real_T SDS_CBC_WPR_Wash_Value;       /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_WPR_Wash'
                                        */
  real_T SDS_CBC_IP_Dimmer_Value;      /* Expression: 3
                                        * Referenced by: '<Root>/SDS_CBC_IP_Dimmer'
                                        */
  real_T SDS_CBC_HDLP_SW_Value;        /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_HDLP_SW'
                                        */
  real_T SDS_CBC_RFFunct_Value;        /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_RFFunct'
                                        */
  real_T SDS_CBC_WprWshSW_Value;       /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_WprWshSW'
                                        */
  real_T SDS_CBC_WPRSW_Value;          /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_WPRSW'
                                        */
  real_T SDS_CBC_OVERLAY_REQ_Value;    /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_OVERLAY_REQ'
                                        */
  real_T SDS_CBC_ConvLmpRst_Value;     /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_ConvLmpRst'
                                        */
  real_T RHSC_CRC_Value;               /* Expression: 0
                                        * Referenced by: '<Root>/RHSC_CRC'
                                        */
  real_T SDS_CBC_CMD_TX_Trigger_Value; /* Expression: 0
                                        * Referenced by: '<Root>/SDS_CBC_CMD_TX_Trigger'
                                        */
  uint8_T FixPtConstant_Value;         /* Computed Parameter: FixPtConstant_Value
                                        * Referenced by: '<S12>/FixPt Constant'
                                        */
  uint8_T Output_InitialCondition;     /* Computed Parameter: Output_InitialCondition
                                        * Referenced by: '<S10>/Output'
                                        */
  uint8_T Constant_Value;              /* Computed Parameter: Constant_Value
                                        * Referenced by: '<S13>/Constant'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_SDS_mod_v1_T {
  const char_T *errorStatus;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T taskTime0;
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    struct {
      uint8_T TID[2];
    } TaskCounters;

    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block parameters (default storage) */
extern P_SDS_mod_v1_T SDS_mod_v1_P;

/* Block signals (default storage) */
extern B_SDS_mod_v1_T SDS_mod_v1_B;

/* Block states (default storage) */
extern DW_SDS_mod_v1_T SDS_mod_v1_DW;

/* Model entry point functions */
extern void SDS_mod_v1_initialize(void);
extern void SDS_mod_v1_output(void);
extern void SDS_mod_v1_update(void);
extern void SDS_mod_v1_terminate(void);

/* Real-time Model object */
extern RT_MODEL_SDS_mod_v1_T *const SDS_mod_v1_M;

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
 * '<Root>' : 'SDS_mod_v1'
 * '<S1>'   : 'SDS_mod_v1/CAN_TYPE1_SETUP_M1_C1'
 * '<S2>'   : 'SDS_mod_v1/CBC_PT1'
 * '<S3>'   : 'SDS_mod_v1/CRC_is_OK1'
 * '<S4>'   : 'SDS_mod_v1/RTI Data'
 * '<S5>'   : 'SDS_mod_v1/SDS _CAN_Tx_Sub '
 * '<S6>'   : 'SDS_mod_v1/SDS_CBC_STAT'
 * '<S7>'   : 'SDS_mod_v1/RTI Data/RTI Data Store'
 * '<S8>'   : 'SDS_mod_v1/RTI Data/RTI Data Store/RTI Data Store'
 * '<S9>'   : 'SDS_mod_v1/RTI Data/RTI Data Store/RTI Data Store/RTI Data Store'
 * '<S10>'  : 'SDS_mod_v1/SDS _CAN_Tx_Sub /Counter Limited'
 * '<S11>'  : 'SDS_mod_v1/SDS _CAN_Tx_Sub /SDS_CBC_CMD'
 * '<S12>'  : 'SDS_mod_v1/SDS _CAN_Tx_Sub /Counter Limited/Increment Real World'
 * '<S13>'  : 'SDS_mod_v1/SDS _CAN_Tx_Sub /Counter Limited/Wrap To Zero'
 */
#endif                                 /* RTW_HEADER_SDS_mod_v1_h_ */
