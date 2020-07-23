/*********************** dSPACE target specific file *************************

   Include file SDS_brk_cbc_v1_rti.c:

   Definition of functions and variables for the system I/O and for
   the hardware and software interrupts used.

   RTI1401 7.10 (02-May-2018)
   Wed Oct  2 20:12:13 2019

   Copyright 2019, dSPACE GmbH. All rights reserved.

 *****************************************************************************/

#if !(defined(__RTI_SIMENGINE__) || defined(RTIMP_FRAME))
# error This file may be included only by the RTI(-MP) simulation engine.
#endif

/* Include the model header file. */
#include "SDS_brk_cbc_v1.h"
#include "SDS_brk_cbc_v1_private.h"

/* Defines for block output and parameter structure existence */
#define RTI_rtB_STRUCTURE_EXISTS       1
#define RTI_rtP_STRUCTURE_EXISTS       1
#define RTB_STRUCTURE_NAME             SDS_brk_cbc_v1_B
#define RTP_STRUCTURE_NAME             SDS_brk_cbc_v1_P

/* dSPACE generated includes for header files */
#include <brtenv.h>
#include <rtkernel.h>
#include <rti_assert.h>
#include <rtidefineddatatypes.h>
#include <rtican_ds1401.h>
#include <rtican_usercoding.h>
#ifndef dsRtmGetNumSampleTimes
# define dsRtmGetNumSampleTimes(rtm)   3
#endif

#ifndef dsRtmSetTaskTime
#define dsRtmSetTaskTime(rtm, sti, val) (((rtm)->Timing.taskTime0) = (val))
#endif

/****** Definitions: task functions for timer tasks *********************/

/* Timer Task 1. (Base rate). */
static void rti_TIMERA(rtk_p_task_control_block task)
{
  /* Task entry code BEGIN */
  /* -- None. -- */
  /* Task entry code END */

  /* Task code. */
  baseRateService(task);

  /* Task exit code BEGIN */
  /* -- None. -- */
  /* Task exit code END */
}

/* ===== Declarations of RTI blocks ======================================== */

/* dSPACE I/O Board DS1_RTICAN #1 */

/* ...  definition of channel struct */
can_tp1_canChannel* can_type1_channel_M1_C2;

/* ...  definition of channel struct */
can_tp1_canChannel* can_type1_channel_M1_C1;

/* declare pointers to CAN message structures for support of TX-Custom code */
can_tp1_canMsg* CANTP1_TX_SPMSG_M1_C2_STD;
can_tp1_canMsg* CANTP1_TX_SPMSG_M1_C2_XTD;

/* declare pointers to CAN message structures for support of TX-Custom code */
can_tp1_canMsg* CANTP1_TX_SPMSG_M1_C1_STD;
can_tp1_canMsg* CANTP1_TX_SPMSG_M1_C1_XTD;

/* ... definition of message variable for the RTICAN blocks */
can_tp1_canMsg* can_type1_msg_M1[CANTP1_M1_NUMMSG];

/* dSPACE I/O Board RTICAN_GLOBAL #0 */

/* ===== Definition of interface functions for simulation engine =========== */
#if GRTINTERFACE == 1
#ifdef MULTITASKING
# define dsIsSampleHit(RTM,sti)        rtmGetSampleHitPtr(RTM)[sti]
#else
# define dsIsSampleHit(RTM,sti)        rtmIsSampleHit(RTM,sti,0)
#endif

#else
#ifndef rtmStepTask
# define rtmStepTask(rtm, idx)         ((rtm)->Timing.TaskCounters.TID[(idx)] == 0)
#endif

# define dsIsSampleHit(RTM,sti)        rtmStepTask(RTM, sti)
#endif

#undef __INLINE
#if defined(_INLINE)
# define __INLINE                      static inline
#else
# define __INLINE                      static
#endif

/*Define additional variables*/
static time_T dsTFinal = -1.0;

#define dsGetTFinal(rtm)               (dsTFinal)

static time_T dsStepSize = 0.001;

# define dsGetStepSize(rtm)            (dsStepSize)

static void rti_mdl_initialize_host_services(void)
{
  ts_timestamp_type ts = { 0, 0 };

  host_service(1, &ts);
  DsDaq_Init(0, 32, 1);
}

