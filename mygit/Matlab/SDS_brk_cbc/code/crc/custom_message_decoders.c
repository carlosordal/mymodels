#include <rtican_usercoding.h>
#include "crc8_sae_j1850.h"
#define MAX_MESSAGE_SIZE 20



// These are "Generic" Encoder & Decoder
void Message_CRC_Encoder(UInt32 *const CAN_Msg, can_tp1_canMsg* const msg)
{
  /********************************************************************
  * A Generic message encoder, used for CRC calculation & assignment
  * Assumes that the CRC is in the LAST byte
  *******************************************************************/
  // Constants:
  const size_t data_size = msg->datalen-1;

  // Data
  static unsigned char data[MAX_MESSAGE_SIZE];
  memset(data, 0, sizeof(data));
  size_t i;  

  // Assigning
  for (i=0;i<data_size;i++)
  {
    data[i] = CAN_Msg[i];
  }

  UInt32 crc_result = crc8_sae_j1850_byte(0, data, data_size);

  CAN_Msg[data_size] =  crc_result;
}

void Message_CRC_Decoder(UInt32 *const CAN_Msg, dsfloat *const out, can_tp1_canMsg* const msg)
{
  /********************************************************************
  * A Generic message decoder, used for CRC calculation & assignment
  * Assumes that the CRC is in the LAST byte
  *******************************************************************/
  // Constants:
  const size_t data_size = msg->datalen-1;

  // Data
  static unsigned char data[MAX_MESSAGE_SIZE];
  memset(data, 0, sizeof(data));
  size_t i;  

  // Assigning
  for (i=0;i<data_size;i++)
  {
    data[i] = CAN_Msg[i];
  }

  UInt32 crc_result =  (UInt32) crc8_sae_j1850_byte(0, data, data_size);

  if (CAN_Msg[data_size] == crc_result)
  {
    out[0] = 1.0;
  } else
  {
    out[0]=0.0;
  }
}
