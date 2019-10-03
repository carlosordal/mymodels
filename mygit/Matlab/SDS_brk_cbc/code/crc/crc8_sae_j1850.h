#pragma once
// The _bit, _byte, and _word routines return the CRC of the len bytes at mem,
// applied to the previous CRC value, crc. If mem is NULL, then the other
// arguments are ignored, and the initial CRC, i.e. the CRC of zero bytes, is
// returned. Those routines will all return the same result, differing only in
// speed and code complexity. The _rem routine returns the CRC of the remaining
// bits in the last byte, for when the number of bits in the message is not a
// multiple of eight. The high bits bits of the low byte of val are applied to
// crc. bits must be in 0..8.

#include <stddef.h>

// Compute the CRC a byte at a time.
unsigned crc8_sae_j1850_byte(unsigned crc, void const* mem, size_t len);

