#include <stdio.h>
#include <stdlib.h>

#include "lib/ini/INIReader.h"
#include "lib/spi/spi.h"
#include "lib/uart/uart.h"

#include "device_reader.h"


int main(int argc, char **argv)
{
	printf("Hello world\n");

	char tmp[256];
	INIReader iniReader(SETTING_FILE);

	return 0;
}
