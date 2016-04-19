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

 static uint8_t mode = 0;
 static uint8_t bits = 8;
 static uint32_t speed = 5000000;

 char ADC_ID[3] = {0x00,0x81,0x00} ; // chip ID
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

 static void pabort(const char *s)
 {
 	perror(s);
 	abort();
 }

int main()
{
			int file, k;
			int adapter_nr = 1; /* probably dynamically determined */
			char filename[20];
			int i, fd;
			int ret = 0;
			printf("Send data to ADC..... ");
//								for (i = 0; i < 5; i++){
								//	snprintf(filename, 19, "/dev/spidev32766.%d",i);
			snprintf(filename, 19, "/dev/spidev32766.0");
										fd = open(filename, O_RDWR);
										if (fd < 0)
											pabort("can't open device");
									// spi mode
										ret = ioctl(fd, SPI_IOC_WR_MODE, &mode);
										if (ret == -1)
											pabort("can't set spi mode");

									ret = ioctl(fd, SPI_IOC_RD_MODE, &mode);
										if (ret == -1)
											pabort("can't get spi mode");

									// bits per word
										ret = ioctl(fd, SPI_IOC_WR_BITS_PER_WORD, &bits);
										if (ret == -1)
											pabort("can't set bits per word");

										ret = ioctl(fd, SPI_IOC_RD_BITS_PER_WORD, &bits);
										if (ret == -1)
											pabort("can't get bits per word");

									// max speed hz
										ret = ioctl(fd, SPI_IOC_WR_MAX_SPEED_HZ, &speed);
										if (ret == -1)
											pabort("can't set max speed hz");

										ret = ioctl(fd, SPI_IOC_RD_MAX_SPEED_HZ, &speed);
										if (ret == -1)
											pabort("can't get max speed hz");

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

										if (write(fd, ADC_ID, sizeof(ADC_ID)) != sizeof(ADC_ID)) {
												exit(3);
										}
										/*
										if (write(fd, ADC_LVDS, sizeof(ADC_LVDS)) != sizeof(ADC_LVDS)) {
										    	exit(3);
										}
										if (write(fd, ADC_VREF, sizeof(ADC_VREF)) != sizeof(ADC_VREF)) {
												exit(3);
										}
										if (write(fd, NormalMode, sizeof(NormalMode)) != sizeof(NormalMode)) {
												exit(3);
										}
										*/
										close(fd);
										usleep (100);
//								};

			printf("Done!\n\r");


}






/*
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


void usage(void)
{
	printf("|    -e External trigger   |\n");
	printf("|    -i internal trigger   |\n");
//	printf("    -g not defined\n");
//	printf("    -o not defined\n");
	return;
}
*/
