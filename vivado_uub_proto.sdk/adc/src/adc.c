/*
Program to set ADC AD9628
R. Assiro april 2016
 */
#include <fcntl.h>
#include <stdio.h>
#include <linux/i2c-dev.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>
#include <stdint.h>
#include <unistd.h>
#include <stdlib.h>
#include <getopt.h>


#include <stdlib.h>
#include <sys/mman.h>


 char ADC_LVDS[3] = {0x00,0x14,0xA0} ; // ADC bus configuration LVDS interleave
 char ADC_RESET[3] = {0x00,0x00,0x3C} ; // ADC reset
 char ADC_VREF[3] = {0x00,0x18,0x04} ; // ADC VREF setting
 char ADC_DELAY[3] = {0x00,0x17,0x25} ; // ADC delay

 char cmd2channel[3] = {0x00,0x05,0x03}; // Select the 2 channels for previous cmd
 char cmdchannelA[3] = {0x00,0x05,0x01}; // Select the channel A for previous cmd
 char cmdchannelB[3] = {0x00,0x05,0x02}; // Select the channel B for previous cmd

 char TestModeMS[3]  = {0x00,0x0D,0x01}; // ADC Test Mode Middle Scale
 char TestModeFS[3]  = {0x00,0x0D,0x02}; // ADC Test Mode Full Scale
 char NormalMode[3] = {0x00,0x0D,0x00}; // ADC Normal mode
 char TestModeRM[3] = {0x00,0x0D,0x5F}; // ADC Test Mode Ramp
 char TestModeA5[3] = {0x00,0x0D,0x44}; // ADC Test Mode AAA555

 char TstUser1LSB[3] = {0x00,0x19,0x55}; // User defined pattern 1 LSB
 char TstUser1MSB[3] = {0x00,0x1A,0xAA}; // User defined pattern 1 MSB
 char TestModeUM[3]  = {0x00,0x0D,0x08}; // ADC Test Mode USER1
 char AdcDelay[5]    = {0x00};           // Calculated ADC delay table


#define IN 0
#define OUT 1


int main(int argc, char *argv[])
{
	int c;
	int fd;
	int direction=IN;
	unsigned gpio_addr = 0;
	int value = 0;

	unsigned page_addr, page_offset;
	void *ptr;
	unsigned page_size=sysconf(_SC_PAGESIZE);

	printf("GPIO access through /dev/mem.\n", page_size);

	/* Parse command line arguements */
	while((c = getopt(argc, argv, "g:io:h")) != -1) {
		switch(c) {
		case 'g':
			gpio_addr=strtoul(optarg,NULL, 0);
			break;
		case 'i':
			direction=IN;
			break;
		case 'o':
			direction=OUT;
			value=atoi(optarg);
			break;
		case 'h':
			usage();
			return 0;
		default:
			printf("invalid option: %c\n", (char)c);
			usage();
			return -1;
		}

	}

	if (gpio_addr == 0) {
		printf("GPIO physical address is required.\n");
		usage();
		return -1;
	}



	if (direction == IN) {

		printf("test 1\n");
	}




	return 0;
}






 /*
int main(int argc, char *argv[])
{
	printf("Test argomento in line command:!\n");

	while(argc--)
		printf("%s\n",*argv++);

	int ord;
	char c;
	if (argc>1) ord = argv[1];


// Parse command line arguements
	while((c = getopt(argc, argv, "ie")) != -1) {
		switch(c) {
		case 'g':
			printf("case1\n");
			break;
		case 'i':
			printf("case2\n");
			break;
		case 'o':
			printf("case3\n");
			break;

		default:
			printf("invalid option: %c\n", (char)c);
			usage();
			return -1;
		}

	}

	return 0;
}

*/
void usage(void)
{
	printf("|    -e External trigger   |\n");
	printf("|    -i internal trigger   |\n");
//	printf("    -g not defined\n");
//	printf("    -o not defined\n");
	return;
}
