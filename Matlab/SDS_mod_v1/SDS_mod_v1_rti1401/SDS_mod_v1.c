/*
 * SDS_mod_v1.c
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

#include "SDS_mod_v1_trc_ptr.h"
#include "SDS_mod_v1.h"
#include "SDS_mod_v1_private.h"

/* Block signals (default storage) */
B_SDS_mod_v1_T SDS_mod_v1_B;

/* Block states (default storage) */
DW_SDS_mod_v1_T SDS_mod_v1_DW;

/* Real-time model */
RT_MODEL_SDS_mod_v1_T SDS_mod_v1_M_;
RT_MODEL_SDS_mod_v1_T *const SDS_mod_v1_M = &SDS_mod_v1_M_;
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
  (SDS_mod_v1_M->Timing.TaskCounters.TID[1])++;
  if ((SDS_mod_v1_M->Timing.TaskCounters.TID[1]) > 99) {/* Sample time: [0.1s, 0.0s] */
    SDS_mod_v1_M->Timing.TaskCounters.TID[1] = 0;
  }
}

/* Model output function */
void SDS_mod_v1_output(void)
{
  /* S-Function (rti_commonblock): '<S2>/S-Function1' */
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
        SDS_mod_v1_B.SFunction1_o24 = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->processed;
        SDS_mod_v1_B.SFunction1_o25 = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->timestamp;
        SDS_mod_v1_B.SFunction1_o26 = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->deltatime;
        CAN_Msg = can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->data;

        /* ... Decode CAN Message */
        {
          rtican_Signal_t CAN_Sgn;

          /* ...... "FT_FOG_RQ" (2|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 2;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o1 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "R_FOG_RQ" (3|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 3;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o2 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "REV_GEAR" (4|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o3 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "DR_LK_STAT" (5|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 5;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_mod_v1_B.SFunction1_o4 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "FOB_SrchRq" (8|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[1];
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_mod_v1_B.SFunction1_o5 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "AHB_ACT" (14|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[1];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o6 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "PARK_LMP_ON" (16|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o7 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "DRV_AJAR" (17|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 1;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o8 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "PSG_AJAR" (18|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 2;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o9 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "L_R_AJAR" (19|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 3;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o10 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "R_R_AJAR" (20|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o11 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "TLG_AJAR" (22|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o12 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "IGN_OFF_TIME_LNG" (24|12, standard signal, unsigned int, motorola back.) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[4];
          CAN_Sgn.SgnBytes.Byte1 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn &= 0x00000FFF;
          SDS_mod_v1_B.SFunction1_o13 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "SHIP_STAT" (28|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_mod_v1_B.SFunction1_o14 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "TurnInd_LT_ON" (30|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o15 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "TurnInd_RT_ON" (31|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 7;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o16 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "DAY_LGT_MD" (40|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[5];
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o17 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "PANEL_INTS" (48|8, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[6];
          CAN_Sgn.UnsignedSgn &= 0x000000FF;
          SDS_mod_v1_B.SFunction1_o18 = 0.5 * ( ((real_T) CAN_Sgn.UnsignedSgn) );

          /* ...... "FT_WPR_NOT_PRK" (56|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o19 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "LOBEAM_ON" (57|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 1;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o20 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "HIBEAM_ON" (58|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 2;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o21 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "BRK_FLUID_LO" (62|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o22 = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "WASH_FLUID_LO" (63|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[7];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 7;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o23 = ((real_T) CAN_Sgn.UnsignedSgn);
        }
      }
    }

    if (!can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334]->processed) {
      /* ... set RX status to 0 because no new message has arrived */
      SDS_mod_v1_B.SFunction1_o24 = 0.0;
    }
  }

  /* Outputs for Enabled SubSystem: '<Root>/SDS _CAN_Tx_Sub ' incorporates:
   *  EnablePort: '<S5>/Enable'
   */
  /* Constant: '<Root>/SDS_CBC_CMD_TX_Trigger' */
  if (SDS_mod_v1_P.SDS_CBC_CMD_TX_Trigger_Value > 0.0) {
    if (!SDS_mod_v1_DW.SDS_CAN_Tx_Sub_MODE) {
      SDS_mod_v1_DW.SDS_CAN_Tx_Sub_MODE = true;
    }

    if (SDS_mod_v1_M->Timing.TaskCounters.TID[1] == 0) {
      /* UnitDelay: '<S10>/Output' */
      SDS_mod_v1_B.Output = SDS_mod_v1_DW.Output_DSTATE;

      /* Sum: '<S12>/FixPt Sum1' incorporates:
       *  Constant: '<S12>/FixPt Constant'
       */
      SDS_mod_v1_B.FixPtSum1 = (uint8_T)((uint32_T)SDS_mod_v1_B.Output +
        SDS_mod_v1_P.FixPtConstant_Value);

      /* Switch: '<S13>/FixPt Switch' incorporates:
       *  Constant: '<S13>/Constant'
       */
      if (SDS_mod_v1_B.FixPtSum1 > SDS_mod_v1_P.CounterLimited_uplimit) {
        SDS_mod_v1_B.FixPtSwitch = SDS_mod_v1_P.Constant_Value;
      } else {
        SDS_mod_v1_B.FixPtSwitch = SDS_mod_v1_B.FixPtSum1;
      }

      /* End of Switch: '<S13>/FixPt Switch' */

      /* DataTypeConversion: '<S5>/Data Type Conversion' */
      SDS_mod_v1_B.DataTypeConversion = SDS_mod_v1_B.Output;

      /* SignalConversion: '<S5>/HiddenBuf_InsertedFor_SDS_CBC_CMD_at_inport_17' */
      SDS_mod_v1_B.HiddenBuf_InsertedFor_SDS_CBC_C =
        SDS_mod_v1_P.SDS_CBC_CMD_TX_Trigger_Value;

      /* Outputs for Enabled SubSystem: '<S5>/SDS_CBC_CMD' incorporates:
       *  EnablePort: '<S11>/Enable'
       */
      if (SDS_mod_v1_B.HiddenBuf_InsertedFor_SDS_CBC_C > 0.0) {
        /* S-Function (rti_commonblock): '<S11>/S-Function1' incorporates:
         *  Constant: '<Root>/RHSC_CRC'
         *  Constant: '<Root>/SDS_CBC_CMD3'
         *  Constant: '<Root>/SDS_CBC_ConvLmpRst'
         *  Constant: '<Root>/SDS_CBC_HAZ_SW'
         *  Constant: '<Root>/SDS_CBC_HDLP_SW'
         *  Constant: '<Root>/SDS_CBC_HDLP_Wash'
         *  Constant: '<Root>/SDS_CBC_HiBmLvr'
         *  Constant: '<Root>/SDS_CBC_Horn'
         *  Constant: '<Root>/SDS_CBC_IGNPOS'
         *  Constant: '<Root>/SDS_CBC_IP_Dimmer'
         *  Constant: '<Root>/SDS_CBC_OVERLAY_REQ'
         *  Constant: '<Root>/SDS_CBC_RFFunct'
         *  Constant: '<Root>/SDS_CBC_TRN-I_1L_2R_0N'
         *  Constant: '<Root>/SDS_CBC_WPRSW'
         *  Constant: '<Root>/SDS_CBC_WPR_Wash'
         *  Constant: '<Root>/SDS_CBC_WprWshSW'
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
            SDS_mod_v1_B.SFunction1 = (real_T)
              can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]->processed;
          }

          /* ... Encode Simulink signals of TX and RM blocks*/
          {
            rtican_Signal_t CAN_Sgn;

            /* ...... "IgnPos_Cmd" (0|3, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_mod_v1_P.SDS_CBC_IGNPOS_Value )
              + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000007;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "HiBmLvr_Cmd" (3|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_mod_v1_P.SDS_CBC_HiBmLvr_Value
              ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 3;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "HAZ_SW_Cmd" (5|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_mod_v1_P.SDS_CBC_HAZ_SW_Value )
              + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 5;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "TurnIndLvr_Cmd" (6|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_mod_v1_P.SDS_CBC_TRNI_1L_2R_0N_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 6;
            CAN_Msg[0] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "Command_03_Cmd" (8|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_mod_v1_P.SDS_CBC_CMD3_Value )
              + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Msg[1] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "Horn_Sw_Cmd" (12|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_mod_v1_P.SDS_CBC_Horn_Value )
              + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[1] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "HDLP_Wash_Cmd" (13|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_mod_v1_P.SDS_CBC_HDLP_Wash_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 5;
            CAN_Msg[1] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "WprWash_R_Sw_Posn_V3_Cmd" (14|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_mod_v1_P.SDS_CBC_WPR_Wash_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 6;
            CAN_Msg[1] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "IPDimmerPos_Cmd" (20|4, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_mod_v1_P.SDS_CBC_IP_Dimmer_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x0000000F;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[2] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "HDLP_Sw_Cmd" (32|3, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_mod_v1_P.SDS_CBC_HDLP_SW_Value
              ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000007;
            CAN_Msg[4] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "RFFuncReq_Cmd" (35|5, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_mod_v1_P.SDS_CBC_RFFunct_Value
              ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x0000001F;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 3;
            CAN_Msg[4] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "WprWashSw_Psd_Cmd" (42|2, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_mod_v1_P.SDS_CBC_WprWshSW_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000003;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 2;
            CAN_Msg[5] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "WprSw6Posn_Cmd" (44|4, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_mod_v1_P.SDS_CBC_WPRSW_Value )
              + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x0000000F;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[5] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "SDS_CBC_OverlayReq" (48|3, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_mod_v1_P.SDS_CBC_OVERLAY_REQ_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000007;
            CAN_Msg[6] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "ConvLmpRst_Cmd" (51|1, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32)
              (( SDS_mod_v1_P.SDS_CBC_ConvLmpRst_Value ) + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x00000001;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 3;
            CAN_Msg[6] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "MC_SDS_CBC_CMD" (52|4, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_mod_v1_B.DataTypeConversion )
              + 0.5);
            CAN_Sgn.UnsignedSgn &= 0x0000000F;
            CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) << 4;
            CAN_Msg[6] |= CAN_Sgn.SgnBytes.Byte0;

            /* ...... "CRC_SDS_CBC_CMD" (56|8, standard signal, unsigned int, little endian) */
            /* Add or substract 0.5 in order to round to nearest integer */
            CAN_Sgn.UnsignedSgn = (UInt32) (( SDS_mod_v1_P.RHSC_CRC_Value ) +
              0.5);
            CAN_Sgn.UnsignedSgn &= 0x000000FF;
            CAN_Msg[7] |= CAN_Sgn.SgnBytes.Byte0;
          }

          /* Call user written decoding function  */
          can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]->datalen = 8;

          {
            Message_CRC_Encoder(CAN_Msg,
                                can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]);
          }

          /* ... Write the data to the CAN microcontroller and trigger the sending of the message */
          can_tp1_msg_send(can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359], abs
                           (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]->datalen)
                           > 8 ? 8 : abs
                           (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359]->datalen),
                           &(CAN_Msg[0]), delayTime);
        }
      }

      /* End of Outputs for SubSystem: '<S5>/SDS_CBC_CMD' */
    }
  } else {
    if (SDS_mod_v1_DW.SDS_CAN_Tx_Sub_MODE) {
      SDS_mod_v1_DW.SDS_CAN_Tx_Sub_MODE = false;
    }
  }

  /* End of Constant: '<Root>/SDS_CBC_CMD_TX_Trigger' */
  /* End of Outputs for SubSystem: '<Root>/SDS _CAN_Tx_Sub ' */

  /* S-Function (rti_commonblock): '<S6>/S-Function1' */
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
                            &SDS_mod_v1_B.SFunction1_o15_a,
                            can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]);
      }

      if (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->processed) {
        SDS_mod_v1_B.SFunction1_o12_c = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->processed;
        SDS_mod_v1_B.SFunction1_o13_o = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->timestamp;
        SDS_mod_v1_B.SFunction1_o14_i = (real_T)
          can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->deltatime;
        CAN_Msg = can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->data;

        /* ... Decode CAN Message */
        {
          rtican_Signal_t CAN_Sgn;

          /* ...... "Command_03_SwStat" (0|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_mod_v1_B.SFunction1_o1_a = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "Horn_Sw_Stat" (2|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 2;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o2_n = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "HDLP_SW_Stat" (4|3, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x00000007;
          SDS_mod_v1_B.SFunction1_o3_a = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "HAZ_SW_Stat" (7|1, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[0];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 7;
          CAN_Sgn.UnsignedSgn &= 0x00000001;
          SDS_mod_v1_B.SFunction1_o4_b = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "CBC_OVERLAY_MODE" (13|3, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[1];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 5;
          CAN_Sgn.UnsignedSgn &= 0x00000007;
          SDS_mod_v1_B.SFunction1_o5_f = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "IPDimmerPos_Stat" (16|4, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn &= 0x0000000F;
          SDS_mod_v1_B.SFunction1_o6_d = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "U_CALL_BtnStat" (20|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_mod_v1_B.SFunction1_o7_f = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "E_CALL_BtnStat" (22|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[2];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 6;
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_mod_v1_B.SFunction1_o8_o = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "WiperSpeed_Stat" (24|2, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn &= 0x00000003;
          SDS_mod_v1_B.SFunction1_o9_p = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "MC_SDS_CBC_STAT" (28|4, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[3];
          CAN_Sgn.UnsignedSgn = ((UInt32)CAN_Sgn.UnsignedSgn) >> 4;
          CAN_Sgn.UnsignedSgn &= 0x0000000F;
          SDS_mod_v1_B.SFunction1_o10_i = ((real_T) CAN_Sgn.UnsignedSgn);

          /* ...... "CRC_SDS_CBC_STAT" (32|8, standard signal, unsigned int, little endian) */
          CAN_Sgn.SgnBytes.Byte0 = CAN_Msg[4];
          CAN_Sgn.UnsignedSgn &= 0x000000FF;
          SDS_mod_v1_B.SFunction1_o11_f = ((real_T) CAN_Sgn.UnsignedSgn);
        }
      }
    }

    if (!can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A]->processed) {
      /* ... set RX status to 0 because no new message has arrived */
      SDS_mod_v1_B.SFunction1_o12_c = 0.0;
    }
  }

  /* RelationalOperator: '<S3>/Compare' incorporates:
   *  Constant: '<S3>/Constant'
   */
  SDS_mod_v1_B.Compare = (SDS_mod_v1_B.SFunction1_o15_a >
    SDS_mod_v1_P.CRC_is_OK1_const);

  /* S-Function (rti_commonblock): '<S1>/S-Function1' */
  /* This comment workarounds a code generation problem */
}

