INCLUDES = -I/opt/esp-open-sdk/sdk/include

TOOLCHAIN = xtensa-lx106-elf-

CC = $(TOOLCHAIN)gcc
AR = $(TOOLCHAIN)ar

CFLAGS += -std=gnu99 -Os -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls
CFLAGS += -mtext-section-literals -D__ets__ -DICACHE_FLASH

CSOURCES = $(wildcard *.c)
SSOURCES = $(wildcard *.S)

.PHONY: all clean

all: libespcont.a

clean:
	rm -f *.a *.o

libespcont.a: $(patsubst %.c, %.o, $(CSOURCES)) $(patsubst %.S, %.o, $(SSOURCES))
	$(AR) rcs $@ $^

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -o $@ -c $^

%.o: %.S
	$(CC) $(CFLAGS) $(INCLUDES) -o $@ -c $^
