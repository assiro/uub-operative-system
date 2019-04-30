# Operative system and firmware distribution for UUB

# System version 0.95.5 (febbruary 2019) - UUB layout V1
change log  ver E.A. 0.95.5 :
- Amiga uart ttyUL2
- New Uboot with external device tree implementation
- Possibility to upgrade the system.dtb (device tree) by radio
- New I2C on FPGA on pin W12 and V12
- UIO interrupts
- Web server upgraded (scope)

# System version Enginiring Array 0.98 (November 2018) - UUB layout V2 (SITAEL)
This version is NOT compatible with UUB V1 layout (for UUB V1 use sys 0.95.5)

Change log ver E.A. 0.98 :
- implementation UIO interrupts 2 and 9 (device tree)
- Clock frequency generator analyzer web pannel
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



