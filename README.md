# Operative system and firmware distribution for UUB 

UUB Petalinux system and firmware(fpga) integration:

uub.bin is the image file of entire flash memory (please see uub manual to use uub.bin)

Current version of system Beta Test 0.2  - september 2016

#Change log ver. Beta Test 0.2
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

- Applications implemented:

 Name ----- contents ---- Author
- scope - Real time monitor of input signals 10 channels (R. Assiro)
- led continus led shot (R.Assiro)
- led_dac Intensity of lef shot (R.Assiro)
- acquire UUB real time data acquisition (G.Marsella R.Sato)
- uub_init UUB devices intialization (R. Assiro)
- slowc comunication program and control from zynq and MPS450 (K.H.Beker)
- uub_init initialization of UUB at boot (R.Assiro)
- ssd_test Test, acquisition and settings for SSD detector (D. Martello)
- pmt_hv High voltage control (D. Martello)
- trigger setup and control of trigger (D. Nitz) developing (G. Marsella)

All source code are available under SDK's workspace of uub-firmware (platform for developing software)
	
Initialization of UUB's devices automatically at boot

UBI is working fine! To upgrade the system and bitstream is easy like to copy a file
	
Web server: works!

USB: works!

SPI0, SPI1, I2C0, I2C1: work!
Uart-lite is working

TCF Agent for SDK development and cross-compiling enabled

More info to: http://elettronica.le.infn.it/?page_id=898

login: root - passwd: root

MAC address: 00:0A:35:00:1E:53 - DHCP active

serial console speed: 9600 baud

For any questions: roberto.assiro@le.infn.it


