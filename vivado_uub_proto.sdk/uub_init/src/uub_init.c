/*
 * uub_init.c
 *
 *  Created on: 18/mar/2016
 *      Author: Roberto Assiro
 */

// UUB initialization file

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

#define nb_initData_SI5347    1560 // Nb init data for SI5347 component

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

 static uint8_t mode = 0;
 static uint8_t bits = 8;
 static uint32_t speed = 5000000;

// settings for clock generator
char buf[]={0x00,0x20,
			0x01,0x01,0xB4,0x01,0x02,0x50,0x40,0x00,
            0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,0x6D,0x02,0x00,0x00,
            0x99,0x03,0x32,0x68,0x00,0x40,0x02,0x08};

// settings for jitter cleaner
char set[]={0xFE,0x01,0x00,0x1E,0x02};
char couple1[2];
char couple2[2];
char jitter[]=
  { 0x0B,0x24,0xD8,0x0B,0x25,0x00,                                              // bank 0xB
    0x00,0x0B,0x6C,0x00,0x16,0x0F,0x00,0x17,0x3C,0x00,0x18,0xFF,0x00,0x19,0xFF, // bank 0
    0x00,0x1A,0xFF,0x00,0x20,0x00,0x00,0x2B,0x0A,0x00,0x2C,0x01,0x00,0x2D,0x01,
    0x00,0x2E,0xE4,0x00,0x2F,0x00,0x00,0x30,0x00,0x00,0x31,0x00,0x00,0x32,0x00,
    0x00,0x33,0x00,0x00,0x34,0x00,0x00,0x35,0x00,0x00,0x36,0xE4,0x00,0x37,0x00,
    0x00,0x38,0x00,0x00,0x39,0x00,0x00,0x3A,0x00,0x00,0x3B,0x00,0x00,0x3C,0x00,
    0x00,0x3D,0x00,0x00,0x3F,0x11,0x00,0x40,0x04,0x00,0x41,0x0D,0x00,0x42,0x00,
    0x00,0x43,0x00,0x00,0x44,0x00,0x00,0x45,0x0C,0x00,0x46,0x32,0x00,0x47,0x00,
    0x00,0x48,0x00,0x00,0x49,0x00,0x00,0x4A,0x32,0x00,0x4B,0x00,0x00,0x4C,0x00,
    0x00,0x4D,0x00,0x00,0x4E,0x05,0x00,0x4F,0x00,0x00,0x51,0x03,0x00,0x52,0x00,
    0x00,0x53,0x00,0x00,0x54,0x00,0x00,0x55,0x03,0x00,0x56,0x00,0x00,0x57,0x00,
    0x00,0x58,0x00,0x00,0x59,0x03,0x00,0x5A,0x00,0x00,0x5B,0x00,0x00,0x5C,0x40,
    0x00,0x5D,0x01,0x00,0x5E,0x00,0x00,0x5F,0x00,0x00,0x60,0x00,0x00,0x61,0x00,
    0x00,0x62,0x00,0x00,0x63,0x00,0x00,0x64,0x00,0x00,0x65,0x00,0x00,0x66,0x00,
    0x00,0x67,0x00,0x00,0x68,0x00,0x00,0x69,0x00,0x00,0x92,0x00,0x00,0x93,0x00,
    0x00,0x94,0x00,0x00,0x95,0x00,0x00,0x96,0x00,0x00,0x97,0x00,0x00,0x98,0x00,
    0x00,0x99,0x00,0x00,0x9A,0x01,0x00,0x9B,0x03,0x00,0x9C,0x00,0x00,0x9D,0x00,
    0x00,0x9E,0x02,0x00,0x9F,0x00,0x00,0xA0,0x00,0x00,0xA1,0x00,0x00,0xA2,0x01,
    0x00,0xA3,0xB8,0x00,0xA4,0x32,0x00,0xA5,0x01,0x00,0xA6,0x00,0x00,0xA7,0x00,
    0x00,0xA8,0x00,0x00,0xA9,0x00,0x00,0xAA,0x00,0x00,0xAB,0x00,0x00,0xAC,0x00,
    0x00,0xAD,0x00,0x00,0xAE,0x00,0x00,0xAF,0x00,0x00,0xB0,0x00,0x00,0xB1,0x00,
    0x00,0xB2,0x00,0x00,0xB3,0x00,0x00,0xB4,0x00,0x00,0xB5,0x00,0x00,0xB6,0x00,
    0x01,0x02,0x01,0x01,0x08,0x02,0x01,0x09,0x09,0x01,0x0A,0x3D,0x01,0x0B,0x00, // bank 1
    0x01,0x0C,0x01,0x01,0x12,0x02,0x01,0x13,0x09,0x01,0x14,0x3D,0x01,0x15,0x00,
    0x01,0x16,0x01,0x01,0x17,0x02,0x01,0x18,0x09,0x01,0x19,0x3D,0x01,0x1A,0x00,
    0x01,0x1B,0x01,0x01,0x1C,0x02,0x01,0x1D,0x09,0x01,0x1E,0x3D,0x01,0x1F,0x00,
    0x01,0x20,0x01,0x01,0x26,0x02,0x01,0x27,0x09,0x01,0x28,0x3D,0x01,0x29,0x00,
    0x01,0x2A,0x01,0x01,0x2B,0x02,0x01,0x2C,0x09,0x01,0x2D,0x3D,0x01,0x2E,0x00,
    0x01,0x2F,0x01,0x01,0x30,0x01,0x01,0x31,0x09,0x01,0x32,0x3B,0x01,0x33,0x00,
    0x01,0x34,0x00,0x01,0x3A,0x01,0x01,0x3B,0x09,0x01,0x3C,0x3B,0x01,0x3D,0x00,
    0x01,0x3E,0x00,0x01,0x3F,0x00,0x01,0x40,0x00,0x01,0x41,0x40,0x01,0x42,0xFF,
    0x02,0x02,0x00,0x02,0x03,0x00,0x02,0x04,0x00,0x02,0x05,0x00,0x02,0x06,0x00, // bank 2
    0x02,0x08,0x3C,0x02,0x09,0x00,0x02,0x0A,0x00,0x02,0x0B,0x00,0x02,0x0C,0x00,
    0x02,0x0D,0x00,0x02,0x0E,0x01,0x02,0x0F,0x00,0x02,0x10,0x00,0x02,0x11,0x00,
    0x02,0x12,0x00,0x02,0x13,0x00,0x02,0x14,0x00,0x02,0x15,0x00,0x02,0x16,0x00,
    0x02,0x17,0x00,0x02,0x18,0x00,0x02,0x19,0x00,0x02,0x1A,0x00,0x02,0x1B,0x00,
    0x02,0x1C,0x00,0x02,0x1D,0x00,0x02,0x1E,0x00,0x02,0x1F,0x00,0x02,0x20,0x00,
    0x02,0x21,0x00,0x02,0x22,0x00,0x02,0x23,0x00,0x02,0x24,0x00,0x02,0x25,0x00,
    0x02,0x26,0x00,0x02,0x27,0x00,0x02,0x28,0x00,0x02,0x29,0x00,0x02,0x2A,0x00,
    0x02,0x2B,0x00,0x02,0x2C,0x00,0x02,0x2D,0x00,0x02,0x2E,0x00,0x02,0x2F,0x00,
    0x02,0x31,0x01,0x02,0x32,0x01,0x02,0x33,0x01,0x02,0x34,0x01,0x02,0x35,0x00,
    0x02,0x36,0x00,0x02,0x37,0x00,0x02,0x38,0x00,0x02,0x39,0x94,0x02,0x3A,0x00,
    0x02,0x3B,0x00,0x02,0x3C,0x00,0x02,0x3D,0x00,0x02,0x3E,0x80,0x02,0x40,0x00,
    0x02,0x41,0x00,0x02,0x42,0x00,0x02,0x43,0x00,0x02,0x44,0x00,0x02,0x45,0x00,
    0x02,0x46,0x00,0x02,0x4A,0x02,0x02,0x4B,0x00,0x02,0x4C,0x00,0x02,0x50,0x02,
    0x02,0x51,0x00,0x02,0x52,0x00,0x02,0x53,0x02,0x02,0x54,0x00,0x02,0x55,0x00,
    0x02,0x56,0x02,0x02,0x57,0x00,0x02,0x58,0x00,0x02,0x5C,0x02,0x02,0x5D,0x00,
    0x02,0x5E,0x00,0x02,0x5F,0x02,0x02,0x60,0x00,0x02,0x61,0x00,0x02,0x62,0x00,
    0x02,0x63,0x00,0x02,0x64,0x00,0x02,0x68,0x00,0x02,0x69,0x00,0x02,0x6A,0x00,
    0x02,0x6B,0x30,0x02,0x6C,0x00,0x02,0x6D,0x00,0x02,0x6E,0x00,0x02,0x6F,0x00,
    0x02,0x70,0x00,0x02,0x71,0x00,0x02,0x72,0x00,
    0x03,0x02,0x00,0x03,0x03,0x00,0x03,0x04,0x00,0x03,0x05,0x80,0x03,0x06,0x12, // bank 3
    0x03,0x07,0x00,0x03,0x08,0x00,0x03,0x09,0x00,0x03,0x0A,0x00,0x03,0x0B,0xF0,
    0x03,0x0D,0x00,0x03,0x0E,0x00,0x03,0x0F,0x00,0x03,0x10,0x80,0x03,0x11,0x00,
    0x03,0x12,0x00,0x03,0x13,0x00,0x03,0x14,0x00,0x03,0x15,0x00,0x03,0x16,0x80,
    0x03,0x18,0x00,0x03,0x19,0x00,0x03,0x1A,0x00,0x03,0x1B,0x80,0x03,0x1C,0x00,
    0x03,0x1D,0x00,0x03,0x1E,0x00,0x03,0x1F,0x00,0x03,0x20,0x00,0x03,0x21,0x80,
    0x03,0x23,0x00,0x03,0x24,0x00,0x03,0x25,0x00,0x03,0x26,0x80,0x03,0x27,0x00,
    0x03,0x28,0x00,0x03,0x29,0x00,0x03,0x2A,0x00,0x03,0x2B,0x00,0x03,0x2C,0x80,
    0x03,0x39,0x00,0x03,0x3B,0x00,0x03,0x3C,0x00,0x03,0x3D,0x00,0x03,0x3E,0x00,
    0x03,0x3F,0x00,0x03,0x40,0x00,0x03,0x41,0x00,0x03,0x42,0x00,0x03,0x43,0x00,
    0x03,0x44,0x00,0x03,0x45,0x00,0x03,0x46,0x00,0x03,0x47,0x00,0x03,0x48,0x00,
    0x03,0x49,0x00,0x03,0x4A,0x00,0x03,0x4B,0x00,0x03,0x4C,0x00,0x03,0x4D,0x00,
    0x03,0x4E,0x00,0x03,0x4F,0x00,0x03,0x50,0x00,0x03,0x51,0x00,0x03,0x52,0x00,
    0x04,0x02,0x01,0x04,0x08,0x10,0x04,0x09,0x22,0x04,0x0A,0x09,0x04,0x0B,0x08, // bank 4
    0x04,0x0C,0x1F,0x04,0x0D,0x3F,0x04,0x0E,0x10,0x04,0x0F,0x24,0x04,0x10,0x09,
    0x04,0x11,0x08,0x04,0x12,0x1F,0x04,0x13,0x3F,0x04,0x15,0x00,0x04,0x16,0x00,
    0x04,0x17,0x00,0x04,0x18,0x00,0x04,0x19,0xB4,0x04,0x1A,0x00,0x04,0x1B,0x00,
    0x04,0x1C,0x00,0x04,0x1D,0x00,0x04,0x1E,0x00,0x04,0x1F,0x80,0x04,0x21,0x31,
    0x04,0x22,0x01,0x04,0x23,0xE3,0x04,0x24,0xA5,0x04,0x25,0x9B,0x04,0x26,0x04,
    0x04,0x27,0x00,0x04,0x28,0x00,0x04,0x29,0x00,0x04,0x2A,0x00,0x04,0x2B,0x01,
    0x04,0x2C,0x0F,0x04,0x2D,0x03,0x04,0x2E,0x15,0x04,0x2F,0x13,0x04,0x31,0x00,
    0x04,0x32,0x42,0x04,0x33,0x03,0x04,0x34,0x00,0x04,0x36,0x0C,0x04,0x37,0x00,
    0x04,0x38,0x01,0x04,0x39,0x00,
    0x05,0x02,0x01,0x05,0x08,0x00,0x05,0x09,0x00,0x05,0x0A,0x00,0x05,0x0B,0x00, // bank 5
    0x05,0x0C,0x00,0x05,0x0D,0x00,0x05,0x0E,0x00,0x05,0x0F,0x00,0x05,0x10,0x00,
    0x05,0x11,0x00,0x05,0x12,0x00,0x05,0x13,0x00,0x05,0x15,0x00,0x05,0x16,0x00,
    0x05,0x17,0x00,0x05,0x18,0x80,0x05,0x19,0x00,0x05,0x1A,0x00,0x05,0x1B,0x00,
    0x05,0x1C,0x00,0x05,0x1D,0x00,0x05,0x1E,0x00,0x05,0x1F,0x80,0x05,0x21,0x21,
    0x05,0x22,0x01,0x05,0x23,0x00,0x05,0x24,0x00,0x05,0x25,0x00,0x05,0x26,0x00,
    0x05,0x27,0x00,0x05,0x28,0x00,0x05,0x29,0x00,0x05,0x2A,0x01,0x05,0x2B,0x01,
    0x05,0x2C,0x0F,0x05,0x2D,0x03,0x05,0x2E,0x00,0x05,0x2F,0x00,0x05,0x31,0x00,
    0x05,0x32,0x00,0x05,0x33,0x04,0x05,0x34,0x00,0x05,0x36,0x0E,0x05,0x37,0x00,
    0x05,0x38,0x00,0x05,0x39,0x00,
    0x06,0x02,0x01,0x06,0x08,0x00,0x06,0x09,0x00,0x06,0x0A,0x00,0x06,0x0B,0x00, // bank 6
    0x06,0x0C,0x00,0x06,0x0D,0x00,0x06,0x0E,0x00,0x06,0x0F,0x00,0x06,0x10,0x00,
    0x06,0x11,0x00,0x06,0x12,0x00,0x06,0x13,0x00,0x06,0x15,0x00,0x06,0x16,0x00,
    0x06,0x17,0x00,0x06,0x18,0x80,0x06,0x19,0x00,0x06,0x1A,0x00,0x06,0x1B,0x00,
    0x06,0x1C,0x00,0x06,0x1D,0x00,0x06,0x1E,0x00,0x06,0x1F,0x80,0x06,0x21,0x21,
    0x06,0x22,0x01,0x06,0x23,0x00,0x06,0x24,0x00,0x06,0x25,0x00,0x06,0x26,0x00,
    0x06,0x27,0x00,0x06,0x28,0x00,0x06,0x29,0x00,0x06,0x2A,0x00,0x06,0x2B,0x01,
    0x06,0x2C,0x0F,0x06,0x2D,0x03,0x06,0x2E,0x00,0x06,0x2F,0x00,0x06,0x31,0x00,
    0x06,0x32,0x00,0x06,0x33,0x04,0x06,0x34,0x00,0x06,0x36,0x0E,0x06,0x37,0x00,
    0x06,0x38,0x00,0x06,0x39,0x00,
    0x07,0x02,0x01,0x07,0x09,0x00,0x07,0x0A,0x00,0x07,0x0B,0x00,0x07,0x0C,0x00, // bank 7
    0x07,0x0D,0x00,0x07,0x0E,0x00,0x07,0x0F,0x00,0x07,0x10,0x00,0x07,0x11,0x00,
    0x07,0x12,0x00,0x07,0x13,0x00,0x07,0x14,0x00,0x07,0x16,0x00,0x07,0x17,0x00,
    0x07,0x18,0x00,0x07,0x19,0x80,0x07,0x1A,0x00,0x07,0x1B,0x00,0x07,0x1C,0x00,
    0x07,0x1D,0x00,0x07,0x1E,0x00,0x07,0x1F,0x00,0x07,0x20,0x80,0x07,0x22,0x21,
    0x07,0x23,0x01,0x07,0x24,0x00,0x07,0x25,0x00,0x07,0x26,0x00,0x07,0x27,0x00,
    0x07,0x28,0x00,0x07,0x29,0x00,0x07,0x2A,0x00,0x07,0x2B,0x00,0x07,0x2C,0x01,
    0x07,0x2D,0x0F,0x07,0x2E,0x03,0x07,0x2F,0x00,0x07,0x30,0x00,0x07,0x32,0x00,
    0x07,0x33,0x00,0x07,0x34,0x04,0x07,0x35,0x00,0x07,0x37,0x0E,0x07,0x38,0x00,
    0x07,0x39,0x00,0x07,0x3A,0x00,
    0x09,0x0E,0x02,0x09,0x43,0x00,0x09,0x49,0x01,0x09,0x4A,0x01,                // bank 9
    0x0A,0x03,0x01,0x0A,0x04,0x00,0x0A,0x05,0x01,                               // bank A
    0x0B,0x44,0xEF,0x0B,0x45,0x0E,0x0B,0x46,0x00,0x0B,0x47,0x00,0x0B,0x48,0x0E,
    0x0B,0x4A,0x0E,                                                             // bank B
    0x04,0x14,0x01,                                                             // bank 4
    0x00,0x1C,0x01,                                                             // bank 0
    0x0B,0x24,0xDB,0x0B,0x25,0x02};                                             // bank B

