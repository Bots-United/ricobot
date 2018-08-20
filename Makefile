# Ricobot Makefile for GNU/Linux

OBJ=bot.o bot_client.o dll.o engine.o h_export.o util.o

CCOPT = -O2 -DNDEBUG
CCDEBUG = -g -D_DEBUG
CCARCH = -m32

SDKTOP = ../hlsdk
METAMODDIR = ../metamod-hl1/metamod

CFLAGS = $(CCOPT) -w -I$(METAMODDIR) -I$(SDKTOP)/common -I$(SDKTOP)/engine -I$(SDKTOP)/pm_shared -I$(SDKTOP)/dlls -I$(SDKTOP)/public
#CFLAGS = $(CCDEBUG) -w -I$(METAMODDIR) -I$(SDKTOP)/common -I$(SDKTOP)/engine -I$(SDKTOP)/pm_shared -I$(SDKTOP)/dlls -I$(SDKTOP)/public

BASEFLAGS=-Dstricmp=strcasecmp -Dstrcmpi=strcasecmp
CPPFLAGS=${BASEFLAGS} ${CFLAGS}

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
SO_SUFFIX = so
endif
ifeq ($(UNAME_S),Darwin)
SO_SUFFIX = dylib
endif

ricobot_mm_i386.${SO_SUFFIX}:	${OBJ}
	g++ ${CCARCH} -fPIC -shared -o $@ ${OBJ} -ldl -lm

clean:
	-rm -f *.o
	-rm -f *.${SO_SUFFIX}

%.o:	%.cpp
	g++ ${CPPFLAGS} ${CCARCH} -c $< -o $@