/* Model update function */
void SDS_mod_v1_update(void)
{
  /* Update for Enabled SubSystem: '<Root>/SDS _CAN_Tx_Sub ' incorporates:
   *  EnablePort: '<S5>/Enable'
   */
  if (SDS_mod_v1_DW.SDS_CAN_Tx_Sub_MODE) {
    if (SDS_mod_v1_M->Timing.TaskCounters.TID[1] == 0) {
      /* Update for UnitDelay: '<S10>/Output' */
      SDS_mod_v1_DW.Output_DSTATE = SDS_mod_v1_B.FixPtSwitch;
    }
  }

  /* End of Update for SubSystem: '<Root>/SDS _CAN_Tx_Sub ' */

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++SDS_mod_v1_M->Timing.clockTick0)) {
    ++SDS_mod_v1_M->Timing.clockTickH0;
  }

  SDS_mod_v1_M->Timing.taskTime0 = SDS_mod_v1_M->Timing.clockTick0 *
    SDS_mod_v1_M->Timing.stepSize0 + SDS_mod_v1_M->Timing.clockTickH0 *
    SDS_mod_v1_M->Timing.stepSize0 * 4294967296.0;
  rate_scheduler();
}

/* Model initialize function */
void SDS_mod_v1_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)SDS_mod_v1_M, 0,
                sizeof(RT_MODEL_SDS_mod_v1_T));
  SDS_mod_v1_M->Timing.stepSize0 = 0.001;

  /* block I/O */
  (void) memset(((void *) &SDS_mod_v1_B), 0,
                sizeof(B_SDS_mod_v1_T));

  /* states (dwork) */
  (void) memset((void *)&SDS_mod_v1_DW, 0,
                sizeof(DW_SDS_mod_v1_T));

  {
    /* user code (registration function declaration) */
    /*Initialize global TRC pointers. */
    SDS_mod_v1_rti_init_trc_pointers();
  }

  /* Start for Enabled SubSystem: '<Root>/SDS _CAN_Tx_Sub ' */
  SDS_mod_v1_DW.SDS_CAN_Tx_Sub_MODE = false;

  /* SystemInitialize for Enabled SubSystem: '<Root>/SDS _CAN_Tx_Sub ' */
  /* InitializeConditions for UnitDelay: '<S10>/Output' */
  SDS_mod_v1_DW.Output_DSTATE = SDS_mod_v1_P.Output_InitialCondition;

  /* SystemInitialize for Enabled SubSystem: '<S5>/SDS_CBC_CMD' */
  /* SystemInitialize for Outport: '<S11>/TX status' */
  SDS_mod_v1_B.SFunction1 = SDS_mod_v1_P.TXstatus_Y0;

  /* End of SystemInitialize for SubSystem: '<S5>/SDS_CBC_CMD' */
  /* End of SystemInitialize for SubSystem: '<Root>/SDS _CAN_Tx_Sub ' */
}

