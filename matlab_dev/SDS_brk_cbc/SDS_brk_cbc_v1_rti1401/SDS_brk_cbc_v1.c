/*
 * SDS_brk_cbc_v1.c
 *
 * Code generation for model "SDS_brk_cbc_v1".
 *
 * Model version              : 1.66
 * Simulink Coder version : 9.0 (R2018b) 24-May-2018
 * C source code generated on : Wed Oct  2 20:12:13 2019
 *
 * Target selection: rti1401.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Custom Processor->Custom
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "SDS_brk_cbc_v1_trc_ptr.h"
#include "SDS_brk_cbc_v1.h"
#include "SDS_brk_cbc_v1_private.h"

/* Block signals (default storage) */
B_SDS_brk_cbc_v1_T SDS_brk_cbc_v1_B;

/* Block states (default storage) */
DW_SDS_brk_cbc_v1_T SDS_brk_cbc_v1_DW;

/* Real-time model */
RT_MODEL_SDS_brk_cbc_v1_T SDS_brk_cbc_v1_M_;
RT_MODEL_SDS_brk_cbc_v1_T *const SDS_brk_cbc_v1_M = &SDS_brk_cbc_v1_M_;
static void rate_scheduler(void);

/*
 *   This function updates active task flag for each subrate.
 * The function is called at model base rate, hence the
 * generated code self-manages all its subrates.
 */
static void rate_scheduler(void)
{
  /* Compute which subrates run during the next base time step.  Subrates
   * are an integer multiple of the base rate counter.  Therefore, the subtask
   * counter is reset when it reaches its limit (zero means run).
   */
  (SDS_brk_cbc_v1_M->Timing.TaskCounters.TID[1])++;
  if ((SDS_brk_cbc_v1_M->Timing.TaskCounters.TID[1]) > 9) {/* Sample time: [0.01s, 0.0s] */
    SDS_brk_cbc_v1_M->Timing.TaskCounters.TID[1] = 0;
  }

  (SDS_brk_cbc_v1_M->Timing.TaskCounters.TID[2])++;
  if ((SDS_brk_cbc_v1_M->Timing.TaskCounters.TID[2]) > 99) {/* Sample time: [0.1s, 0.0s] */
    SDS_brk_cbc_v1_M->Timing.TaskCounters.TID[2] = 0;
  }
}

