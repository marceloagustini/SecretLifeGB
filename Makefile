#
# Simple Generic GBDK Makefile
#

# GBDK Directory (Try to find it, or set it manually)
# If GBDK_HOME is set in your environment, use it.
# Otherwise, look in common locations.
ifndef GBDK_HOME
	ifneq (,$(wildcard /opt/gbdk/bin/lcc))
		GBDK_HOME = /opt/gbdk
	else ifneq (,$(wildcard /usr/local/gbdk/bin/lcc))
		GBDK_HOME = /usr/local/gbdk
	else ifneq (,$(wildcard ./gbdk/bin/lcc))
		GBDK_HOME = ./gbdk
	else
		# Fallback: Assume lcc is in PATH (standard behavior)
		# But since we build the path with bin/lcc below, if it's strictly in path without GBDK_HOME logic,
		# we might want to just set CC directly.
		# Let's handle the case where we just want "lcc"
		GBDK_HOME = /usr/local/gbdk
	endif
endif

# Toolchain
# Check if GBDK_HOME was found, otherwise assume lcc is in PATH
ifeq ($(GBDK_HOME),)
	CC = lcc
else
	CC = $(GBDK_HOME)/bin/lcc
endif


# Output filename
BINS	= game.gb

# Source files
CSOURCES   := $(wildcard src/*.c) $(wildcard src/states/*.c) $(wildcard src/utils/*.c) $(wildcard src/data/*.c) $(wildcard res/*.c)
ASMSOURCES := $(wildcard src/*.s)

# Object files (automatically derived from source files)
OBJS       = $(CSOURCES:%.c=%.o) $(ASMSOURCES:%.s=%.o)

# Compilation flags
# -Wa-l passes -l to the assembler (generate listing)
# -Wl-m passes -m to the linker (generate map file)
# -Wl-j passes -j to the linker (generate noICE file)
# -Wm-yC enables GameBoy Color compatibility (C = color)
# -Wm-yS enables Super GameBoy compatibility (S = SGB)
CFLAGS	= 

all:	$(BINS)

# Link all objects into the binary
$(BINS):	$(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# Compile .c files to .o files
%.o:	%.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Compile .s files to .o files
%.o:	%.s
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f *.o *.lst *.map *.gb *.ihx *.sym *.cdb *.adb *.asm
	rm -f src/*.o src/states/*.o src/utils/*.o res/*.o
