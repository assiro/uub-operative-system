# Firmware distribution for UUB 

UUB Petalinux System with 

uub.bin is the file image of entire flash memory

- UBI sub-system implemented and works!

- Bitstream FPGA by D.Nitz (WP2) and WP1 block 

- Device tree with USB, I2C, SPI, UART (AXI Uartlite not tested)

- Applications implemented:
	scope
	led
	acquire
	adc
	uub_init
	ssd_test
	pmt_hv
	trigger control (D. Nitz) developing
	
Initialization of UUB's devices automatically at start up

UBI is working fine! To upgrade the system and bitstream is easy as like to copy a file
	
Web server: works!

USB: works!

SPI0, SPI1, I2C0, I2C1: work!

TCF Agent for SDK development and cross-compiling enabled

More info to: http://elettronica.le.infn.it/?page_id=898

login: root - passwd: root

For any questions: roberto.assiro@le.infn.it