/* Model output function */
void SDS_brk_cbc_v1_output(void)
{
  if (SDS_brk_cbc_v1_M->Timing.TaskCounters.TID[1] == 0) {
    /* UnitDelay: '<S7>/Output' */
    SDS_brk_cbc_v1_B.Output = SDS_brk_cbc_v1_DW.Output_DSTATE;

    /* DataTypeConversion: '<S1>/Data Type Conversion1' */
    SDS_brk_cbc_v1_B.DataTypeConversion1 = SDS_brk_cbc_v1_B.Output;

    /* Product: '<S1>/Product' incorporates:
     *  Constant: '<S1>/MC_CANC3_DAS_A3_A'
     */
    SDS_brk_cbc_v1_B.Product = SDS_brk_cbc_v1_P.MC_CANC3_DAS_A3_A_Value *
      SDS_brk_cbc_v1_B.DataTypeConversion1;

    /* Outputs for Enabled SubSystem: '<S1>/ccan3_DAS_A3_A_tx1' incorporates:
     *  EnablePort: '<S11>/Enable'
     */
    /* Constant: '<S1>/SDS_Brk_TX_Trigger' */
    if (SDS_brk_cbc_v1_P.SDS_Brk_TX_Trigger_Value > 0.0) {
      /* Outputs for Enabled SubSystem: '<S11>/DAS_A3_A' incorporates:
       *  EnablePort: '<S18>/Enable'
       */
      if (SDS_brk_cbc_v1_P.SDS_Brk_TX_Trigger_Value > 0.0) {
        /* S-Function (rti_commonblock): '<S18>/S-Function1' incorporates:
         *  Constant: '<S1>/CRC_CCAN3_DAS_A3_A'
         *  Constant: '<S1>/DAS_EPB_APPY_RQ'
         *  Constant: '<S1>/DAS_EPB_RELSE_RQ'
         *  Constant: '<S1>/LFC_Request'
         *  Constant: '<S1>/LFC_Request_Type'
         *  Constant: '<S1>/RHSC_OpenLoopBraking_Rq'
         *  Constant: '<S1>/SDS_Engaged_State'
         */
        /* This comment workarounds a code generation problem */

        /* dSPACE RTICAN TX Message Block: "DAS_A3_A" Id:499 */
        {
          UInt32 CAN_Msg[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

          Float32 delayTime = 0.0;

          /* ... Read status and timestamp info (previous message) */
          can_tp1_msg_read(can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]);

          /* Convert timestamp */
          if (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]->processed) {
            can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]->timestamp =
              rtk_dsts_time_to_simtime_convert
              (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]->timestamp);
          }

          /* Messages with timestamp zero have been received in pause/stop state
             and must not be handled.
           */
          if (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]->timestamp > 0.0) {
            SDS_brk_cbc_v1_B.SFunction1_o1_l = (real_T)
              can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]->processed;
            SDS_brk_cbc_v1_B.SFunction1_o2_f = (real_T)
              can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]->timestamp;
            SDS_brk_cbc_v1_B.SFunction1_o3_l = (real_T)
              can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]->deltatime;
            SDS_brk_cbc_v1_B.SFunction1_o4_k = (real_T)
              can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]->delaytime;
          }

          /* ... Encode Simulink signals of TX and RM blocks*/
          {
            rtican_Signal_t CAN_Sgn;

            /* ...... "SDS_Engaged_State" (1|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_Engaged_State_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 1;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "DAS_EPB_APPLY_RQ" (3|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.DAS_EPB_APPY_RQ_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 3;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "RHSC_OpenLoopBraking_Rq" (4|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.RHSC_OpenLoopBraking_Rq_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "DAS_EPB_RELSE_RQ" (5|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.DAS_EPB_RELSE_RQ_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 5;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "LFC_Request_Type" (6|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.LFC_Request_Type_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 6;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "LFC_Request" (17|15, standard signal, unsigned int, motorola back.) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_brk_cbc_v1_P.LFC_Request_Value
              - ( -65534 ) ) / 2 + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00007FFF;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 1;
            CAN_Msg[5] |= CAN_Sgn.SgnBytes.Byte0;
            CAN_Msg[4] |= CAN_Sgn.SgnBytes.Byte1;

            /* ...... "MC_DAS_A3_A" (52|4, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_brk_cbc_v1_B.Product ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x0000000F;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[6] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "CRC_DAS_A3_A" (56|8, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.CRC_CCAN3_DAS_A3_A_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x000000FF;
            CAN_Msg[7] |= CAN_Sgn.SgnBytes.Byte0;
          }

          /* Call user written decoding function  */
          can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]->datalen = 8;

          {
            Message_CRC_Encoder(CAN_Msg,
                                can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]);
          }

          /* ... Write the data to the CAN microcontroller */
          can_tp1_msg_write(can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3], abs
                            (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]
                             ->datalen) > 8 ? 8 : abs
                            (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3]
                             ->datalen), &(CAN_Msg[0]));

          /* ... Auto Repeat Time option selected -> no trigger needed */
        }
      }

      /* End of Outputs for SubSystem: '<S11>/DAS_A3_A' */

      /* UnitDelay: '<S17>/Output' */
      SDS_brk_cbc_v1_B.Output_n = SDS_brk_cbc_v1_DW.Output_DSTATE_cj;

      /* Sum: '<S20>/FixPt Sum1' incorporates:
       *  Constant: '<S20>/FixPt Constant'
       */
      SDS_brk_cbc_v1_B.FixPtSum1_o = (uint8_T)((uint32_T)
        SDS_brk_cbc_v1_B.Output_n + SDS_brk_cbc_v1_P.FixPtConstant_Value);

      /* Switch: '<S21>/FixPt Switch' incorporates:
       *  Constant: '<S21>/Constant'
       */
      if (SDS_brk_cbc_v1_B.FixPtSum1_o >
          SDS_brk_cbc_v1_P.CounterLimited1_uplimit) {
        SDS_brk_cbc_v1_B.FixPtSwitch_d = SDS_brk_cbc_v1_P.Constant_Value;
      } else {
        SDS_brk_cbc_v1_B.FixPtSwitch_d = SDS_brk_cbc_v1_B.FixPtSum1_o;
      }

      /* End of Switch: '<S21>/FixPt Switch' */

      /* DataTypeConversion: '<S11>/Data Type Conversion1' */
      SDS_brk_cbc_v1_B.DataTypeConversion1_b = SDS_brk_cbc_v1_B.Output_n;

      /* Outputs for Enabled SubSystem: '<S11>/SDS_Motion_Ref' incorporates:
       *  EnablePort: '<S19>/Enable'
       */
      /* Constant: '<S1>/SDS_Motion_ref_Trigg' */
      if (SDS_brk_cbc_v1_P.SDS_Motion_ref_Trigg_Value > 0.0) {
        /* S-Function (rti_commonblock): '<S19>/S-Function1' incorporates:
         *  Constant: '<S11>/CRC_SDS_Motion_Ref'
         *  Constant: '<S11>/Long_Accel_sds_mot_ref'
         *  Constant: '<S11>/Veh_Speed_sds_mot_ref'
         */
        /* This comment workarounds a code generation problem */

        /* dSPACE RTICAN TX Message Block: "SDS_Motion_Ref" Id:298 */
        {
          UInt32 CAN_Msg[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

          Float32 delayTime = 0.0;

          /* ... Read status and timestamp info (previous message) */
          can_tp1_msg_read(can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]);

          /* Convert timestamp */
          if (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]->processed) {
            can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]->timestamp =
              rtk_dsts_time_to_simtime_convert
              (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]->timestamp);
          }

          /* Messages with timestamp zero have been received in pause/stop state
             and must not be handled.
           */
          if (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]->timestamp > 0.0) {
            SDS_brk_cbc_v1_B.SFunction1_o1_e = (real_T)
              can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]->processed;
            SDS_brk_cbc_v1_B.SFunction1_o2_i = (real_T)
              can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]->timestamp;
            SDS_brk_cbc_v1_B.SFunction1_o3_f = (real_T)
              can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]->deltatime;
            SDS_brk_cbc_v1_B.SFunction1_o4_h = (real_T)
              can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]->delaytime;
          }

          /* ... Encode Simulink signals of TX and RM blocks*/
          {
            rtican_Signal_t CAN_Sgn;

            /* ...... "VEH_SPEED" (16|16, standard signal, unsigned int, motorola back.) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.Veh_Speed_sds_mot_ref_Value - ( 0 ) ) /
               0.0078125 + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x0000FFFF;
            CAN_Msg[3] |= CAN_Sgn.SgnBytes.Byte0;
            CAN_Msg[2] |= CAN_Sgn.SgnBytes.Byte1;

            /* ...... "MC_SDS_Motion_Ref" (36|4, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_B.DataTypeConversion1_b ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x0000000F;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[4] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "LongAcceleration" (36|12, standard signal, unsigned int, motorola back.) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.Long_Accel_sds_mot_ref_Value - ( -40.96 ) ) /
               0.02 + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000FFF;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[1] |= CAN_Sgn.SgnBytes.Byte0;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte1;

            /* ...... "CRC_SDS_Motion_Ref" (40|8, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.CRC_SDS_Motion_Ref_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x000000FF;
            CAN_Msg[5] |= CAN_Sgn.SgnBytes.Byte0;
          }

          /* Call user written decoding function  */
          can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]->datalen = 6;

          {
            Message_CRC_Encoder(CAN_Msg,
                                can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]);
          }

          /* ... Write the data to the CAN microcontroller */
          can_tp1_msg_write(can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A], abs
                            (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]
                             ->datalen) > 8 ? 8 : abs
                            (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A]
                             ->datalen), &(CAN_Msg[0]));

          /* ... Auto Repeat Time option selected -> no trigger needed */
        }
      }

      /* End of Constant: '<S1>/SDS_Motion_ref_Trigg' */
      /* End of Outputs for SubSystem: '<S11>/SDS_Motion_Ref' */
    }

    /* End of Outputs for SubSystem: '<S1>/ccan3_DAS_A3_A_tx1' */

    /* UnitDelay: '<S6>/Output' */
    SDS_brk_cbc_v1_B.Output_k = SDS_brk_cbc_v1_DW.Output_DSTATE_c;

    /* DataTypeConversion: '<S1>/Data Type Conversion' */
    SDS_brk_cbc_v1_B.DataTypeConversion = SDS_brk_cbc_v1_B.Output_k;

    /* Outputs for Enabled SubSystem: '<S1>/ccan_DAS_A3_A_tx' incorporates:
     *  EnablePort: '<S12>/Enable'
     */
    /* Constant: '<S1>/SDS_Brk_TX_Trigger' */
    if (SDS_brk_cbc_v1_P.SDS_Brk_TX_Trigger_Value > 0.0) {
      /* Outputs for Enabled SubSystem: '<S12>/DAS_A3_A' incorporates:
       *  EnablePort: '<S22>/Enable'
       */
      if (SDS_brk_cbc_v1_P.SDS_Brk_TX_Trigger_Value > 0.0) {
        /* S-Function (rti_commonblock): '<S22>/S-Function1' incorporates:
         *  Constant: '<S1>/Brk_PreFill_Rq'
         *  Constant: '<S1>/CRC_DAS_A3_A'
         *  Constant: '<S1>/DAS_EPB_APPY_RQ'
         *  Constant: '<S1>/DAS_EPB_RELSE_RQ'
         *  Constant: '<S1>/LFC_Request'
         *  Constant: '<S1>/LFC_Request_Type'
         *  Constant: '<S1>/RHSC_OpenLoopBraking_Rq'
         *  Constant: '<S1>/SDS_Engaged_State'
         */
        /* This comment workarounds a code generation problem */

        /* dSPACE RTICAN TX Message Block: "DAS_A3_A" Id:499 */
        {
          UInt32 CAN_Msg[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

          Float32 delayTime = 0.0;

          /* ... Read status and timestamp info (previous message) */
          can_tp1_msg_read(can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]);

          /* Convert timestamp */
          if (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]->processed) {
            can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]->timestamp =
              rtk_dsts_time_to_simtime_convert
              (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]->timestamp);
          }

          /* Messages with timestamp zero have been received in pause/stop state
             and must not be handled.
           */
          if (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]->timestamp > 0.0) {
            SDS_brk_cbc_v1_B.SFunction1_o1_am = (real_T)
              can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]->processed;
            SDS_brk_cbc_v1_B.SFunction1_o2_g = (real_T)
              can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]->timestamp;
            SDS_brk_cbc_v1_B.SFunction1_o3_b = (real_T)
              can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]->deltatime;
            SDS_brk_cbc_v1_B.SFunction1_o4_i = (real_T)
              can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]->delaytime;
          }

          /* ... Encode Simulink signals of TX and RM blocks*/
          {
            rtican_Signal_t CAN_Sgn;

            /* ...... "SDS_Engaged_State" (1|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_Engaged_State_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 1;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "DAS_EPB_APPLY_RQ" (3|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.DAS_EPB_APPY_RQ_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 3;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "RHSC_OpenLoopBraking_Rq" (4|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.RHSC_OpenLoopBraking_Rq_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "DAS_EPB_RELSE_RQ" (5|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.DAS_EPB_RELSE_RQ_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 5;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "LFC_Request_Type" (6|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.LFC_Request_Type_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 6;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "LFC_Request" (17|15, standard signal, unsigned int, motorola back.) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_brk_cbc_v1_P.LFC_Request_Value
              - ( -65534 ) ) / 2 + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00007FFF;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 1;
            CAN_Msg[5] |= CAN_Sgn.SgnBytes.Byte0;
            CAN_Msg[4] |= CAN_Sgn.SgnBytes.Byte1;

            /* ...... "Brk_PreFill_Rq" (49|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.Brk_PreFill_Rq_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 1;
            CAN_Msg[6] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "MC_DAS_A3_A" (52|4, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_B.DataTypeConversion ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x0000000F;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[6] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "CRC_DAS_A3_A" (56|8, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.CRC_DAS_A3_A_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x000000FF;
            CAN_Msg[7] |= CAN_Sgn.SgnBytes.Byte0;
          }

          /* Call user written decoding function  */
          can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]->datalen = 8;

          {
            Message_CRC_Encoder(CAN_Msg,
                                can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]);
          }

          /* ... Write the data to the CAN microcontroller */
          can_tp1_msg_write(can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3], abs
                            (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]
                             ->datalen) > 8 ? 8 : abs
                            (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3]
                             ->datalen), &(CAN_Msg[0]));

          /* ... Auto Repeat Time option selected -> no trigger needed */
        }
      }

      /* End of Outputs for SubSystem: '<S12>/DAS_A3_A' */
    }

    /* End of Outputs for SubSystem: '<S1>/ccan_DAS_A3_A_tx' */

    /* Sum: '<S13>/FixPt Sum1' incorporates:
     *  Constant: '<S13>/FixPt Constant'
     */
    SDS_brk_cbc_v1_B.FixPtSum1 = (uint8_T)((uint32_T)SDS_brk_cbc_v1_B.Output_k +
      SDS_brk_cbc_v1_P.FixPtConstant_Value_j);

    /* Switch: '<S14>/FixPt Switch' incorporates:
     *  Constant: '<S14>/Constant'
     */
    if (SDS_brk_cbc_v1_B.FixPtSum1 > SDS_brk_cbc_v1_P.CounterLimited_uplimit_g)
    {
      SDS_brk_cbc_v1_B.FixPtSwitch = SDS_brk_cbc_v1_P.Constant_Value_h;
    } else {
      SDS_brk_cbc_v1_B.FixPtSwitch = SDS_brk_cbc_v1_B.FixPtSum1;
    }

    /* End of Switch: '<S14>/FixPt Switch' */

    /* Sum: '<S15>/FixPt Sum1' incorporates:
     *  Constant: '<S15>/FixPt Constant'
     */
    SDS_brk_cbc_v1_B.FixPtSum1_l = (uint8_T)((uint32_T)SDS_brk_cbc_v1_B.Output +
      SDS_brk_cbc_v1_P.FixPtConstant_Value_a);

    /* Switch: '<S16>/FixPt Switch' incorporates:
     *  Constant: '<S16>/Constant'
     */
    if (SDS_brk_cbc_v1_B.FixPtSum1_l >
        SDS_brk_cbc_v1_P.CounterLimited1_uplimit_i) {
      SDS_brk_cbc_v1_B.FixPtSwitch_f = SDS_brk_cbc_v1_P.Constant_Value_hb;
    } else {
      SDS_brk_cbc_v1_B.FixPtSwitch_f = SDS_brk_cbc_v1_B.FixPtSum1_l;
    }

    /* End of Switch: '<S16>/FixPt Switch' */
  }

  /* S-Function (rti_commonblock): '<S8>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* dSPACE RTICAN RX Message Block: "DAS_A3_A" Id:499 */
  {
    UInt32 *CAN_Msg;

    /* ... Read status and timestamp info (previous message) */
    can_tp1_msg_read_from_mem(can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3]);

    /* Convert timestamp */
    if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3]->processed) {
      can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3]->timestamp =
        rtk_dsts_time_to_simtime_convert
        (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3]->timestamp);
    }

    /* Messages with timestamp zero have been received in pause/stop state
       and must not be handled.
     */
    if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3]->timestamp > 0.0) {
      if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3]->processed) {
        SDS_brk_cbc_v1_B.SFunction1_o10 = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3]->processed;
        SDS_brk_cbc_v1_B.SFunction1_o11 = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3]->timestamp;
        SDS_brk_cbc_v1_B.SFunction1_o12 = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3]->deltatime;
        CAN_Msg = can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3]->data;

        /* ... Decode CAN Message */
        {
          rtican_Signal_t CAN_Sgn;

          /* ...... "SDS_Engaged_State" (1|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 1;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o1 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "DAS_EPB_APPLY_RQ" (3|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 3;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o2 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "RHSC_OpenLoopBraking_Rq" (4|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o3 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "DAS_EPB_RELSE_RQ" (5|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 5;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o4 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "LFC_Request_Type" (6|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o5 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "LFC_Request" (17|15, standard signal, unsigned int, motorola back.) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[5];
          CAN_Sgn.SgnBytes.Byte1 = CAN_Msg[4];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 1;
          CAN_Sgn.UnsignedSgn &= 0x00007FFF;
          SDS_brk_cbc_v1_B.SFunction1_o6 = -65534 + ( 2 * ( ((real_T)
            CAN_Sgn.UnsignedSgn) ) );

          /* ...... "Brk_PreFill_Rq" (49|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[6];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 1;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o7 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "MC_DAS_A3_A" (52|4, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[6];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x0000000F;
          SDS_brk_cbc_v1_B.SFunction1_o8 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "CRC_DAS_A3_A" (56|8, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn &= 0x000000FF;
          SDS_brk_cbc_v1_B.SFunction1_o9 = ((real_T) CAN_Sgn.UnsignedSgn);
        }
      }
    }

    if (!can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3]->processed) {
      /* ... set RX status to 0 because no new message has arrived */
      SDS_brk_cbc_v1_B.SFunction1_o10 = 0.0;
    }
  }

  /* S-Function (rti_commonblock): '<S9>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* dSPACE RTICAN RX Message Block: "EBCM_C1" Id:653 */
  {
    UInt32 *CAN_Msg;

    /* ... Read status and timestamp info (previous message) */
    can_tp1_msg_read_from_mem(can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D]);

    /* Convert timestamp */
    if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D]->processed) {
      can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D]->timestamp =
        rtk_dsts_time_to_simtime_convert
        (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D]->timestamp);
    }

    /* Messages with timestamp zero have been received in pause/stop state
       and must not be handled.
     */
    if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D]->timestamp > 0.0) {
      if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D]->processed) {
        SDS_brk_cbc_v1_B.SFunction1_o19 = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D]->processed;
        SDS_brk_cbc_v1_B.SFunction1_o20 = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D]->timestamp;
        SDS_brk_cbc_v1_B.SFunction1_o21 = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D]->deltatime;
        CAN_Msg = can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D]->data;

        /* ... Decode CAN Message */
        {
          rtican_Signal_t CAN_Sgn;

          /* ...... "DriverBrakingTrue_EBCM" (0|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o1_o = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "DAS_RqActv" (1|3, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 1;
          CAN_Sgn.UnsignedSgn &= 0x00000007;
          SDS_brk_cbc_v1_B.SFunction1_o2_l = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "BrakePedalApplied" (4|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o3_p = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "BrakePedalAppliedV" (5|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 5;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o4_d = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "MIL_OnRq_EBCM" (6|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o5_k = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "EBCMSysEmsMlfAtv" (7|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 7;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o6_l = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "BrakePedalTravelSensor" (8|8, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[1];
          CAN_Sgn.UnsignedSgn &= 0x000000FF;
          SDS_brk_cbc_v1_B.SFunction1_o7_m = 0.4 * ( ((real_T)
            CAN_Sgn.UnsignedSgn) );

          /* ...... "EBCM_BrakeState" (16|3, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn &= 0x00000007;
          SDS_brk_cbc_v1_B.SFunction1_o8_m = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "BrakeSysStateSec" (19|3, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 3;
          CAN_Sgn.UnsignedSgn &= 0x00000007;
          SDS_brk_cbc_v1_B.SFunction1_o9_d = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "BrkPdl_Stat_2" (22|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o10_p = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "EstBrakeTorqueAppliedSec" (24|15, standard signal, unsigned int, motorola back.) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[4];
          CAN_Sgn.SgnBytes.Byte1 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn &= 0x00007FFF;
          SDS_brk_cbc_v1_B.SFunction1_o11_p = -65534 + ( 2 * ( ((real_T)
            CAN_Sgn.UnsignedSgn) ) );

          /* ...... "BrkPdl_Flt_2" (31|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 7;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o12_l = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "ThermalCapacitySec" (40|6, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[5];
          CAN_Sgn.UnsignedSgn &= 0x0000003F;
          SDS_brk_cbc_v1_B.SFunction1_o13 = 1.5873 * ( ((real_T)
            CAN_Sgn.UnsignedSgn) );

          /* ...... "BrakePedalTravelSensorV" (46|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[5];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o14 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "Brk_Stat_2" (48|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[6];
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o15 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "SDS_Engaged_State_EBCM" (50|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[6];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 2;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o16 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "MC_EBCM_C1" (52|4, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[6];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x0000000F;
          SDS_brk_cbc_v1_B.SFunction1_o17 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "CRC_EBCM_C1" (56|8, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn &= 0x000000FF;
          SDS_brk_cbc_v1_B.SFunction1_o18 = ((real_T) CAN_Sgn.UnsignedSgn);
        }
      }
    }

    if (!can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D]->processed) {
      /* ... set RX status to 0 because no new message has arrived */
      SDS_brk_cbc_v1_B.SFunction1_o19 = 0.0;
    }
  }

  /* S-Function (rti_commonblock): '<S10>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* dSPACE RTICAN RX Message Block: "ESP_B5" Id:682 */
  {
    UInt32 *CAN_Msg;

    /* ... Read status and timestamp info (previous message) */
    can_tp1_msg_read_from_mem(can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA]);

    /* Convert timestamp */
    if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA]->processed) {
      can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA]->timestamp =
        rtk_dsts_time_to_simtime_convert
        (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA]->timestamp);
    }

    /* Messages with timestamp zero have been received in pause/stop state
       and must not be handled.
     */
    if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA]->timestamp > 0.0) {
      if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA]->processed) {
        SDS_brk_cbc_v1_B.SFunction1_o11_a = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA]->processed;
        SDS_brk_cbc_v1_B.SFunction1_o12_k = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA]->timestamp;
        SDS_brk_cbc_v1_B.SFunction1_o13_k = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA]->deltatime;
        CAN_Msg = can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA]->data;

        /* ... Decode CAN Message */
        {
          rtican_Signal_t CAN_Sgn;

          /* ...... "qTargetExternal_Active" (0|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o1_b = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "BrakeSysStatePrim" (2|3, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 2;
          CAN_Sgn.UnsignedSgn &= 0x00000007;
          SDS_brk_cbc_v1_B.SFunction1_o2_o = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "ESC_BrakeState" (5|3, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 5;
          CAN_Sgn.UnsignedSgn &= 0x00000007;
          SDS_brk_cbc_v1_B.SFunction1_o3_pt = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "EsBrakeTorqueAppliedPrim" (24|15, standard signal, unsigned int, motorola back.) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[4];
          CAN_Sgn.SgnBytes.Byte1 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn &= 0x00007FFF;
          SDS_brk_cbc_v1_B.SFunction1_o4_l = -65534 + ( 2 * ( ((real_T)
            CAN_Sgn.UnsignedSgn) ) );

          /* ...... "HoldSufficientStatus" (31|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 7;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o5_n = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "qTargetExternal" (40|16, standard signal, unsigned int, motorola back.) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.SgnBytes.Byte1 = CAN_Msg[1];
          CAN_Sgn.UnsignedSgn &= 0x0000FFFF;
          SDS_brk_cbc_v1_B.SFunction1_o6_k = -252 + ( 0.0078125 * ( ((real_T)
            CAN_Sgn.UnsignedSgn) ) );

          /* ...... "ThermalCapacityPrim" (42|6, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[5];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 2;
          CAN_Sgn.UnsignedSgn &= 0x0000003F;
          SDS_brk_cbc_v1_B.SFunction1_o7_l = 1.5873 * ( ((real_T)
            CAN_Sgn.UnsignedSgn) );

          /* ...... "SDS_Engaged_State_ESC" (50|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[6];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 2;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o8_f = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "MC_ESP_B5" (52|4, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[6];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x0000000F;
          SDS_brk_cbc_v1_B.SFunction1_o9_c = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "CRC_ESP_B5" (56|8, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn &= 0x000000FF;
          SDS_brk_cbc_v1_B.SFunction1_o10_n = ((real_T) CAN_Sgn.UnsignedSgn);
        }
      }
    }

    if (!can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA]->processed) {
      /* ... set RX status to 0 because no new message has arrived */
      SDS_brk_cbc_v1_B.SFunction1_o11_a = 0.0;
    }
  }

  /* S-Function (rti_commonblock): '<S2>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* S-Function (rti_commonblock): '<S3>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* S-Function (rti_commonblock): '<S23>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* dSPACE RTICAN RX Message Block: "CBC_PT1" Id:820 */
  {
    UInt32 *CAN_Msg;

    /* ... Read status and timestamp info (previous message) */
    can_tp1_msg_read_from_mem(can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]);

    /* Convert timestamp */
    if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->processed) {
      can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->timestamp =
        rtk_dsts_time_to_simtime_convert
        (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->timestamp);
    }

    /* Messages with timestamp zero have been received in pause/stop state
       and must not be handled.
     */
    if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->timestamp > 0.0) {
      if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->processed) {
        SDS_brk_cbc_v1_B.SFunction1_o24 = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->processed;
        SDS_brk_cbc_v1_B.SFunction1_o25 = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->timestamp;
        SDS_brk_cbc_v1_B.SFunction1_o26 = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->deltatime;
        CAN_Msg = can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->data;

        /* ... Decode CAN Message */
        {
          rtican_Signal_t CAN_Sgn;

          /* ...... "FT_FOG_RQ" (2|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 2;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o1_c = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "R_FOG_RQ" (3|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 3;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o2_h = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "REV_GEAR" (4|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o3_g = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "DR_LK_STAT" (5|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 5;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o4_m = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "FOB_SrchRq" (8|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[1];
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o5_kp = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "AHB_ACT" (14|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[1];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o6_b = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "PARK_LMP_ON" (16|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o7_g = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "DRV_AJAR" (17|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 1;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o8_g = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "PSG_AJAR" (18|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 2;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o9_o = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "L_R_AJAR" (19|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 3;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o10_o = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "R_R_AJAR" (20|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o11_h = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "TLG_AJAR" (22|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o12_f = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "IGN_OFF_TIME_LNG" (24|12, standard signal, unsigned int, motorola back.) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[4];
          CAN_Sgn.SgnBytes.Byte1 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn &= 0x00000FFF;
          SDS_brk_cbc_v1_B.SFunction1_o13_l = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "SHIP_STAT" (28|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o14_n = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "TurnInd_LT_ON" (30|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o15_p = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "TurnInd_RT_ON" (31|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 7;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o16_h = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "DAY_LGT_MD" (40|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[5];
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o17_o = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "PANEL_INTS" (48|8, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[6];
          CAN_Sgn.UnsignedSgn &= 0x000000FF;
          SDS_brk_cbc_v1_B.SFunction1_o18_k = 0.5 * ( ((real_T)
            CAN_Sgn.UnsignedSgn) );

          /* ...... "FT_WPR_NOT_PRK" (56|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o19_j = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "LOBEAM_ON" (57|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 1;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o20_l = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "HIBEAM_ON" (58|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 2;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o21_g = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "BRK_FLUID_LO" (62|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o22 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "WASH_FLUID_LO" (63|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 7;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o23 = ((real_T) CAN_Sgn.UnsignedSgn);
        }
      }
    }

    if (!can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->processed) {
      /* ... set RX status to 0 because no new message has arrived */
      SDS_brk_cbc_v1_B.SFunction1_o24 = 0.0;
    }
  }

  /* Outputs for Enabled SubSystem: '<S4>/SDS _CAN_Tx_Sub ' incorporates:
   *  EnablePort: '<S25>/Enable'
   */
  /* Constant: '<S4>/SDS_CBC_CMD_TX_Trigger' */
  if (SDS_brk_cbc_v1_P.SDS_CBC_CMD_TX_Trigger_Value > 0.0) {
    if (!SDS_brk_cbc_v1_DW.SDS_CAN_Tx_Sub_MODE) {
      SDS_brk_cbc_v1_DW.SDS_CAN_Tx_Sub_MODE = true;
    }

    if (SDS_brk_cbc_v1_M->Timing.TaskCounters.TID[2] == 0) {
      /* UnitDelay: '<S27>/Output' */
      SDS_brk_cbc_v1_B.Output_j = SDS_brk_cbc_v1_DW.Output_DSTATE_n;

      /* Sum: '<S29>/FixPt Sum1' incorporates:
       *  Constant: '<S29>/FixPt Constant'
       */
      SDS_brk_cbc_v1_B.FixPtSum1_n = (uint8_T)((uint32_T)
        SDS_brk_cbc_v1_B.Output_j + SDS_brk_cbc_v1_P.FixPtConstant_Value_k);

      /* Switch: '<S30>/FixPt Switch' incorporates:
       *  Constant: '<S30>/Constant'
       */
      if (SDS_brk_cbc_v1_B.FixPtSum1_n > SDS_brk_cbc_v1_P.CounterLimited_uplimit)
      {
        SDS_brk_cbc_v1_B.FixPtSwitch_g = SDS_brk_cbc_v1_P.Constant_Value_i;
      } else {
        SDS_brk_cbc_v1_B.FixPtSwitch_g = SDS_brk_cbc_v1_B.FixPtSum1_n;
      }

      /* End of Switch: '<S30>/FixPt Switch' */

      /* DataTypeConversion: '<S25>/Data Type Conversion' */
      SDS_brk_cbc_v1_B.DataTypeConversion_b = SDS_brk_cbc_v1_B.Output_j;

      /* SignalConversion: '<S25>/HiddenBuf_InsertedFor_SDS_CBC_CMD_at_inport_17' */
      SDS_brk_cbc_v1_B.HiddenBuf_InsertedFor_SDS_CBC_C =
        SDS_brk_cbc_v1_P.SDS_CBC_CMD_TX_Trigger_Value;

      /* Outputs for Enabled SubSystem: '<S25>/SDS_CBC_CMD' incorporates:
       *  EnablePort: '<S28>/Enable'
       */
      if (SDS_brk_cbc_v1_B.HiddenBuf_InsertedFor_SDS_CBC_C > 0.0) {
        /* S-Function (rti_commonblock): '<S28>/S-Function1' incorporates:
         *  Constant: '<S4>/RHSC_CRC'
         *  Constant: '<S4>/SDS_CBC_CMD3'
         *  Constant: '<S4>/SDS_CBC_ConvLmpRst'
         *  Constant: '<S4>/SDS_CBC_HAZ_SW'
         *  Constant: '<S4>/SDS_CBC_HDLP_SW'
         *  Constant: '<S4>/SDS_CBC_HDLP_Wash'
         *  Constant: '<S4>/SDS_CBC_HiBmLvr'
         *  Constant: '<S4>/SDS_CBC_Horn'
         *  Constant: '<S4>/SDS_CBC_IGNPOS'
         *  Constant: '<S4>/SDS_CBC_IP_Dimmer'
         *  Constant: '<S4>/SDS_CBC_OVERLAY_REQ'
         *  Constant: '<S4>/SDS_CBC_RFFunct'
         *  Constant: '<S4>/SDS_CBC_TRN-I_1L_2R_0N'
         *  Constant: '<S4>/SDS_CBC_WPRSW'
         *  Constant: '<S4>/SDS_CBC_WPR_Wash'
         *  Constant: '<S4>/SDS_CBC_WprWshSW'
         */
        /* This comment workarounds a code generation problem */

        /* dSPACE RTICAN TX Message Block: "SDS_CBC_CMD" Id:857 */
        {
          UInt32 CAN_Msg[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

          Float32 delayTime = 0.0;

          /* ... Read status and timestamp info (previous message) */
          can_tp1_msg_read(can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]);

          /* Convert timestamp */
          if (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]->processed) {
            can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]->timestamp =
              rtk_dsts_time_to_simtime_convert
              (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]->timestamp);
          }

          /* Messages with timestamp zero have been received in pause/stop state
             and must not be handled.
           */
          if (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]->timestamp > 0.0) {
            SDS_brk_cbc_v1_B.SFunction1 = (real_T)
              can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]->processed;
          }

          /* ... Encode Simulink signals of TX and RM blocks*/
          {
            rtican_Signal_t CAN_Sgn;

            /* ...... "IgnPos_Cmd" (0|3, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_IGNPOS_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000007;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "HiBmLvr_Cmd" (3|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_HiBmLvr_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 3;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "HAZ_SW_Cmd" (5|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_HAZ_SW_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 5;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "TurnIndLvr_Cmd" (6|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_TRNI_1L_2R_0N_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 6;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "Command_03_Cmd" (8|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_CMD3_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Msg[1] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "Horn_Sw_Cmd" (12|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_Horn_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[1] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "HDLP_Wash_Cmd" (13|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_HDLP_Wash_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 5;
            CAN_Msg[1] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "WprWash_R_Sw_Posn_V3_Cmd" (14|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_WPR_Wash_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 6;
            CAN_Msg[1] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "IPDimmerPos_Cmd" (20|4, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_IP_Dimmer_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x0000000F;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[2] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "HDLP_Sw_Cmd" (32|3, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_HDLP_SW_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000007;
            CAN_Msg[4] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "RFFuncReq_Cmd" (35|5, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_RFFunct_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x0000001F;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 3;
            CAN_Msg[4] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "WprWashSw_Psd_Cmd" (42|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_WprWshSW_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 2;
            CAN_Msg[5] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "WprSw6Posn_Cmd" (44|4, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_WPRSW_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x0000000F;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[5] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "SDS_CBC_OverlayReq" (48|3, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_OVERLAY_REQ_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000007;
            CAN_Msg[6] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "ConvLmpRst_Cmd" (51|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_P.SDS_CBC_ConvLmpRst_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 3;
            CAN_Msg[6] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "MC_SDS_CBC_CMD" (52|4, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_brk_cbc_v1_B.DataTypeConversion_b ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x0000000F;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[6] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "CRC_SDS_CBC_CMD" (56|8, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_brk_cbc_v1_P.RHSC_CRC_Value )
              + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x000000FF;
            CAN_Msg[7] |= CAN_Sgn.SgnBytes.Byte0;
          }

          /* Call user written decoding function  */
          can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]->datalen = 8;

          {
            Message_CRC_Encoder(CAN_Msg,
                                can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]);
          }

          /* ... Write the data to the CAN microcontroller */
          can_tp1_msg_write(can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359], abs
                            (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]
                             ->datalen) > 8 ? 8 : abs
                            (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]
                             ->datalen), &(CAN_Msg[0]));

          /* ... Auto Repeat Time option selected -> no trigger needed */
        }
      }

      /* End of Outputs for SubSystem: '<S25>/SDS_CBC_CMD' */
    }
  } else {
    if (SDS_brk_cbc_v1_DW.SDS_CAN_Tx_Sub_MODE) {
      SDS_brk_cbc_v1_DW.SDS_CAN_Tx_Sub_MODE = false;
    }
  }

  /* End of Constant: '<S4>/SDS_CBC_CMD_TX_Trigger' */
  /* End of Outputs for SubSystem: '<S4>/SDS _CAN_Tx_Sub ' */

  /* S-Function (rti_commonblock): '<S26>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* dSPACE RTICAN RX Message Block: "SDS_CBC_STAT" Id:858 */
  {
    UInt32 *CAN_Msg;

    /* ... Read status and timestamp info (previous message) */
    can_tp1_msg_read_from_mem(can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]);

    /* Convert timestamp */
    if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->processed) {
      can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->timestamp =
        rtk_dsts_time_to_simtime_convert
        (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->timestamp);
    }

    /* Messages with timestamp zero have been received in pause/stop state
       and must not be handled.
     */
    if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->timestamp > 0.0) {
      /* Call user written decoding function  */
      {
        Message_CRC_Decoder(can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->data,
                            &SDS_brk_cbc_v1_B.SFunction1_o15_a,
                            can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]);
      }

      if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->processed) {
        SDS_brk_cbc_v1_B.SFunction1_o12_c = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->processed;
        SDS_brk_cbc_v1_B.SFunction1_o13_o = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->timestamp;
        SDS_brk_cbc_v1_B.SFunction1_o14_i = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->deltatime;
        CAN_Msg = can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->data;

        /* ... Decode CAN Message */
        {
          rtican_Signal_t CAN_Sgn;

          /* ...... "Command_03_SwStat" (0|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o1_a = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "Horn_Sw_Stat" (2|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 2;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o2_n = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "HDLP_SW_Stat" (4|3, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x00000007;
          SDS_brk_cbc_v1_B.SFunction1_o3_a = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "HAZ_SW_Stat" (7|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 7;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_brk_cbc_v1_B.SFunction1_o4_b = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "CBC_OVERLAY_MODE" (13|3, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[1];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 5;
          CAN_Sgn.UnsignedSgn &= 0x00000007;
          SDS_brk_cbc_v1_B.SFunction1_o5_f = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "IPDimmerPos_Stat" (16|4, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn &= 0x0000000F;
          SDS_brk_cbc_v1_B.SFunction1_o6_d = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "U_CALL_BtnStat" (20|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o7_f = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "E_CALL_BtnStat" (22|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o8_o = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "WiperSpeed_Stat" (24|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_brk_cbc_v1_B.SFunction1_o9_p = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "MC_SDS_CBC_STAT" (28|4, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x0000000F;
          SDS_brk_cbc_v1_B.SFunction1_o10_i = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "CRC_SDS_CBC_STAT" (32|8, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[4];
          CAN_Sgn.UnsignedSgn &= 0x000000FF;
          SDS_brk_cbc_v1_B.SFunction1_o11_f = ((real_T) CAN_Sgn.UnsignedSgn);
        }
      }
    }

    if (!can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->processed) {
      /* ... set RX status to 0 because no new message has arrived */
      SDS_brk_cbc_v1_B.SFunction1_o12_c = 0.0;
    }
  }

  /* RelationalOperator: '<S24>/Compare' incorporates:
   *  Constant: '<S24>/Constant'
   */
  SDS_brk_cbc_v1_B.Compare = (SDS_brk_cbc_v1_B.SFunction1_o15_a >
    SDS_brk_cbc_v1_P.CRC_is_OK1_const);
}