static void rti_mdl_initialize_io_boards(void)
{
  /* Registering of RTI products and modules at VCM */
  {
    vcm_module_register(VCM_MID_RTI1401, (void *) 0,
                        VCM_TXT_RTI1401, 7, 10, 0,
                        VCM_VERSION_RELEASE, 0, 0, 0, VCM_CTRL_NO_ST);

    {
      vcm_module_descriptor_type* msg_mod_ptr;
      msg_mod_ptr = vcm_module_register(VCM_MID_MATLAB, (void *) 0,
        VCM_TXT_MATLAB, 9, 5, 0,
        VCM_VERSION_RELEASE, 0, 0, 0, VCM_CTRL_NO_ST);
      vcm_module_register(VCM_MID_SIMULINK, msg_mod_ptr,
                          VCM_TXT_SIMULINK, 9, 2, 0,
                          VCM_VERSION_RELEASE, 0, 0, 0, VCM_CTRL_NO_ST);
      vcm_module_register(VCM_MID_RTW, msg_mod_ptr,
                          VCM_TXT_RTW, 9, 0, 0,
                          VCM_VERSION_RELEASE, 0, 0, 0, VCM_CTRL_NO_ST);
    }

    vcm_module_register(VCM_MID_RTICAN, (void *) 0,
                        VCM_TXT_RTICAN, 3, 4, 6,
                        VCM_VERSION_RELEASE, 0, 0, 0, VCM_CTRL_NO_ST);
  }

  /* dSPACE I/O Board DS1_RTICAN #1 */
  /* Initialization of DS1501 board */
  can_tp1_communication_init(can_tp1_address_table[0].module_addr,
    CAN_TP1_INT_ENABLE);

  /* dSPACE RTICAN MASTER SETUP Block */
  /* ... Initialize the CAN communication: 500 kbit/s */
  can_type1_channel_M1_C2 = can_tp1_channel_init(can_tp1_address_table[0].
    module_addr, 1, (500 * 1000), CAN_TP1_STD, CAN_TP1_NO_SUBINT);
  can_tp1_channel_termination_set(can_type1_channel_M1_C2,
    CAN_TP1_TERMINATION_ON);

  /* ... Initialize TX message structs for custom code  */
  CANTP1_TX_SPMSG_M1_C2_STD = can_tp1_msg_tx_register(can_type1_channel_M1_C2, 3,
    1050, CAN_TP1_STD, CAN_TP1_TIMECOUNT_INFO | CAN_TP1_DELAYCOUNT_INFO |
    CAN_TP1_MSG_INFO, CAN_TP1_NO_SUBINT, 0, CAN_TP1_TRIGGER_MSG,
    CAN_TP1_TIMEOUT_NORMAL);
  CANTP1_TX_SPMSG_M1_C2_XTD = can_tp1_msg_tx_register(can_type1_channel_M1_C2, 3,
    1100, CAN_TP1_EXT, CAN_TP1_TIMECOUNT_INFO | CAN_TP1_DELAYCOUNT_INFO |
    CAN_TP1_MSG_INFO, CAN_TP1_NO_SUBINT, 0, CAN_TP1_TRIGGER_MSG,
    CAN_TP1_TIMEOUT_NORMAL);

  /* dSPACE RTICAN MASTER SETUP Block */
  /* ... Initialize the Partial Networking Settings */

  /* dSPACE RTICAN TX Message Block: "DAS_A3_A" Id:499 */
  /* ... Register message */
  can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3] = can_tp1_msg_tx_register
    (can_type1_channel_M1_C2, 0, 499, CAN_TP1_STD, (CAN_TP1_TIMECOUNT_INFO|
      CAN_TP1_TIMECOUNT_INFO|CAN_TP1_TIMECOUNT_INFO|CAN_TP1_DELAYCOUNT_INFO),
     CAN_TP1_NO_SUBINT, 0, 0.01, CAN_TP1_TIMEOUT_NORMAL);

  /* dSPACE RTICAN TX Message Block: "SDS_Motion_Ref" Id:298 */
  /* ... Register message */
  can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A] = can_tp1_msg_tx_register
    (can_type1_channel_M1_C2, 0, 298, CAN_TP1_STD, (CAN_TP1_TIMECOUNT_INFO|
      CAN_TP1_TIMECOUNT_INFO|CAN_TP1_TIMECOUNT_INFO|CAN_TP1_DELAYCOUNT_INFO),
     CAN_TP1_NO_SUBINT, 0, 0.01, CAN_TP1_TIMEOUT_NORMAL);

  /* dSPACE RTICAN MASTER SETUP Block */
  /* ... Initialize the CAN communication: 500 kbit/s */
  can_type1_channel_M1_C1 = can_tp1_channel_init(can_tp1_address_table[0].
    module_addr, 0, (500 * 1000), CAN_TP1_STD, CAN_TP1_NO_SUBINT);
  can_tp1_channel_termination_set(can_type1_channel_M1_C1,
    CAN_TP1_TERMINATION_ON);

  /* ... Initialize TX message structs for custom code  */
  CANTP1_TX_SPMSG_M1_C1_STD = can_tp1_msg_tx_register(can_type1_channel_M1_C1, 3,
    1050, CAN_TP1_STD, CAN_TP1_TIMECOUNT_INFO | CAN_TP1_DELAYCOUNT_INFO |
    CAN_TP1_MSG_INFO, CAN_TP1_NO_SUBINT, 0, CAN_TP1_TRIGGER_MSG,
    CAN_TP1_TIMEOUT_NORMAL);
  CANTP1_TX_SPMSG_M1_C1_XTD = can_tp1_msg_tx_register(can_type1_channel_M1_C1, 3,
    1100, CAN_TP1_EXT, CAN_TP1_TIMECOUNT_INFO | CAN_TP1_DELAYCOUNT_INFO |
    CAN_TP1_MSG_INFO, CAN_TP1_NO_SUBINT, 0, CAN_TP1_TRIGGER_MSG,
    CAN_TP1_TIMEOUT_NORMAL);

  /* dSPACE RTICAN MASTER SETUP Block */
  /* ... Initialize the Partial Networking Settings */

  /* dSPACE RTICAN TX Message Block: "DAS_A3_A" Id:499 */
  /* ... Register message */
  can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3] = can_tp1_msg_tx_register
    (can_type1_channel_M1_C1, 0, 499, CAN_TP1_STD, (CAN_TP1_TIMECOUNT_INFO|
      CAN_TP1_TIMECOUNT_INFO|CAN_TP1_TIMECOUNT_INFO|CAN_TP1_DELAYCOUNT_INFO),
     CAN_TP1_NO_SUBINT, 0, 0.01, CAN_TP1_TIMEOUT_NORMAL);

  /* dSPACE RTICAN TX Message Block: "SDS_CBC_CMD" Id:857 */
  /* ... Register message */
  can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359] = can_tp1_msg_tx_register
    (can_type1_channel_M1_C1, 4, 857, CAN_TP1_STD, (CAN_TP1_TIMECOUNT_INFO),
     CAN_TP1_NO_SUBINT, 6, 0.1, CAN_TP1_TIMEOUT_NORMAL);

  /* dSPACE RTICAN RX Message Block: "DAS_A3_A" Id:499 */
  /* ... Register message */
  can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3] = can_tp1_msg_rx_register
    (can_type1_channel_M1_C1, 0, 499, CAN_TP1_STD, (CAN_TP1_DATA_INFO|
      CAN_TP1_DATA_INFO|CAN_TP1_TIMECOUNT_INFO|CAN_TP1_TIMECOUNT_INFO),
     CAN_TP1_NO_SUBINT);

  /* dSPACE RTICAN RX Message Block: "EBCM_C1" Id:653 */
  /* ... Register message */
  can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D] = can_tp1_msg_rx_register
    (can_type1_channel_M1_C1, 1, 653, CAN_TP1_STD, (CAN_TP1_DATA_INFO|
      CAN_TP1_DATA_INFO|CAN_TP1_TIMECOUNT_INFO|CAN_TP1_TIMECOUNT_INFO),
     CAN_TP1_NO_SUBINT);

  /* dSPACE RTICAN RX Message Block: "ESP_B5" Id:682 */
  /* ... Register message */
  can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA] = can_tp1_msg_rx_register
    (can_type1_channel_M1_C1, 2, 682, CAN_TP1_STD, (CAN_TP1_DATA_INFO|
      CAN_TP1_DATA_INFO|CAN_TP1_TIMECOUNT_INFO|CAN_TP1_TIMECOUNT_INFO),
     CAN_TP1_NO_SUBINT);

  /* dSPACE RTICAN RX Message Block: "CBC_PT1" Id:820 */
  /* ... Register message */
  can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334] = can_tp1_msg_rx_register
    (can_type1_channel_M1_C1, 3, 820, CAN_TP1_STD, (CAN_TP1_DATA_INFO|
      CAN_TP1_DATA_INFO|CAN_TP1_TIMECOUNT_INFO|CAN_TP1_TIMECOUNT_INFO),
     CAN_TP1_NO_SUBINT);

  /* dSPACE RTICAN RX Message Block: "SDS_CBC_STAT" Id:858 */
  /* ... Register message */
  can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A] = can_tp1_msg_rx_register
    (can_type1_channel_M1_C1, 5, 858, CAN_TP1_STD, (CAN_TP1_DATA_INFO|
      CAN_TP1_DATA_INFO|CAN_TP1_TIMECOUNT_INFO|CAN_TP1_TIMECOUNT_INFO),
     CAN_TP1_NO_SUBINT);

  /* dSPACE RTICAN RX Message Block: "DAS_A3_A" Id:499 */
  SDS_brk_cbc_v1_B.SFunction1_o10 = 0; /* processed - flag */
  SDS_brk_cbc_v1_B.SFunction1_o11 = 0; /* timestamp */
  SDS_brk_cbc_v1_B.SFunction1_o12 = 0; /* deltatime */

  /* dSPACE RTICAN RX Message Block: "EBCM_C1" Id:653 */
  SDS_brk_cbc_v1_B.SFunction1_o19 = 0; /* processed - flag */
  SDS_brk_cbc_v1_B.SFunction1_o20 = 0; /* timestamp */
  SDS_brk_cbc_v1_B.SFunction1_o21 = 0; /* deltatime */

  /* dSPACE RTICAN RX Message Block: "ESP_B5" Id:682 */
  SDS_brk_cbc_v1_B.SFunction1_o11_a = 0;/* processed - flag */
  SDS_brk_cbc_v1_B.SFunction1_o12_k = 0;/* timestamp */
  SDS_brk_cbc_v1_B.SFunction1_o13_k = 0;/* deltatime */

  /* dSPACE RTICAN RX Message Block: "CBC_PT1" Id:820 */
  SDS_brk_cbc_v1_B.SFunction1_o24 = 0; /* processed - flag */
  SDS_brk_cbc_v1_B.SFunction1_o25 = 0; /* timestamp */
  SDS_brk_cbc_v1_B.SFunction1_o26 = 0; /* deltatime */

  /* dSPACE RTICAN RX Message Block: "SDS_CBC_STAT" Id:858 */
  SDS_brk_cbc_v1_B.SFunction1_o12_c = 0;/* processed - flag */
  SDS_brk_cbc_v1_B.SFunction1_o13_o = 0;/* timestamp */
  SDS_brk_cbc_v1_B.SFunction1_o14_i = 0;/* deltatime */

  /* dSPACE I/O Board RTICAN_GLOBAL #0 */
}

