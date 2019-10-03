/*
 * SDS_brk_cbc_v1.h
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

#ifndef RTW_HEADER_SDS_brk_cbc_v1_h_
#define RTW_HEADER_SDS_brk_cbc_v1_h_
#include <string.h>
#ifndef SDS_brk_cbc_v1_COMMON_INCLUDES_
# define SDS_brk_cbc_v1_COMMON_INCLUDES_
#include <brtenv.h>
#include <rtkernel.h>
#include <rti_assert.h>
#include <rtidefineddatatypes.h>
#include <rtican_ds1401.h>
#include <rtican_usercoding.h>
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#endif                                 /* SDS_brk_cbc_v1_COMMON_INCLUDES_ */

#include "SDS_brk_cbc_v1_types.h"

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
  real_T DataTypeConversion1;          /* '<S1>/Data Type Conversion1' */
  real_T Product;                      /* '<S1>/Product' */
  real_T DataTypeConversion;           /* '<S1>/Data Type Conversion' */
  real_T SFunction1_o1;                /* '<S8>/S-Function1' */
  real_T SFunction1_o2;                /* '<S8>/S-Function1' */
  real_T SFunction1_o3;                /* '<S8>/S-Function1' */
  real_T SFunction1_o4;                /* '<S8>/S-Function1' */
  real_T SFunction1_o5;                /* '<S8>/S-Function1' */
  real_T SFunction1_o6;                /* '<S8>/S-Function1' */
  real_T SFunction1_o7;                /* '<S8>/S-Function1' */
  real_T SFunction1_o8;                /* '<S8>/S-Function1' */
  real_T SFunction1_o9;                /* '<S8>/S-Function1' */
  real_T SFunction1_o10;               /* '<S8>/S-Function1' */
  real_T SFunction1_o11;               /* '<S8>/S-Function1' */
  real_T SFunction1_o12;               /* '<S8>/S-Function1' */
  real_T SFunction1_o1_o;              /* '<S9>/S-Function1' */
  real_T SFunction1_o2_l;              /* '<S9>/S-Function1' */
  real_T SFunction1_o3_p;              /* '<S9>/S-Function1' */
  real_T SFunction1_o4_d;              /* '<S9>/S-Function1' */
  real_T SFunction1_o5_k;              /* '<S9>/S-Function1' */
  real_T SFunction1_o6_l;              /* '<S9>/S-Function1' */
  real_T SFunction1_o7_m;              /* '<S9>/S-Function1' */
  real_T SFunction1_o8_m;              /* '<S9>/S-Function1' */
  real_T SFunction1_o9_d;              /* '<S9>/S-Function1' */
  real_T SFunction1_o10_p;             /* '<S9>/S-Function1' */
  real_T SFunction1_o11_p;             /* '<S9>/S-Function1' */
  real_T SFunction1_o12_l;             /* '<S9>/S-Function1' */
  real_T SFunction1_o13;               /* '<S9>/S-Function1' */
  real_T SFunction1_o14;               /* '<S9>/S-Function1' */
  real_T SFunction1_o15;               /* '<S9>/S-Function1' */
  real_T SFunction1_o16;               /* '<S9>/S-Function1' */
  real_T SFunction1_o17;               /* '<S9>/S-Function1' */
  real_T SFunction1_o18;               /* '<S9>/S-Function1' */
  real_T SFunction1_o19;               /* '<S9>/S-Function1' */
  real_T SFunction1_o20;               /* '<S9>/S-Function1' */
  real_T SFunction1_o21;               /* '<S9>/S-Function1' */
  real_T SFunction1_o1_b;              /* '<S10>/S-Function1' */
  real_T SFunction1_o2_o;              /* '<S10>/S-Function1' */
  real_T SFunction1_o3_pt;             /* '<S10>/S-Function1' */
  real_T SFunction1_o4_l;              /* '<S10>/S-Function1' */
  real_T SFunction1_o5_n;              /* '<S10>/S-Function1' */
  real_T SFunction1_o6_k;              /* '<S10>/S-Function1' */
  real_T SFunction1_o7_l;              /* '<S10>/S-Function1' */
  real_T SFunction1_o8_f;              /* '<S10>/S-Function1' */
  real_T SFunction1_o9_c;              /* '<S10>/S-Function1' */
  real_T SFunction1_o10_n;             /* '<S10>/S-Function1' */
  real_T SFunction1_o11_a;             /* '<S10>/S-Function1' */
  real_T SFunction1_o12_k;             /* '<S10>/S-Function1' */
  real_T SFunction1_o13_k;             /* '<S10>/S-Function1' */
  real_T SFunction1_o1_c;              /* '<S23>/S-Function1' */
  real_T SFunction1_o2_h;              /* '<S23>/S-Function1' */
  real_T SFunction1_o3_g;              /* '<S23>/S-Function1' */
  real_T SFunction1_o4_m;              /* '<S23>/S-Function1' */
  real_T SFunction1_o5_kp;             /* '<S23>/S-Function1' */
  real_T SFunction1_o6_b;              /* '<S23>/S-Function1' */
  real_T SFunction1_o7_g;              /* '<S23>/S-Function1' */
  real_T SFunction1_o8_g;              /* '<S23>/S-Function1' */
  real_T SFunction1_o9_o;              /* '<S23>/S-Function1' */
  real_T SFunction1_o10_o;             /* '<S23>/S-Function1' */
  real_T SFunction1_o11_h;             /* '<S23>/S-Function1' */
  real_T SFunction1_o12_f;             /* '<S23>/S-Function1' */
  real_T SFunction1_o13_l;             /* '<S23>/S-Function1' */
  real_T SFunction1_o14_n;             /* '<S23>/S-Function1' */
  real_T SFunction1_o15_p;             /* '<S23>/S-Function1' */
  real_T SFunction1_o16_h;             /* '<S23>/S-Function1' */
  real_T SFunction1_o17_o;             /* '<S23>/S-Function1' */
  real_T SFunction1_o18_k;             /* '<S23>/S-Function1' */
  real_T SFunction1_o19_j;             /* '<S23>/S-Function1' */
  real_T SFunction1_o20_l;             /* '<S23>/S-Function1' */
  real_T SFunction1_o21_g;             /* '<S23>/S-Function1' */
  real_T SFunction1_o22;               /* '<S23>/S-Function1' */
  real_T SFunction1_o23;               /* '<S23>/S-Function1' */
  real_T SFunction1_o24;               /* '<S23>/S-Function1' */
  real_T SFunction1_o25;               /* '<S23>/S-Function1' */
  real_T SFunction1_o26;               /* '<S23>/S-Function1' */
  real_T SFunction1_o1_a;              /* '<S26>/S-Function1' */
  real_T SFunction1_o2_n;              /* '<S26>/S-Function1' */
  real_T SFunction1_o3_a;              /* '<S26>/S-Function1' */
  real_T SFunction1_o4_b;              /* '<S26>/S-Function1' */
  real_T SFunction1_o5_f;              /* '<S26>/S-Function1' */
  real_T SFunction1_o6_d;              /* '<S26>/S-Function1' */
  real_T SFunction1_o7_f;              /* '<S26>/S-Function1' */
  real_T SFunction1_o8_o;              /* '<S26>/S-Function1' */
  real_T SFunction1_o9_p;              /* '<S26>/S-Function1' */
  real_T SFunction1_o10_i;             /* '<S26>/S-Function1' */
  real_T SFunction1_o11_f;             /* '<S26>/S-Function1' */
  real_T SFunction1_o12_c;             /* '<S26>/S-Function1' */
  real_T SFunction1_o13_o;             /* '<S26>/S-Function1' */
  real_T SFunction1_o14_i;             /* '<S26>/S-Function1' */
  real_T SFunction1_o15_a;             /* '<S26>/S-Function1' */
  real_T DataTypeConversion_b;         /* '<S25>/Data Type Conversion' */
  real_T HiddenBuf_InsertedFor_SDS_CBC_C;
  real_T SFunction1;                   /* '<S28>/S-Function1' */
  real_T SFunction1_o1_am;             /* '<S22>/S-Function1' */
  real_T SFunction1_o2_g;              /* '<S22>/S-Function1' */
  real_T SFunction1_o3_b;              /* '<S22>/S-Function1' */
  real_T SFunction1_o4_i;              /* '<S22>/S-Function1' */
  real_T DataTypeConversion1_b;        /* '<S11>/Data Type Conversion1' */
  real_T SFunction1_o1_e;              /* '<S19>/S-Function1' */
  real_T SFunction1_o2_i;              /* '<S19>/S-Function1' */
  real_T SFunction1_o3_f;              /* '<S19>/S-Function1' */
  real_T SFunction1_o4_h;              /* '<S19>/S-Function1' */
  real_T SFunction1_o1_l;              /* '<S18>/S-Function1' */
  real_T SFunction1_o2_f;              /* '<S18>/S-Function1' */
  real_T SFunction1_o3_l;              /* '<S18>/S-Function1' */
  real_T SFunction1_o4_k;              /* '<S18>/S-Function1' */
  uint8_T Output;                      /* '<S7>/Output' */
  uint8_T Output_k;                    /* '<S6>/Output' */
  uint8_T FixPtSum1;                   /* '<S13>/FixPt Sum1' */
  uint8_T FixPtSwitch;                 /* '<S14>/FixPt Switch' */
  uint8_T FixPtSum1_l;                 /* '<S15>/FixPt Sum1' */
  uint8_T FixPtSwitch_f;               /* '<S16>/FixPt Switch' */
  uint8_T Output_j;                    /* '<S27>/Output' */
  uint8_T FixPtSum1_n;                 /* '<S29>/FixPt Sum1' */
  uint8_T FixPtSwitch_g;               /* '<S30>/FixPt Switch' */
  uint8_T Output_n;                    /* '<S17>/Output' */
  uint8_T FixPtSum1_o;                 /* '<S20>/FixPt Sum1' */
  uint8_T FixPtSwitch_d;               /* '<S21>/FixPt Switch' */
  boolean_T Compare;                   /* '<S24>/Compare' */
} B_SDS_brk_cbc_v1_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  int_T SFunction1_IWORK[2];           /* '<S2>/S-Function1' */
  int_T SFunction1_IWORK_j[2];         /* '<S3>/S-Function1' */
  uint8_T Output_DSTATE;               /* '<S7>/Output' */
  uint8_T Output_DSTATE_c;             /* '<S6>/Output' */
  uint8_T Output_DSTATE_n;             /* '<S27>/Output' */
  uint8_T Output_DSTATE_cj;            /* '<S17>/Output' */
  boolean_T SDS_CAN_Tx_Sub_MODE;       /* '<S4>/SDS _CAN_Tx_Sub ' */
} DW_SDS_brk_cbc_v1_T;