/* Model update function */
void SDS_brk_cbc_v1_update(void)
{
  if (SDS_brk_cbc_v1_M->Timing.TaskCounters.TID[1] == 0) {
    /* Update for UnitDelay: '<S7>/Output' */
    SDS_brk_cbc_v1_DW.Output_DSTATE = SDS_brk_cbc_v1_B.FixPtSwitch_f;

    /* Update for Enabled SubSystem: '<S1>/ccan3_DAS_A3_A_tx1' incorporates:
     *  EnablePort: '<S11>/Enable'
     */
    /* Constant: '<S1>/SDS_Brk_TX_Trigger' */
    if (SDS_brk_cbc_v1_P.SDS_Brk_TX_Trigger_Value > 0.0) {
      /* Update for UnitDelay: '<S17>/Output' */
      SDS_brk_cbc_v1_DW.Output_DSTATE_cj = SDS_brk_cbc_v1_B.FixPtSwitch_d;
    }

    /* End of Constant: '<S1>/SDS_Brk_TX_Trigger' */
    /* End of Update for SubSystem: '<S1>/ccan3_DAS_A3_A_tx1' */

    /* Update for UnitDelay: '<S6>/Output' */
    SDS_brk_cbc_v1_DW.Output_DSTATE_c = SDS_brk_cbc_v1_B.FixPtSwitch;
  }

  /* Update for Enabled SubSystem: '<S4>/SDS _CAN_Tx_Sub ' incorporates:
   *  EnablePort: '<S25>/Enable'
   */
  if (SDS_brk_cbc_v1_DW.SDS_CAN_Tx_Sub_MODE) {
    if (SDS_brk_cbc_v1_M->Timing.TaskCounters.TID[2] == 0) {
      /* Update for UnitDelay: '<S27>/Output' */
      SDS_brk_cbc_v1_DW.Output_DSTATE_n = SDS_brk_cbc_v1_B.FixPtSwitch_g;
    }
  }

  /* End of Update for SubSystem: '<S4>/SDS _CAN_Tx_Sub ' */

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++SDS_brk_cbc_v1_M->Timing.clockTick0)) {
    ++SDS_brk_cbc_v1_M->Timing.clockTickH0;
  }

  SDS_brk_cbc_v1_M->Timing.taskTime0 = SDS_brk_cbc_v1_M->Timing.clockTick0 *
    SDS_brk_cbc_v1_M->Timing.stepSize0 + SDS_brk_cbc_v1_M->Timing.clockTickH0 *
    SDS_brk_cbc_v1_M->Timing.stepSize0 * 4294967296.0;
  rate_scheduler();
}