/* Function rti_mdl_slave_load() is empty */
#define rti_mdl_slave_load()

/* Function rti_mdl_rtk_initialize() is empty */
#define rti_mdl_rtk_initialize()

static void rti_mdl_initialize_io_units(void)
{
  /* dSPACE I/O Board DS1_RTICAN #1 */
  /* Start CAN controller */
  can_tp1_channel_start(can_type1_channel_M1_C2, CAN_TP1_INT_DISABLE);

  /* Start CAN controller */
  can_tp1_channel_start(can_type1_channel_M1_C1, CAN_TP1_INT_DISABLE);

  /* Set the type1CAN error level */
  rtican_type1_error_level = 0;

  /* ... Reset all taskqueue-specific error variables */
  rtican_type1_tq_err_all_reset(0);

  /* ... Clear all message data buffers */
  can_tp1_all_data_clear(can_tp1_address_table[0].module_addr);

  {
    static UInt32 numInit = 0;
    if (numInit != 0) {
      /* ... Wake message up */
      while ((rtican_type1_tq_error[0][0] = can_tp1_msg_wakeup
              (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3])) ==
             DSMCOM_BUFFER_OVERFLOW) ;
    }

    ++numInit;
  }

  {
    static UInt32 numInit = 0;
    if (numInit != 0) {
      /* ... Wake message up */
      while ((rtican_type1_tq_error[0][0] = can_tp1_msg_wakeup
              (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A])) ==
             DSMCOM_BUFFER_OVERFLOW) ;
    }

    ++numInit;
  }

  {
    static UInt32 numInit = 0;
    if (numInit != 0) {
      /* ... Wake message up */
      while ((rtican_type1_tq_error[0][0] = can_tp1_msg_wakeup
              (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3])) ==
             DSMCOM_BUFFER_OVERFLOW) ;
    }

    ++numInit;
  }

  {
    static UInt32 numInit = 0;
    if (numInit != 0) {
      /* ... Wake message up */
      while ((rtican_type1_tq_error[0][4] = can_tp1_msg_wakeup
              (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359])) ==
             DSMCOM_BUFFER_OVERFLOW) ;
    }

    ++numInit;
  }

  {
    static UInt32 numInit = 0;
    if (numInit != 0) {
      /* ... Wake message up */
      while ((rtican_type1_tq_error[0][0] = can_tp1_msg_wakeup
              (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3])) ==
             DSMCOM_BUFFER_OVERFLOW) ;
    }

    ++numInit;
  }

  {
    static UInt32 numInit = 0;
    if (numInit != 0) {
      /* ... Wake message up */
      while ((rtican_type1_tq_error[0][1] = can_tp1_msg_wakeup
              (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D])) ==
             DSMCOM_BUFFER_OVERFLOW) ;
    }

    ++numInit;
  }

  {
    static UInt32 numInit = 0;
    if (numInit != 0) {
      /* ... Wake message up */
      while ((rtican_type1_tq_error[0][2] = can_tp1_msg_wakeup
              (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA])) ==
             DSMCOM_BUFFER_OVERFLOW) ;
    }

    ++numInit;
  }

  {
    static UInt32 numInit = 0;
    if (numInit != 0) {
      /* ... Wake message up */
      while ((rtican_type1_tq_error[0][3] = can_tp1_msg_wakeup
              (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334])) ==
             DSMCOM_BUFFER_OVERFLOW) ;
    }

    ++numInit;
  }

  {
    static UInt32 numInit = 0;
    if (numInit != 0) {
      /* ... Wake message up */
      while ((rtican_type1_tq_error[0][5] = can_tp1_msg_wakeup
              (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A])) ==
             DSMCOM_BUFFER_OVERFLOW) ;
    }

    ++numInit;
  }
}