/* Parameters (default storage) */
struct P_SDS_brk_cbc_v1_T_ {
  real_T CRC_is_OK1_const;             /* Mask Parameter: CRC_is_OK1_const
                                        * Referenced by: '<S24>/Constant'
                                        */
  uint8_T CounterLimited1_uplimit;     /* Mask Parameter: CounterLimited1_uplimit
                                        * Referenced by: '<S21>/FixPt Switch'
                                        */
  uint8_T CounterLimited_uplimit;      /* Mask Parameter: CounterLimited_uplimit
                                        * Referenced by: '<S30>/FixPt Switch'
                                        */
  uint8_T CounterLimited_uplimit_g;    /* Mask Parameter: CounterLimited_uplimit_g
                                        * Referenced by: '<S14>/FixPt Switch'
                                        */
  uint8_T CounterLimited1_uplimit_i;   /* Mask Parameter: CounterLimited1_uplimit_i
                                        * Referenced by: '<S16>/FixPt Switch'
                                        */
  real_T TXstatus_Y0;                  /* Computed Parameter: TXstatus_Y0
                                        * Referenced by: '<S18>/TX status'
                                        */
  real_T TXtime_Y0;                    /* Computed Parameter: TXtime_Y0
                                        * Referenced by: '<S18>/TX time'
                                        */
  real_T TXdeltatime_Y0;               /* Computed Parameter: TXdeltatime_Y0
                                        * Referenced by: '<S18>/TX delta time'
                                        */
  real_T TXdelaytime_Y0;               /* Computed Parameter: TXdelaytime_Y0
                                        * Referenced by: '<S18>/TX delay time'
                                        */
  real_T TXstatus_Y0_k;                /* Computed Parameter: TXstatus_Y0_k
                                        * Referenced by: '<S19>/TX status'
                                        */
  real_T TXtime_Y0_f;                  /* Computed Parameter: TXtime_Y0_f
                                        * Referenced by: '<S19>/TX time'
                                        */
  real_T TXdeltatime_Y0_k;             /* Computed Parameter: TXdeltatime_Y0_k
                                        * Referenced by: '<S19>/TX delta time'
                                        */
  real_T TXdelaytime_Y0_n;             /* Computed Parameter: TXdelaytime_Y0_n
                                        * Referenced by: '<S19>/TX delay time'
                                        */
  real_T CRC_SDS_Motion_Ref_Value;     /* Expression: 0
                                        * Referenced by: '<S11>/CRC_SDS_Motion_Ref'
                                        */
  real_T Long_Accel_sds_mot_ref_Value; /* Expression: 2077
                                        * Referenced by: '<S11>/Long_Accel_sds_mot_ref'
                                        */
  real_T Veh_Speed_sds_mot_ref_Value;  /* Expression: 0
                                        * Referenced by: '<S11>/Veh_Speed_sds_mot_ref'
                                        */
  real_T TXstatus_Y0_n;                /* Computed Parameter: TXstatus_Y0_n
                                        * Referenced by: '<S22>/TX status'
                                        */
  real_T TXtime_Y0_o;                  /* Computed Parameter: TXtime_Y0_o
                                        * Referenced by: '<S22>/TX time'
                                        */
  real_T TXdeltatime_Y0_n;             /* Computed Parameter: TXdeltatime_Y0_n
                                        * Referenced by: '<S22>/TX delta time'
                                        */
  real_T TXdelaytime_Y0_i;             /* Computed Parameter: TXdelaytime_Y0_i
                                        * Referenced by: '<S22>/TX delay time'
                                        */
  real_T TXstatus_Y0_b;                /* Computed Parameter: TXstatus_Y0_b
                                        * Referenced by: '<S28>/TX status'
                                        */
  real_T SDS_Engaged_State_Value;      /* Expression: 0
                                        * Referenced by: '<S1>/SDS_Engaged_State'
                                        */
  real_T DAS_EPB_APPY_RQ_Value;        /* Expression: 0
                                        * Referenced by: '<S1>/DAS_EPB_APPY_RQ'
                                        */
  real_T RHSC_OpenLoopBraking_Rq_Value;/* Expression: 0
                                        * Referenced by: '<S1>/RHSC_OpenLoopBraking_Rq'
                                        */
  real_T DAS_EPB_RELSE_RQ_Value;       /* Expression: 0
                                        * Referenced by: '<S1>/DAS_EPB_RELSE_RQ'
                                        */
  real_T LFC_Request_Type_Value;       /* Expression: 0
                                        * Referenced by: '<S1>/LFC_Request_Type'
                                        */
  real_T LFC_Request_Value;            /* Expression: 0
                                        * Referenced by: '<S1>/LFC_Request'
                                        */
  real_T MC_CANC3_DAS_A3_A_Value;      /* Expression: 1
                                        * Referenced by: '<S1>/MC_CANC3_DAS_A3_A'
                                        */
  real_T CRC_CCAN3_DAS_A3_A_Value;     /* Expression: 0
                                        * Referenced by: '<S1>/CRC_CCAN3_DAS_A3_A'
                                        */
  real_T SDS_Brk_TX_Trigger_Value;     /* Expression: 0
                                        * Referenced by: '<S1>/SDS_Brk_TX_Trigger'
                                        */
  real_T SDS_Motion_ref_Trigg_Value;   /* Expression: 1
                                        * Referenced by: '<S1>/SDS_Motion_ref_Trigg'
                                        */
  real_T Brk_PreFill_Rq_Value;         /* Expression: 0
                                        * Referenced by: '<S1>/Brk_PreFill_Rq'
                                        */
  real_T CRC_DAS_A3_A_Value;           /* Expression: 0
                                        * Referenced by: '<S1>/CRC_DAS_A3_A'
                                        */
  real_T SDS_CBC_IGNPOS_Value;         /* Expression: 4
                                        * Referenced by: '<S4>/SDS_CBC_IGNPOS'
                                        */
  real_T SDS_CBC_HiBmLvr_Value;        /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_HiBmLvr'
                                        */
  real_T SDS_CBC_HAZ_SW_Value;         /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_HAZ_SW'
                                        */
  real_T SDS_CBC_TRNI_1L_2R_0N_Value;  /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_TRN-I_1L_2R_0N'
                                        */
  real_T SDS_CBC_CMD3_Value;           /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_CMD3'
                                        */
  real_T SDS_CBC_Horn_Value;           /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_Horn'
                                        */
  real_T SDS_CBC_HDLP_Wash_Value;      /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_HDLP_Wash'
                                        */
  real_T SDS_CBC_WPR_Wash_Value;       /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_WPR_Wash'
                                        */
  real_T SDS_CBC_IP_Dimmer_Value;      /* Expression: 3
                                        * Referenced by: '<S4>/SDS_CBC_IP_Dimmer'
                                        */
  real_T SDS_CBC_HDLP_SW_Value;        /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_HDLP_SW'
                                        */
  real_T SDS_CBC_RFFunct_Value;        /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_RFFunct'
                                        */
  real_T SDS_CBC_WprWshSW_Value;       /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_WprWshSW'
                                        */
  real_T SDS_CBC_WPRSW_Value;          /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_WPRSW'
                                        */
  real_T SDS_CBC_OVERLAY_REQ_Value;    /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_OVERLAY_REQ'
                                        */
  real_T SDS_CBC_ConvLmpRst_Value;     /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_ConvLmpRst'
                                        */
  real_T RHSC_CRC_Value;               /* Expression: 0
                                        * Referenced by: '<S4>/RHSC_CRC'
                                        */
  real_T SDS_CBC_CMD_TX_Trigger_Value; /* Expression: 0
                                        * Referenced by: '<S4>/SDS_CBC_CMD_TX_Trigger'
                                        */
  uint8_T FixPtConstant_Value;         /* Computed Parameter: FixPtConstant_Value
                                        * Referenced by: '<S20>/FixPt Constant'
                                        */
  uint8_T Output_InitialCondition;     /* Computed Parameter: Output_InitialCondition
                                        * Referenced by: '<S17>/Output'
                                        */
  uint8_T Constant_Value;              /* Computed Parameter: Constant_Value
                                        * Referenced by: '<S21>/Constant'
                                        */
  uint8_T FixPtConstant_Value_k;       /* Computed Parameter: FixPtConstant_Value_k
                                        * Referenced by: '<S29>/FixPt Constant'
                                        */
  uint8_T Output_InitialCondition_i;   /* Computed Parameter: Output_InitialCondition_i
                                        * Referenced by: '<S27>/Output'
                                        */
  uint8_T Constant_Value_i;            /* Computed Parameter: Constant_Value_i
                                        * Referenced by: '<S30>/Constant'
                                        */
  uint8_T Output_InitialCondition_o;   /* Computed Parameter: Output_InitialCondition_o
                                        * Referenced by: '<S7>/Output'
                                        */
  uint8_T Output_InitialCondition_p;   /* Computed Parameter: Output_InitialCondition_p
                                        * Referenced by: '<S6>/Output'
                                        */
  uint8_T FixPtConstant_Value_j;       /* Computed Parameter: FixPtConstant_Value_j
                                        * Referenced by: '<S13>/FixPt Constant'
                                        */
  uint8_T Constant_Value_h;            /* Computed Parameter: Constant_Value_h
                                        * Referenced by: '<S14>/Constant'
                                        */
  uint8_T FixPtConstant_Value_a;       /* Computed Parameter: FixPtConstant_Value_a
                                        * Referenced by: '<S15>/FixPt Constant'
                                        */
  uint8_T Constant_Value_hb;           /* Computed Parameter: Constant_Value_hb
                                        * Referenced by: '<S16>/Constant'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_SDS_brk_cbc_v1_T {
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
      uint8_T TID[3];
    } TaskCounters;

    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block parameters (default storage) */
extern P_SDS_brk_cbc_v1_T SDS_brk_cbc_v1_P;

/* Block signals (default storage) */
extern B_SDS_brk_cbc_v1_T SDS_brk_cbc_v1_B;

/* Block states (default storage) */
extern DW_SDS_brk_cbc_v1_T SDS_brk_cbc_v1_DW;

/* Model entry point functions */
extern void SDS_brk_cbc_v1_initialize(void);
extern void SDS_brk_cbc_v1_output(void);
extern void SDS_brk_cbc_v1_update(void);
extern void SDS_brk_cbc_v1_terminate(void);

/* Real-time Model object */
extern RT_MODEL_SDS_brk_cbc_v1_T *const SDS_brk_cbc_v1_M;

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
 * '<Root>' : 'SDS_brk_cbc_v1'
 * '<S1>'   : 'SDS_brk_cbc_v1/Brakes'
 * '<S2>'   : 'SDS_brk_cbc_v1/CAN_TYPE1_SETUP_M1_C1'
 * '<S3>'   : 'SDS_brk_cbc_v1/CAN_TYPE1_SETUP_M1_C2'
 * '<S4>'   : 'SDS_brk_cbc_v1/CBC'
 * '<S5>'   : 'SDS_brk_cbc_v1/RTI Data'
 * '<S6>'   : 'SDS_brk_cbc_v1/Brakes/Counter Limited'
 * '<S7>'   : 'SDS_brk_cbc_v1/Brakes/Counter Limited1'
 * '<S8>'   : 'SDS_brk_cbc_v1/Brakes/DAS_A3_A1'
 * '<S9>'   : 'SDS_brk_cbc_v1/Brakes/EBCM_C1'
 * '<S10>'  : 'SDS_brk_cbc_v1/Brakes/ESP_B5'
 * '<S11>'  : 'SDS_brk_cbc_v1/Brakes/ccan3_DAS_A3_A_tx1'
 * '<S12>'  : 'SDS_brk_cbc_v1/Brakes/ccan_DAS_A3_A_tx'
 * '<S13>'  : 'SDS_brk_cbc_v1/Brakes/Counter Limited/Increment Real World'
 * '<S14>'  : 'SDS_brk_cbc_v1/Brakes/Counter Limited/Wrap To Zero'
 * '<S15>'  : 'SDS_brk_cbc_v1/Brakes/Counter Limited1/Increment Real World'
 * '<S16>'  : 'SDS_brk_cbc_v1/Brakes/Counter Limited1/Wrap To Zero'
 * '<S17>'  : 'SDS_brk_cbc_v1/Brakes/ccan3_DAS_A3_A_tx1/Counter Limited1'
 * '<S18>'  : 'SDS_brk_cbc_v1/Brakes/ccan3_DAS_A3_A_tx1/DAS_A3_A'
 * '<S19>'  : 'SDS_brk_cbc_v1/Brakes/ccan3_DAS_A3_A_tx1/SDS_Motion_Ref'
 * '<S20>'  : 'SDS_brk_cbc_v1/Brakes/ccan3_DAS_A3_A_tx1/Counter Limited1/Increment Real World'
 * '<S21>'  : 'SDS_brk_cbc_v1/Brakes/ccan3_DAS_A3_A_tx1/Counter Limited1/Wrap To Zero'
 * '<S22>'  : 'SDS_brk_cbc_v1/Brakes/ccan_DAS_A3_A_tx/DAS_A3_A'
 * '<S23>'  : 'SDS_brk_cbc_v1/CBC/CBC_PT1'
 * '<S24>'  : 'SDS_brk_cbc_v1/CBC/CRC_is_OK1'
 * '<S25>'  : 'SDS_brk_cbc_v1/CBC/SDS _CAN_Tx_Sub '
 * '<S26>'  : 'SDS_brk_cbc_v1/CBC/SDS_CBC_STAT'
 * '<S27>'  : 'SDS_brk_cbc_v1/CBC/SDS _CAN_Tx_Sub /Counter Limited'
 * '<S28>'  : 'SDS_brk_cbc_v1/CBC/SDS _CAN_Tx_Sub /SDS_CBC_CMD'
 * '<S29>'  : 'SDS_brk_cbc_v1/CBC/SDS _CAN_Tx_Sub /Counter Limited/Increment Real World'
 * '<S30>'  : 'SDS_brk_cbc_v1/CBC/SDS _CAN_Tx_Sub /Counter Limited/Wrap To Zero'
 * '<S31>'  : 'SDS_brk_cbc_v1/RTI Data/RTI Data Store'
 * '<S32>'  : 'SDS_brk_cbc_v1/RTI Data/RTI Data Store/RTI Data Store'
 * '<S33>'  : 'SDS_brk_cbc_v1/RTI Data/RTI Data Store/RTI Data Store/RTI Data Store'
 */
#endif                                 /* RTW_HEADER_SDS_brk_cbc_v1_h_ */
