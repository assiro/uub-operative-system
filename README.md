# Firmware distribution for UUB 

UUB Petalinux global firmware integration:

uub.bin is the image file of entire flash memory

- UBI sub-system implemented and works!

- Bitstream FPGA by D.Nitz (WP2) and WP1 block 

- Device tree with USB, I2C, SPI, UART (AXI Uartlite not tested)

- Applications implemented:
-	scope (R. Assiro)
-	led
-	acquire
-	adc
-	uub_init (UUB intialization R. Assiro)
-	slowc (Karl-Heinz)
-	uub_init
-	ssd_test (D. Martello)
-	pmt_hv (D. Martello)
-	trigger control (D. Nitz) developing (G. Marsella)

All source code are available under SDK's workspace of uub-firmware
	
Initialization of UUB's devices automatically at startup

UBI is working fine! To upgrade the system and bitstream is easy like to copy a file
	
Web server: works!

USB: works!

SPI0, SPI1, I2C0, I2C1: work!

TCF Agent for SDK development and cross-compiling enabled

More info to: http://elettronica.le.infn.it/?page_id=898

login: root - passwd: root

For any questions: roberto.assiro@le.infn.it

