TARGET		:= template.a26

CFG		:= atari2600.cfg
DBG		:= $(TARGET:%.a26=%.dbg)
LBL		:= $(TARGET:%.a26=%.label)
LST		:= $(TARGET:%.a26=%.lst)
MAP		:= $(TARGET:%.a26=%.map)
SRC		:= $(wildcard src/*.s)
OBJ		:= $(SRC:%.s=%.o)
SYM		:= $(TARGET:%.a26=%.sym)

# Pretty print
V		= @
Q		= $(V:1=)
QUIET_AS	= $(Q:@=@echo    '     AS       '$@;)
QUIET_CLEAN	= $(Q:@=@echo    '     CLEAN    '$@;)
QUIET_EMU	= $(Q:@=@echo    '     EMU      '$@;)
QUIET_GEN	= $(Q:@=@echo    '     GEN      '$@;)
QUIET_LD	= $(Q:@=@echo    '     LD       '$@;)

# Programs
AS		:= $(shell which ca65)
AWK		:= $(shell which awk)
LD		:= $(shell which ld65)
RM		:= $(shell which rm)
EMU		:= $(shell which stella)

ifeq ($(EMU),)
EMU		:= $(shell which Stella)
endif

# Flags
ASFLAGS		:= -g -I inc -l $(LST)
AWKFLAGS	:= '{ print $$3 "    " $$2 }'
LDFLAGS		:= -C $(CFG) -m $(MAP) -Ln $(LBL) --dbgfile $(DBG)

all: $(TARGET) $(SYM)

$(TARGET): $(OBJ)
	$(QUIET_LD) $(LD) $(LDFLAGS) -o $@ $?

.s.o:
	$(QUIET_AS) $(AS) $(ASFLAGS) -o $@ $<

$(SYM): $(LBL)
	$(QUIET_GEN) $(AWK) $(AWKFLAGS) $(LBL) > $@

run: $(TARGET) $(SYM)
	$(QUIET_EMU) $(EMU) $<

debug: $(TARGET) $(SYM)
	$(QUIET_EMU) $(EMU) -debug $<

clean:
	$(QUIET_CLEAN) $(RM) -f				\
		*.a26					\
		*.dbg					\
		*.label					\
		*.lst					\
		*.map					\
		*.sym					\
		src/*.o

.PHONY: all run debug clean