/* Function rti_mdl_acknowledge_interrupts() is empty */
#define rti_mdl_acknowledge_interrupts()

/* Function rti_mdl_timetables_register() is empty */
#define rti_mdl_timetables_register()

/* Function rti_mdl_timesync_simstate() is empty */
#define rti_mdl_timesync_simstate()

/* Function rti_mdl_timesync_baserate() is empty */
#define rti_mdl_timesync_baserate()

static void rti_mdl_background(void)
{
  /* DsDaq background call */
  DsDaq_Background(0);

  /* dSPACE I/O Board DS1_RTICAN #1 */
  {
    real_T bg_code_exec_time;
    static real_T bg_code_last_exec_time = 0.0;
    bg_code_exec_time = RTLIB_TIC_READ();
    if ((bg_code_exec_time - bg_code_last_exec_time) > 0.25 ||
        (bg_code_exec_time - bg_code_last_exec_time) < 0) {
      /* ... Check taskqueue-specific error variables */
      rtican_type1_tq_err_all_chk(can_tp1_address_table[0].module_addr, 0);
      bg_code_last_exec_time = bg_code_exec_time;
    }
  }

  /* copy DPMEM - buffers in background */
  {
    /* call update function for CAN Tp1 CAN interface (module number: 1) */
    can_tp1_msg_copy_all_to_mem(can_tp1_address_table[0].module_addr);
  }
}

__INLINE void rti_mdl_sample_input(void)
{
  /* Calls for base sample time: [0.001, 0.0] */
  /* dSPACE I/O Board DS1_RTICAN #1 Unit:DEFAULT */
  /* call update function for CAN Tp1 CAN interface (module number: 1) */
  can_tp1_msg_copy_all_to_mem(can_tp1_address_table[0].module_addr);
}

static void rti_mdl_daq_service()
{
  /* dSPACE Host Service */
  host_service(1, rtk_current_task_absolute_time_ptr_get());
  DsDaq_Service(0, 0, 1, (DsDaqSTimestampStruct *)
                rtk_current_task_absolute_time_ptr_get());
}

#undef __INLINE

/****** [EOF] ****************************************************************/
