// UUB SPI adventure
<<<<<<< HEAD
//////////////////////// SPI CONFIGURATION ///////////////////////////////////////
#include <fcntl.h>
#include <stdio.h>
#include <linux/i2c-dev.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>
=======
#include <fcntl.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>

>>>>>>> 2beaa5130f425292206b0f1e5bde86633226516b
#include <stdint.h>
#include <unistd.h>
#include <stdlib.h>
#include <getopt.h>


<<<<<<< HEAD
=======

>>>>>>> 2beaa5130f425292206b0f1e5bde86633226516b
 char ADC_LVDS[3] = {0x00,0x14,0xA0} ; // ADC bus configuration LVDS interleave
 char ADC_RESET[3] = {0x00,0x00,0x3C} ; // ADC reset
 char ADC_VREF[3] = {0x00,0x18,0x04} ; // ADC VREF setting
 char ADC_DELAY[3] = {0x00,0x17,0x25} ; // ADC delay

<<<<<<< HEAD
=======
 // R/W = 0, W1-W0 = 0, @ high = 0 ; @ register = 0x14; data to write = A1
>>>>>>> 2beaa5130f425292206b0f1e5bde86633226516b
 char cmd2channel[3] = {0x00,0x05,0x03}; // Select the 2 channels for previous cmd
 char cmdchannelA[3] = {0x00,0x05,0x01}; // Select the channel A for previous cmd
 char cmdchannelB[3] = {0x00,0x05,0x02}; // Select the channel B for previous cmd

 char TestModeMS[3]  = {0x00,0x0D,0x01}; // ADC Test Mode Middle Scale
 char TestModeFS[3]  = {0x00,0x0D,0x02}; // ADC Test Mode Full Scale
 char NormalMode[3] = {0x00,0x0D,0x00}; // ADC Normal mode
 char TestModeRM[3] = {0x00,0x0D,0x5F}; // ADC Test Mode Ramp
 char TestModeA5[3] = {0x00,0x0D,0x44}; // ADC Test Mode AAA555

<<<<<<< HEAD
=======
 //u8 DataUserValueMsb = 0xAA;
 //u8 DataUserValueLsb = 0x55;
>>>>>>> 2beaa5130f425292206b0f1e5bde86633226516b
 char TstUser1LSB[3] = {0x00,0x19,0x55}; // User defined pattern 1 LSB
 char TstUser1MSB[3] = {0x00,0x1A,0xAA}; // User defined pattern 1 MSB
 char TestModeUM[3]  = {0x00,0x0D,0x08}; // ADC Test Mode USER1
 char AdcDelay[5]    = {0x00};           // Calculated ADC delay table

<<<<<<< HEAD
 static uint8_t mode = 0;
 static uint8_t bits = 8;
 static uint32_t speed = 5000000;
static void pabort(const char *s)
{
	perror(s);
	abort();
}

int main ()
{

		char filename[20];
		int i, fd;
		int ret = 0;
		printf("Initialization of SPI-0 ADC..... ");
					for (i = 0; i < 5; i++){
						snprintf(filename, 19, "/dev/spidev32766.%d",i);
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


							if (write(fd, ADC_RESET, sizeof(ADC_RESET)) != sizeof(ADC_RESET)) {
									exit(3);
							}
							if (write(fd, ADC_LVDS, sizeof(ADC_LVDS)) != sizeof(ADC_LVDS)) {
							    	exit(3);
							}
							if (write(fd, ADC_VREF, sizeof(ADC_VREF)) != sizeof(ADC_VREF)) {
									exit(3);
							}
							if (write(fd, NormalMode, sizeof(NormalMode)) != sizeof(NormalMode)) {
									exit(3);
							}
							close(fd);
							usleep (100);
					};


		printf("Done!\n\r");
=======
 //static const char *device = "/dev/spidev32766.2";
 static uint8_t mode = 3;
 static uint8_t bits = 8;
 static uint32_t speed = 1000000;
 static uint16_t delay;


 static void pabort(const char *s)
 {
 	perror(s);
 	abort();
 }


int main ()
{
	int file, i, fd;
	int ret = 0;
	char filename[20];
	printf("Initialization of SPI-0 ADC..... ");
/*
		snprintf(filename, 19, "/dev/spidev32766.2");
			file = open(filename, O_RDWR);
			if (file < 0) {
					exit(1);
			}

			if (write(file, ADC_LVDS, sizeof(ADC_LVDS)) != sizeof(ADC_LVDS)) {
			    	exit(3);
			}

			if (write(file, ADC_RESET, sizeof(ADC_RESET)) != sizeof(ADC_RESET)) {
					exit(3);
			}

			if (write(file, ADC_VREF, sizeof(ADC_VREF)) != sizeof(ADC_VREF)) {
					exit(3);
			}

			if (write(file, NormalMode, sizeof(NormalMode)) != sizeof(NormalMode)) {
					exit(3);
			}
			close(file);


			*/
				for (i =0; i<5; i++){
					snprintf(filename, 19, "/dev/spidev32766.%d",i);

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

//						printf("spi mode: %d\n", mode);
//						printf("bits per word: %d\n", bits);
//						printf("max speed: %d Hz (%d KHz)\n", speed, speed/1000);


						file = open(filename, O_RDWR);
						if (file < 0) {
								exit("Can't open device!");
						}

						if (write(file, ADC_LVDS, sizeof(ADC_LVDS)) != sizeof(ADC_LVDS)) {
						    	exit(3);
						}

						if (write(file, ADC_RESET, sizeof(ADC_RESET)) != sizeof(ADC_RESET)) {
								exit(3);
						}

						if (write(file, ADC_VREF, sizeof(ADC_VREF)) != sizeof(ADC_VREF)) {
								exit(3);
						}

						if (write(file, NormalMode, sizeof(NormalMode)) != sizeof(NormalMode)) {
								exit(3);
						}
						close(file);
				};




	printf("Done!\n\r");

>>>>>>> 2beaa5130f425292206b0f1e5bde86633226516b

}