/* Model initialize function */
void SDS_brk_cbc_v1_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)SDS_brk_cbc_v1_M, 0,
                sizeof(RT_MODEL_SDS_brk_cbc_v1_T));
  SDS_brk_cbc_v1_M->Timing.stepSize0 = 0.001;

  /* block I/O */
  (void) memset(((void *) &SDS_brk_cbc_v1_B), 0,
                sizeof(B_SDS_brk_cbc_v1_T));

  /* states (dwork) */
  (void) memset((void *)&SDS_brk_cbc_v1_DW, 0,
                sizeof(DW_SDS_brk_cbc_v1_T));

  {
    /* user code (registration function declaration) */
    /*Initialize global TRC pointers. */
    SDS_brk_cbc_v1_rti_init_trc_pointers();
  }

  /* Start for Enabled SubSystem: '<S4>/SDS _CAN_Tx_Sub ' */
  SDS_brk_cbc_v1_DW.SDS_CAN_Tx_Sub_MODE = false;

  /* InitializeConditions for UnitDelay: '<S7>/Output' */
  SDS_brk_cbc_v1_DW.Output_DSTATE = SDS_brk_cbc_v1_P.Output_InitialCondition_o;

  /* InitializeConditions for UnitDelay: '<S6>/Output' */
  SDS_brk_cbc_v1_DW.Output_DSTATE_c = SDS_brk_cbc_v1_P.Output_InitialCondition_p;

  /* SystemInitialize for Enabled SubSystem: '<S1>/ccan3_DAS_A3_A_tx1' */
  /* InitializeConditions for UnitDelay: '<S17>/Output' */
  SDS_brk_cbc_v1_DW.Output_DSTATE_cj = SDS_brk_cbc_v1_P.Output_InitialCondition;

  /* SystemInitialize for Enabled SubSystem: '<S11>/DAS_A3_A' */
  /* SystemInitialize for Outport: '<S18>/TX status' */
  SDS_brk_cbc_v1_B.SFunction1_o1_l = SDS_brk_cbc_v1_P.TXstatus_Y0;

  /* SystemInitialize for Outport: '<S18>/TX time' */
  SDS_brk_cbc_v1_B.SFunction1_o2_f = SDS_brk_cbc_v1_P.TXtime_Y0;

  /* SystemInitialize for Outport: '<S18>/TX delta time' */
  SDS_brk_cbc_v1_B.SFunction1_o3_l = SDS_brk_cbc_v1_P.TXdeltatime_Y0;

  /* SystemInitialize for Outport: '<S18>/TX delay time' */
  SDS_brk_cbc_v1_B.SFunction1_o4_k = SDS_brk_cbc_v1_P.TXdelaytime_Y0;

  /* End of SystemInitialize for SubSystem: '<S11>/DAS_A3_A' */

  /* SystemInitialize for Enabled SubSystem: '<S11>/SDS_Motion_Ref' */
  /* SystemInitialize for Outport: '<S19>/TX status' */
  SDS_brk_cbc_v1_B.SFunction1_o1_e = SDS_brk_cbc_v1_P.TXstatus_Y0_k;

  /* SystemInitialize for Outport: '<S19>/TX time' */
  SDS_brk_cbc_v1_B.SFunction1_o2_i = SDS_brk_cbc_v1_P.TXtime_Y0_f;

  /* SystemInitialize for Outport: '<S19>/TX delta time' */
  SDS_brk_cbc_v1_B.SFunction1_o3_f = SDS_brk_cbc_v1_P.TXdeltatime_Y0_k;

  /* SystemInitialize for Outport: '<S19>/TX delay time' */
  SDS_brk_cbc_v1_B.SFunction1_o4_h = SDS_brk_cbc_v1_P.TXdelaytime_Y0_n;

  /* End of SystemInitialize for SubSystem: '<S11>/SDS_Motion_Ref' */
  /* End of SystemInitialize for SubSystem: '<S1>/ccan3_DAS_A3_A_tx1' */

  /* SystemInitialize for Enabled SubSystem: '<S1>/ccan_DAS_A3_A_tx' */
  /* SystemInitialize for Enabled SubSystem: '<S12>/DAS_A3_A' */
  /* SystemInitialize for Outport: '<S22>/TX status' */
  SDS_brk_cbc_v1_B.SFunction1_o1_am = SDS_brk_cbc_v1_P.TXstatus_Y0_n;

  /* SystemInitialize for Outport: '<S22>/TX time' */
  SDS_brk_cbc_v1_B.SFunction1_o2_g = SDS_brk_cbc_v1_P.TXtime_Y0_o;

  /* SystemInitialize for Outport: '<S22>/TX delta time' */
  SDS_brk_cbc_v1_B.SFunction1_o3_b = SDS_brk_cbc_v1_P.TXdeltatime_Y0_n;

  /* SystemInitialize for Outport: '<S22>/TX delay time' */
  SDS_brk_cbc_v1_B.SFunction1_o4_i = SDS_brk_cbc_v1_P.TXdelaytime_Y0_i;

  /* End of SystemInitialize for SubSystem: '<S12>/DAS_A3_A' */
  /* End of SystemInitialize for SubSystem: '<S1>/ccan_DAS_A3_A_tx' */

  /* SystemInitialize for Enabled SubSystem: '<S4>/SDS _CAN_Tx_Sub ' */
  /* InitializeConditions for UnitDelay: '<S27>/Output' */
  SDS_brk_cbc_v1_DW.Output_DSTATE_n = SDS_brk_cbc_v1_P.Output_InitialCondition_i;

  /* SystemInitialize for Enabled SubSystem: '<S25>/SDS_CBC_CMD' */
  /* SystemInitialize for Outport: '<S28>/TX status' */
  SDS_brk_cbc_v1_B.SFunction1 = SDS_brk_cbc_v1_P.TXstatus_Y0_b;

  /* End of SystemInitialize for SubSystem: '<S25>/SDS_CBC_CMD' */
  /* End of SystemInitialize for SubSystem: '<S4>/SDS _CAN_Tx_Sub ' */
}