/* Model terminate function */
void SDS_mod_v1_terminate(void)
{
  /* Terminate for S-Function (rti_commonblock): '<S2>/S-Function1' */

  /* dSPACE RTICAN RX Message Block: "CBC_PT1" Id:820 */
  {
    /* ... Set the message into sleep mode */
    while ((rtican_type1_tq_error[0][0] = can_tp1_msg_sleep
            (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X334])) ==
           DSMCOM_BUFFER_OVERFLOW) ;
  }

  /* Terminate for Enabled SubSystem: '<Root>/SDS _CAN_Tx_Sub ' */
  /* Terminate for Enabled SubSystem: '<S5>/SDS_CBC_CMD' */
  /* Terminate for S-Function (rti_commonblock): '<S11>/S-Function1' incorporates:
   *  Constant: '<Root>/RHSC_CRC'
   *  Constant: '<Root>/SDS_CBC_CMD3'
   *  Constant: '<Root>/SDS_CBC_ConvLmpRst'
   *  Constant: '<Root>/SDS_CBC_HAZ_SW'
   *  Constant: '<Root>/SDS_CBC_HDLP_SW'
   *  Constant: '<Root>/SDS_CBC_HDLP_Wash'
   *  Constant: '<Root>/SDS_CBC_HiBmLvr'
   *  Constant: '<Root>/SDS_CBC_Horn'
   *  Constant: '<Root>/SDS_CBC_IGNPOS'
   *  Constant: '<Root>/SDS_CBC_IP_Dimmer'
   *  Constant: '<Root>/SDS_CBC_OVERLAY_REQ'
   *  Constant: '<Root>/SDS_CBC_RFFunct'
   *  Constant: '<Root>/SDS_CBC_TRN-I_1L_2R_0N'
   *  Constant: '<Root>/SDS_CBC_WPRSW'
   *  Constant: '<Root>/SDS_CBC_WPR_Wash'
   *  Constant: '<Root>/SDS_CBC_WprWshSW'
   */

  /* dSPACE RTICAN TX Message Block: "SDS_CBC_CMD" Id:857 */
  {
    /* ... Set the message into sleep mode */
    while ((rtican_type1_tq_error[0][1] = can_tp1_msg_sleep
            (can_type1_msg_M1[CANTP1_M1_C1_TX_STD_0X359])) ==
           DSMCOM_BUFFER_OVERFLOW) ;
  }

  /* End of Terminate for SubSystem: '<S5>/SDS_CBC_CMD' */
  /* End of Terminate for SubSystem: '<Root>/SDS _CAN_Tx_Sub ' */

  /* Terminate for S-Function (rti_commonblock): '<S6>/S-Function1' */

  /* dSPACE RTICAN RX Message Block: "SDS_CBC_STAT" Id:858 */
  {
    /* ... Set the message into sleep mode */
    while ((rtican_type1_tq_error[0][2] = can_tp1_msg_sleep
            (can_type1_msg_M1[CANTP1_M1_C1_RX_STD_0X35A])) ==
           DSMCOM_BUFFER_OVERFLOW) ;
  }
}
