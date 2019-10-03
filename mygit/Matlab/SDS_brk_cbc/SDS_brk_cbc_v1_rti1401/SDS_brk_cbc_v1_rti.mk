# =============================================================================
#  Make include file SDS_brk_cbc_v1_rti.mk:
#
#   RTI1401 7.10 (02-May-2018)
#   Wed Oct  2 13:56:06 2019
#
#   Copyright 2018, dSPACE GmbH. All rights reserved.
# =============================================================================

# Initialize variables used in blockset makefiles -----------------------------

BLOCKSET_LIBS     :=
BLOCKSET_SRCS     :=
BLOCKSET_INCLUDES :=

# Default rules for additional blocksets --------------------------------------

blockset_init          :
blockset_clean         :
blockset_deps          :
blockset_after_linkage :

# Includes for additional blocksets -------------------------------------------

%include "$(DSPACE_ROOT)\matlab\rtican\c\rtican.mk"


# Model-specific options ------------------------------------------------------

# Additional C source files declared by the model
MDL_CUSTOM_C_SRCS = rti_assert.c rtican_err1.c

# Additional assembler source files declared by the model
MDL_CUSTOM_ASM_SRCS =

# Additional libraries declared by the model
MDL_CUSTOM_LIBS = \
  "$(DSPACE_ROOT)\DS1401\RTPython\dsrtt1401.lib"

# Additional objects declared by the model
MDL_CUSTOM_OBJS =

# Directories where additional C and assembler source files are stored
MDL_CUSTOM_SRCS_DIR =

# Directories where additional header files are stored
MDL_CUSTOM_INCLUDES_PATH = \
  "$(DSPACE_ROOT)\DS1401\RTPython"

# Dependencies declared by the model
SDS_brk_cbc_v1.$(OBJ_EXT) :"rtican_include.h" 

# Define build type information
BUILDTYPE = RTI

# EOF -------------------------------------------------------------------------
