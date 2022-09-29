CROSS_COMPILE:=riscv64-linux-

CC	:= $(CROSS_COMPILE)gcc
C++	:= $(CROSS_COMPILE)g++
OBJDUMP	:= $(CROSS_COMPILE)objdump
OBJCOPY := $(CROSS_COMPILE)objcopy
AR	:= $(CROSS_COMPILE)ar
AS	:= $(CROSS_COMPILE)as
LD	:= $(CROSS_COMPILE)gcc

PROG = $(shell pwd |sed 's/^\(.*\)[/]//' )

DIRS := $(shell find -type d | grep -v .settings |grep -v Debug)
INCLUDES := $(addprefix -I , $(DIRS))
SRCS := $(foreach dir,$(DIRS) , $(wildcard $(dir)/*.c) $(wildcard $(dir)/*.cpp) $(wildcard $(dir)/*.S) $(wildcard $(dir)/*.s))
OBJS := $(patsubst %.s,%.o,$(patsubst %.S,%.o,$(patsubst %.cpp,%.o,$(patsubst %.c,%.o,${SRCS}))))

LDFLAGS = -static
CFLAGS = -g -Wall -static

errno: errno.c
	$(CC) $(CFLAGS) $< -o $@

clean:
	@rm -f errno

all: $(PROG)

$(PROG): $(OBJS)
	$(LD) $(LDFLAGS) -o $@.out $(LDFLAGS) $(OBJS) $(LIBS)
	$(OBJCOPY) -O binary -S $(PROG).out $(PROG).bin
	$(OBJDUMP) -d $(PROG).out > $(PROG).asm
	@echo Completed

clean :
	@rm -f $(OBJS) $(OBJS:.o=.d) $(OBJS:.o=.gcda) $(OBJS:.o=.gcno)
	@rm -f $(PROG).out
	@rm -f $(PROG).bin
	@rm -f $(PROG).asm