/* Model terminate function */
void SDS_brk_cbc_v1_terminate(void)
{
  /* Terminate for Enabled SubSystem: '<S1>/ccan3_DAS_A3_A_tx1' */
  /* Terminate for Enabled SubSystem: '<S11>/DAS_A3_A' */
  /* Terminate for S-Function (rti_commonblock): '<S18>/S-Function1' incorporates:
   *  Constant: '<S1>/CRC_CCAN3_DAS_A3_A'
   *  Constant: '<S1>/DAS_EPB_APPY_RQ'
   *  Constant: '<S1>/DAS_EPB_RELSE_RQ'
   *  Constant: '<S1>/LFC_Request'
   *  Constant: '<S1>/LFC_Request_Type'
   *  Constant: '<S1>/RHSC_OpenLoopBraking_Rq'
   *  Constant: '<S1>/SDS_Engaged_State'
   */

  /* dSPACE RTICAN TX Message Block: "DAS_A3_A" Id:499 */
  {
    /* ... Set the message into sleep mode */
    while ((rtican_type1_tq_error[0][0] = can_tp1_msg_sleep
            (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X1F3])) ==
           DSMCOM_BUFFER_OVERFLOW) ;
  }

  /* End of Terminate for SubSystem: '<S11>/DAS_A3_A' */

  /* Terminate for Enabled SubSystem: '<S11>/SDS_Motion_Ref' */
  /* Terminate for S-Function (rti_commonblock): '<S19>/S-Function1' incorporates:
   *  Constant: '<S11>/CRC_SDS_Motion_Ref'
   *  Constant: '<S11>/Long_Accel_sds_mot_ref'
   *  Constant: '<S11>/Veh_Speed_sds_mot_ref'
   */

  /* dSPACE RTICAN TX Message Block: "SDS_Motion_Ref" Id:298 */
  {
    /* ... Set the message into sleep mode */
    while ((rtican_type1_tq_error[0][0] = can_tp1_msg_sleep
            (can_type1_msg_M1[CANTP1_M1_C2_TX_STD_0X12A])) ==
           DSMCOM_BUFFER_OVERFLOW) ;
  }

  /* End of Terminate for SubSystem: '<S11>/SDS_Motion_Ref' */
  /* End of Terminate for SubSystem: '<S1>/ccan3_DAS_A3_A_tx1' */

  /* Terminate for Enabled SubSystem: '<S1>/ccan_DAS_A3_A_tx' */
  /* Terminate for Enabled SubSystem: '<S12>/DAS_A3_A' */
  /* Terminate for S-Function (rti_commonblock): '<S22>/S-Function1' incorporates:
   *  Constant: '<S1>/Brk_PreFill_Rq'
   *  Constant: '<S1>/CRC_DAS_A3_A'
   *  Constant: '<S1>/DAS_EPB_APPY_RQ'
   *  Constant: '<S1>/DAS_EPB_RELSE_RQ'
   *  Constant: '<S1>/LFC_Request'
   *  Constant: '<S1>/LFC_Request_Type'
   *  Constant: '<S1>/RHSC_OpenLoopBraking_Rq'
   *  Constant: '<S1>/SDS_Engaged_State'
   */

  /* dSPACE RTICAN TX Message Block: "DAS_A3_A" Id:499 */
  {
    /* ... Set the message into sleep mode */
    while ((rtican_type1_tq_error[0][0] = can_tp1_msg_sleep
            (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X1F3])) ==
           DSMCOM_BUFFER_OVERFLOW) ;
  }

  /* End of Terminate for SubSystem: '<S12>/DAS_A3_A' */
  /* End of Terminate for SubSystem: '<S1>/ccan_DAS_A3_A_tx' */

  /* Terminate for S-Function (rti_commonblock): '<S8>/S-Function1' */

  /* dSPACE RTICAN RX Message Block: "DAS_A3_A" Id:499 */
  {
    /* ... Set the message into sleep mode */
    while ((rtican_type1_tq_error[0][0] = can_tp1_msg_sleep
            (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X1F3])) ==
           DSMCOM_BUFFER_OVERFLOW) ;
  }

  /* Terminate for S-Function (rti_commonblock): '<S9>/S-Function1' */

  /* dSPACE RTICAN RX Message Block: "EBCM_C1" Id:653 */
  {
    /* ... Set the message into sleep mode */
    while ((rtican_type1_tq_error[0][1] = can_tp1_msg_sleep
            (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X28D])) ==
           DSMCOM_BUFFER_OVERFLOW) ;
  }

  /* Terminate for S-Function (rti_commonblock): '<S10>/S-Function1' */

  /* dSPACE RTICAN RX Message Block: "ESP_B5" Id:682 */
  {
    /* ... Set the message into sleep mode */
    while ((rtican_type1_tq_error[0][2] = can_tp1_msg_sleep
            (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X2AA])) ==
           DSMCOM_BUFFER_OVERFLOW) ;
  }

  /* Terminate for S-Function (rti_commonblock): '<S23>/S-Function1' */

  /* dSPACE RTICAN RX Message Block: "CBC_PT1" Id:820 */
  {
    /* ... Set the message into sleep mode */
    while ((rtican_type1_tq_error[0][3] = can_tp1_msg_sleep
            (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334])) ==
           DSMCOM_BUFFER_OVERFLOW) ;
  }

  /* Terminate for Enabled SubSystem: '<S4>/SDS _CAN_Tx_Sub ' */
  /* Terminate for Enabled SubSystem: '<S25>/SDS_CBC_CMD' */
  /* Terminate for S-Function (rti_commonblock): '<S28>/S-Function1' incorporates:
   *  Constant: '<S4>/RHSC_CRC'
   *  Constant: '<S4>/SDS_CBC_CMD3'
   *  Constant: '<S4>/SDS_CBC_ConvLmpRst'
   *  Constant: '<S4>/SDS_CBC_HAZ_SW'
   *  Constant: '<S4>/SDS_CBC_HDLP_SW'
   *  Constant: '<S4>/SDS_CBC_HDLP_Wash'
   *  Constant: '<S4>/SDS_CBC_HiBmLvr'
   *  Constant: '<S4>/SDS_CBC_Horn'
   *  Constant: '<S4>/SDS_CBC_IGNPOS'
   *  Constant: '<S4>/SDS_CBC_IP_Dimmer'
   *  Constant: '<S4>/SDS_CBC_OVERLAY_REQ'
   *  Constant: '<S4>/SDS_CBC_RFFunct'
   *  Constant: '<S4>/SDS_CBC_TRN-I_1L_2R_0N'
   *  Constant: '<S4>/SDS_CBC_WPRSW'
   *  Constant: '<S4>/SDS_CBC_WPR_Wash'
   *  Constant: '<S4>/SDS_CBC_WprWshSW'
   */

  /* dSPACE RTICAN TX Message Block: "SDS_CBC_CMD" Id:857 */
  {
    /* ... Set the message into sleep mode */
    while ((rtican_type1_tq_error[0][4] = can_tp1_msg_sleep
            (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359])) ==
           DSMCOM_BUFFER_OVERFLOW) ;
  }

  /* End of Terminate for SubSystem: '<S25>/SDS_CBC_CMD' */
  /* End of Terminate for SubSystem: '<S4>/SDS _CAN_Tx_Sub ' */

  /* Terminate for S-Function (rti_commonblock): '<S26>/S-Function1' */

  /* dSPACE RTICAN RX Message Block: "SDS_CBC_STAT" Id:858 */
  {
    /* ... Set the message into sleep mode */
    while ((rtican_type1_tq_error[0][5] = can_tp1_msg_sleep
            (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A])) ==
           DSMCOM_BUFFER_OVERFLOW) ;
  }
}
