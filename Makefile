# Ricobot Makefile for GNU/Linux

OBJ=bot.o bot_client.o dll.o engine.o h_export.o util.o

CCOPT = -O2 -DNDEBUG
CCDEBUG = -ggdb3 -D_DEBUG

SDKTOP = /mnt/hl/hlsdk/multiplayer
METAMODDIR = /mnt/hl/metamod-1.17/metamod

CFLAGS = $(CCOPT) -w -I$(METAMODDIR) -I$(SDKTOP)/common -I$(SDKTOP)/engine -I$(SDKTOP)/pm_shared -I$(SDKTOP)/dlls
#CFLAGS = $(CCDEBUG) -w -I$(METAMODDIR) -I$(SDKTOP)/common -I$(SDKTOP)/engine -I$(SDKTOP)/pm_shared -I$(SDKTOP)/dlls

BASEFLAGS=-Dstricmp=strcasecmp -Dstrcmpi=strcasecmp
CPPFLAGS=${BASEFLAGS} ${CFLAGS}

ricobot_mm_i386.so:	${OBJ}
	g++ -fPIC -shared -static -o $@ ${OBJ} -ldl -lm

clean:
	-rm -f *.o
	-rm -f *.so

%.o:	%.cpp
	g++ ${CPPFLAGS} -c $< -o $@
