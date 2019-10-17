/***************************************************************************

   Source file SDS_brk_cbc_v1_trc_ptr.c:

   Definition of function that initializes the global TRC pointers

   RTI1401 7.10 (02-May-2018)
   Wed Oct  2 20:12:13 2019

   Copyright 2019, dSPACE GmbH. All rights reserved.

 *****************************************************************************/

/* Include header file. */
#include "SDS_brk_cbc_v1_trc_ptr.h"
#include "SDS_brk_cbc_v1.h"
#include "SDS_brk_cbc_v1_private.h"

/* Compiler options to turn off optimization. */
#if !defined(DS_OPTIMIZE_INIT_TRC_POINTERS)
#ifdef _MCCPPC

#pragma options -nOt -nOr -nOi -nOx

#endif

#ifdef __GNUC__

#pragma GCC optimize ("O0")

#endif

#ifdef _MSC_VER

#pragma optimize ("", off)

#endif
#endif

/* Definition of Global pointers to data type transitions (for TRC-file access) */
volatile real_T *p_0_SDS_brk_cbc_v1_real_T_0 = NULL;
volatile uint8_T *p_0_SDS_brk_cbc_v1_uint8_T_1 = NULL;
volatile boolean_T *p_0_SDS_brk_cbc_v1_boolean_T_2 = NULL;
volatile real_T *p_1_SDS_brk_cbc_v1_real_T_0 = NULL;
volatile uint8_T *p_1_SDS_brk_cbc_v1_uint8_T_1 = NULL;
volatile real_T *p_1_SDS_brk_cbc_v1_real_T_2 = NULL;
volatile uint8_T *p_1_SDS_brk_cbc_v1_uint8_T_3 = NULL;
volatile int_T *p_2_SDS_brk_cbc_v1_int_T_0 = NULL;
volatile uint8_T *p_2_SDS_brk_cbc_v1_uint8_T_1 = NULL;
volatile boolean_T *p_2_SDS_brk_cbc_v1_boolean_T_2 = NULL;

/*
 *  Declare the functions, that initially assign TRC pointers
 */
static void rti_init_trc_pointers_0(void);

/* Global pointers to data type transitions are separated in different functions to avoid overloading */
static void rti_init_trc_pointers_0(void)
{
  p_0_SDS_brk_cbc_v1_real_T_0 = &SDS_brk_cbc_v1_B.DataTypeConversion1;
  p_0_SDS_brk_cbc_v1_uint8_T_1 = &SDS_brk_cbc_v1_B.Output;
  p_0_SDS_brk_cbc_v1_boolean_T_2 = &SDS_brk_cbc_v1_B.Compare;
  p_1_SDS_brk_cbc_v1_real_T_0 = &SDS_brk_cbc_v1_P.CRC_is_OK1_const;
  p_1_SDS_brk_cbc_v1_uint8_T_1 = &SDS_brk_cbc_v1_P.CounterLimited1_uplimit;
  p_1_SDS_brk_cbc_v1_real_T_2 = &SDS_brk_cbc_v1_P.TXstatus_Y0;
  p_1_SDS_brk_cbc_v1_uint8_T_3 = &SDS_brk_cbc_v1_P.FixPtConstant_Value;
  p_2_SDS_brk_cbc_v1_int_T_0 = &SDS_brk_cbc_v1_DW.SFunction1_IWORK[0];
  p_2_SDS_brk_cbc_v1_uint8_T_1 = &SDS_brk_cbc_v1_DW.Output_DSTATE;
  p_2_SDS_brk_cbc_v1_boolean_T_2 = &SDS_brk_cbc_v1_DW.SDS_CAN_Tx_Sub_MODE;
}

void SDS_brk_cbc_v1_rti_init_trc_pointers(void)
{
  rti_init_trc_pointers_0();
}