static void pabort(const char *s)
{
	perror(s);
	abort();
}

int main ()
{
// UUB clock generatore initialization on I2C-1
	int file, k;
	int adapter_nr = 1; /* probably dynamically determined */
	char filename[20];
	printf("Initialization of I2C clock generator..... ");
	snprintf(filename, 19, "/dev/i2c-%d", adapter_nr);
	file = open(filename, O_RDWR);
	if (file < 0) {
			exit(1);
	}
	int addr = 0x65; /* The I2C address clock generator CDCE913*/
	if (ioctl(file, I2C_SLAVE, addr) < 0) {
			exit(2);
	}
    if (write(file, buf, sizeof(buf)) != sizeof(buf)) {
    	 	exit(3);
    }
	printf("Done!\n\r");
///////////////////////////////////////////////////////////////////////////////
// UUB jitter cleaner initialization on I2C-1
		addr = 0x6C; /* The I2C address Jitter cleaner*/
		printf("Initialization of I2C Jitter Cleaner..... ");
//		snprintf(filename, 19, "/dev/i2c-%d", adapter_nr);
//		file = open(filename, O_RDWR);
//		if (file < 0) {
//				exit(1);
//		}
		if (ioctl(file, I2C_SLAVE, addr) < 0) {
				exit(2);
		}
		write(file, set, sizeof(set)); // firts bytes for setting

usleep (500); //RITARDO DA SOSTITUIRE CON LETTURA DEVICE READY

	// register initialization for accessing to the Page 0x0 to make hard RESET
		for ( k = 0; k < nb_initData_SI5347; k=k+3)
		    {
			couple1[0]=0x01;
			couple1[1]=jitter[k];
			couple2[0]=jitter[k+1];
			couple2[1]=jitter[k+2];
			write(file, couple1,sizeof(couple1));
			write(file, couple2,sizeof(couple2));
		    }
		printf("Done!\n\r");

		close(file);

//////////////////////// SPI CONFIGURATION ///////////////////////////////////////

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

}
