/*
 * main.c
 *
 *  Created on: May 8, 2020
 *      Author: Renan Augusto Starke
 *      Instituto Federal de Santa Catarina
 *
 *		Nios II GPIO example.
 * 
 *      Note: Quartus 19.1 does not distribute Eclipse anymore. 
 *            Install instructions are included in the <Intel Quartus installation directory>/nios2eds/bin/README.
 * 
 */

#include <stdio.h>
#include <stdint.h>

#include "system.h"
#include "altera_avalon_pio_regs.h"

int main()
{
	uint32_t data = 0;
	uint32_t delay  = 0;
	uint8_t switches = 0;

	printf("Nios II: Hello IFSC!\n");

	while (1){

		/* Switches: Avalon bus inpout pooling */
		switches = IORD_ALTERA_AVALON_PIO_DATA(KEY_BASE);
		if (switches) data = 0;

		/* Avalon write */
		IOWR_ALTERA_AVALON_PIO_DATA(HEX_BASE, data);

		/* Software delay */
		for(delay=0; delay < 10000; delay++);
		data++;
	}

	return 0;
}
