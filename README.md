# Operative system and firmware distribution for UUB

# System version 1.01.0 upgrade (November 2020) - UUB massive production
- New FPGA bitsream ver 14120420 with AXI bus splitting
- recopmpiled C program with new parameters
- SCU firmware V3.5 or higher
- LRZSZ pakage Zmodem implementation
- Upgrade of scripts code for the test bench

# System version 1.00.0 upgrade (March 2020) - UUB massive production

# System version 0.99.7 upgrade (feb 2020) - UUB layout V3
IMPORTANT! this version requires SCU firmware V3.3 or higher
- UPDATE THE SYSTEM BEFORE AND THEN SCU FIRMWARE! -

change log:
- new slowc V3.3 for new SCU firmware (V3.3). This firmware
- new watchdog control by ZINQ process (watchd)
- new APIs for SITAEL test system
- Upgrade of web panel
- Last bistream ver. 16151219

# System version 0.99.6 upgrade (dec 2019) - UUB layout V3

IMPORTANT! this version requires SCU firmware V3.1 or higher

change log:
- ADCs check after boot to avoid frozen traces
- Implemented new solution to upgrade  UUB by external server (Github)
- new APIs for SITAEL test system
- Upgrade of web panel
- Last bistream ver. 16091219

# System version 0.99.3 upgrade (oct 2019) - UUB layout V3
IMPORTANT! this version requires SCU firmware V3.1

change log:
- New version of slowc to manage the SCU (V3.1)
- UIO Symbolic links auto generator at boot
- Upgrade of applications for UUB test
- Upgrade of web panel

# System version 0.99.2 upgrade (sep 2019) - UUB layout V3
This version is not compatible with UUB V1 and V2

change log:
- Different FSBL for SPI-1 parameters setting
- Modification of device tree for flash memory mapping address
- Upgrade of applications for UUB test

# System version 0.99.1 upgrade (sep 2019) - UUB layout V3
This version is not compatible with UUB V1 and V2

change log:
- new FSBL for SPI-1 parameters setting
- bug fixed in the device tree (critic for last ver)
- new bitstream ver. 12080919
- applications for UUB-TEST
- led dac process ad5326 change

# System version 0.99.0 (july 2019) - UUB layout V3
This version is not compatible with UUB V1 and V2

change log:
- new I2C on FPGA for LED DAC
- Device tree in system.dtb file
- Jitter cleaner implementation
- Manage of Front-end power supply
- Manage of full ADCs power supply
- New RD scope in web page

# Flash memory binary file (ver 0.99.0)
entire content of MICRON flash memory for production
SHA256: ba3d9cdd7db29ad8df9d1966495e323947f44fea2be6f9c24ed1774bafb7b4e0

# System version 0.95.6 (april 2019) - UUB layout V1
change log  ver E.A. 0.95.6 :
- Amiga uart ttyUL2 in device tree
- New Uboot with external device tree implementation (system.dtb)
- Possibility to upgrade the system.dtb (device tree) by radio
- New I2C on FPGA on pin W12 and V12
- UIO interrupts
- Web server upgraded (scope)

# System version Enginiring Array 0.98 (November 2018) - UUB layout V2 (SITAEL)
This version is NOT compatible with UUB V1 layout (for UUB V1 use sys 0.95.5)

Change log ver E.A. 0.98 :
- implementation UIO interrupts 2 and 9 (device tree)
- Clock frequency generator control and  analyzer in web pannel
- Device Tree I2C 100Khz Frequency setting (test for I2C hangs)

Change log ver E.A. 0.97.8 :

- bugs fixed in pages of webserver 
- fixed important scope's issue ver. 1.5 (multiprocess bug without fpga trigger)

Change log ver E.A. 0.97.7 :

- New initialization after boot for new device Led DAC, Fan-out
- New UBOOT version with new important definitions (kernel image size)
- ADC power down pin manage
- Watchdog enabled and works
- New initialization for devices (ADC inverted for SITAEL modifications)
- Test tools implemented in web server page under UUB TEST

		Test DAC 5694 (LED)
		
		Test DAC 7551 (clock)
		
		Test GPS serial lines
		
		Test Radio reset

•	ADC power downd pin manage

•	DOUBLE BOOT IMPLEMENTED: to run previous version digit: RUN RECOVERY on uboot prompt


# System version 0.95.1 (March 2017) - UUB layout V1

UUB Petalinux system and firmware(fpga) integration:

uub.bin is the RAW file of entire flash memory. You need uub.bin just only for empty UUB's flash memory. 

# Change log ver. E.A. 0.95.1
•	upgrade web server interface

•	D.A.Q. start and stop automatically using local web server

•	Bash Scripts optimizations

•	QSPI reset for Zynq reboot

•	Radio reset control implemented

•	ADC registers setting and control improved

•	DAQ software is not implemented (petalinux-build)

•	upgrade FPGA firmware (bug fixed)
	
•	Upgrade scope and web pages

•	New U-boot and new environment variables with new settings

•	Speed serial system consol to 115200 baud  (u-boot and petalinux)

•	U.I.O. (Userspace I/O) to access connected PL BRAM via AXI bus (DMA)

•	DEVICE TREE changed with new FPGA definitions and U.I.O. implemented

•	New flash memory volume /flash  in mtd3 (80 Mb) for user

•	New recovery volume for safety of system (/recovery)

•	Attaching of partitions at boot (important for safety)

•	Alias IP address eth0:0 192.168.168.168 (helpful in the field)

•	bootargs for kernel changed (new in u-boot’s environment)

•	Watchdog (WTD) implemented in device tree (it needs new slow control firmware)

Embedded Webserver:

•	New web server index page

•	New oscilloscope version and new functions (interactive control)

•	New web pages for slow control monitoring

#Change log ver. Beta Test 0.2 (firts version on E.A. 10/2016)
•	 Implementation of “patching” program for UUB - updating firmware and upgrading software

•	Custom commands definition for settings and functions

•	Uart-lite (gps uart) device tree problem resolved

•	Implementation programs using D.Nitz’s trigger (G.Marsella)

•	Bugs fixed in some scripts

•	Silicon PM control program implemented

----------------------------------------------------------------------------------

# UUB user info

login: root - passwd: root  (change password by patch if needed)

Default MAC address: 00:0A:35:00:1E:53 - DHCP active

serial console speed: 115200 baud

More info to: http://elettronica.le.infn.it/?page_id=898

For any questions: roberto.assiro@le.infn.it



