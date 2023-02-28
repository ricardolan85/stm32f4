PROJECT	= stm32f4
DEVICE	= STM32F411xE

CSRCS	= ivt.c boot.c main.c 
OBJ		= ivt.o boot.o main.o
LDS		= stm32f4.ld

PREFIX	= arm-none-eabi
CC		= $(PREFIX)-gcc
OBJCOPY	= $(PREFIX)-objcopy

CFLAGS	=  -W -Wall 
CFLAGS 	+= -g3 -Os -ffunction-sections -fdata-sections
CFLAGS  += -mcpu=cortex-m4 -mthumb -mlittle-endian
CFLAGS  += -I./include/ -I./ 
CFLAGS 	+= -D$(DEVICE)

LDFLAGS	= -T$(LDS) --specs=nano.specs --specs=nosys.specs -Wl,--gc-sections -Wl,-Map=$@.map

OBJS = $(SOURCES:.c=.o)

all: $(PROJECT).elf

# compile
$(PROJECT).elf: $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $@ $(LDFLAGS)

%.o: %.c $(DEPS)
	$(CC) -c $(CFLAGS) $< -o $@

bin: $(PROJECT).elf
	$(OBJCOPY) -O binary $(PROJECT).elf $(PROJECT).bin

hex: $(PROJECT).elf
	$(OBJCOPY) -O ihex $(PROJECT).elf $(PROJECT).hex

size: $(PROJECT).elf
	$(PREFIX)-size $(PROJECT).elf

readelf: $(PROJECT).elf
	$(PREFIX)-readelf -s $(PROJECT).elf

dump: $(PROJECT).elf
	$(PREFIX)-objdump -d $(PROJECT).elf > $(PROJECT).dump

clean:
	del *.elf
	del *.o
	del *.hex
	del *.bin
	del *.dump
	del *.map
