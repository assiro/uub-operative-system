# Operative system and firmware distribution for UUB (ver.0.95.1 is working in the field)

UUB Petalinux system and firmware(fpga) integration:

uub.bin is the RAW file of entire flash memory. You need uub.bin just only for empty UUB's flash memory. 

To upgrade the UUB to new version you need: image.ub and fpga.bit by tftp server or USB memory stick 

Command is : uub-update ip number  (ip number is your TFTP Server) example : uub-update 192.168.1.1

#Change log ver. E.A. 0.95.1  (March 2017)
•	upgrade webserver interface

•	D.A.Q. Start and stop by webserver automatically

•	Scripts bugs fixed

•	QSPI reset for Zynq reboot

•	Radio reset control implemented

•	ADC registers setting and control improved

•	DAQ software is not implemented (petalinux-build)


#Change log ver. E.A. 0.94  (February 2017)
•	upgrade FPGA firmware (bug fixed)
	
	Upgrade scope and web pages

	New U-boot and new environment variables with new settings

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

#Change log ver. Beta Test 0.2 (firts version on E.A. september 2016)
•	 Implementation of “patching” program for UUB - updating firmware and upgrading software

•	Custom commands definition for settings and functions

•	Uart-lite (gps uart) device tree problem resolved

•	Implementation programs using D.Nitz’s trigger (G.Marsella)

•	Bugs fixed in some scripts

•	Silicon PM control program implemented

----------------------------------------------------------------------------------

- UBI sub-system implemented and works!
- Bitstream FPGA by D.Nitz (fpga.bit) 

- Device tree with USB, I2C, SPI, UART, AXI Uartlite

All source code are available under SDK's workspace of uub-firmware folder WP1
	
Initialization of UUB's devices automatically at boot

UBI is working fine! To upgrade the system and bitstream is easy like to copy a file
	
Web server: works!

USB: works!

SPI0, SPI1, I2C0, I2C1: work!
Uart-lite is working

TCF Agent for SDK development and cross-compiling enabled

More info to: http://elettronica.le.infn.it/?page_id=898

login: root - passwd: root  (change password by patch if needed)

MAC address: 00:0A:35:00:1E:53 - DHCP active

serial console speed: 9600 baud

For any questions: roberto.assiro@le.infn.it



