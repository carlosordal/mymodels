/*********************** dSPACE target specific file *************************

   Header file SDS_brk_cbc_v1_trc_ptr.h:

   Declaration of function that initializes the global TRC pointers

   RTI1401 7.10 (02-May-2018)
   Wed Oct  2 20:12:13 2019

   Copyright 2019, dSPACE GmbH. All rights reserved.

 *****************************************************************************/
#ifndef RTI_HEADER_SDS_brk_cbc_v1_trc_ptr_h_
#define RTI_HEADER_SDS_brk_cbc_v1_trc_ptr_h_

/* Include the model header file. */
#include "SDS_brk_cbc_v1.h"
#include "SDS_brk_cbc_v1_private.h"
#ifdef EXTERN_C
#undef EXTERN_C
#endif

#ifdef __cplusplus
#define EXTERN_C                       extern "C"
#else
#define EXTERN_C                       extern
#endif

/*
 *  Declare the global TRC pointers
 */
EXTERN_C volatile real_T *p_0_SDS_brk_cbc_v1_real_T_0;
EXTERN_C volatile uint8_T *p_0_SDS_brk_cbc_v1_uint8_T_1;
EXTERN_C volatile boolean_T *p_0_SDS_brk_cbc_v1_boolean_T_2;
EXTERN_C volatile real_T *p_1_SDS_brk_cbc_v1_real_T_0;
EXTERN_C volatile uint8_T *p_1_SDS_brk_cbc_v1_uint8_T_1;
EXTERN_C volatile real_T *p_1_SDS_brk_cbc_v1_real_T_2;
EXTERN_C volatile uint8_T *p_1_SDS_brk_cbc_v1_uint8_T_3;
EXTERN_C volatile int_T *p_2_SDS_brk_cbc_v1_int_T_0;
EXTERN_C volatile uint8_T *p_2_SDS_brk_cbc_v1_uint8_T_1;
EXTERN_C volatile boolean_T *p_2_SDS_brk_cbc_v1_boolean_T_2;

/*
 *  Declare the general function for TRC pointer initialization
 */
EXTERN_C void SDS_brk_cbc_v1_rti_init_trc_pointers(void);

#endif                                 /* RTI_HEADER_SDS_brk_cbc_v1_trc_ptr_h_ */
