GCC=avr-gcc
HEX=avr-objcopy
UPL=avrdude
CFLAGS=-Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o # I'm not sure what the first flag does
LFLAGS=-mmcu=atmega328p  # Library linking
AFLAGS=-O ihex -R .eeprom
UFLAGS=-F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:$(HEXFILE)

# I can probably find a better way to do this. For example I might wnat to add these variables directly in their recipies?
CFILE=led.c
OFILE=led.o
EFILE=led
HEXFILE=led.hex

.PHONY: clean all upload

all: led.hex

led.hex: led
	$(HEX) $(AFLAGS) led led.hex

led: led.o
	$(GCC) $(LFLAGS) led.o -o led

led.o:
	$(GCC) $(CFLAGS) led.o led.c

upload: led.hex
	sudo $(UPL) $(UFLAGS)
