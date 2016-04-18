 /*
  *
  * Xilinx, Inc.
  * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A COURTESY
  * TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE
  * IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS MAKING NO
  * REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF 
  * INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY 
  * REQUIRE FOR YOUR IMPLEMENTATION XILINX EXPRESSLY DISCLAIMS ANY WARRANTY
  *  WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING 
  * BUT NOT LIMITED TO ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION
  * IS FREE FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
  * AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
  // 
  // This file is a generated sample test application.
  // 
  // This application is intended to test and/or illustrate some functionality
  // of your system. The contents of this file may vary depending on the IP in
  // your system and may use existing IP driver functions. These drivers will 
  // be generated in your SDK application project when you run the "Generate 
  // Libraries" menu item. 
  
 #include <stdio.h>
 #include "xparameters.h"
 #include "xil_cache.h"
 #include "xscugic.h"
 #include "xil_exception.h"
 #include "scugic_header.h"
 #include "uartlite_header.h"
 #include "xdevcfg.h"
 #include "devcfg_header.h"
 #include "xdmaps.h"
 #include "dmaps_header.h"
 #include "xemacps.h"
 #include "xemacps_example.h"
 #include "emacps_header.h"
 #include "xiicps.h"
 #include "iicps_header.h"
 #include "xqspips.h"
 #include "qspips_header.h"
 #include "xscutimer.h"
 #include "scutimer_header.h"
 #include "xscuwdt.h"
 #include "scuwdt_header.h"
 #include "xspips.h"
 #include "spips_header.h"
 #include "xuartps.h"
 #include "uartps_header.h"
 #include "xuartlite.h"
 #include "new_uub.h"
 
 #define true  1
 #define false 0
 extern XUartLite UartLite;      /* Instance of the UartLite device */
 
 int main() 
 {
    static XScuGic intc;
    static XEmacPs ps7_ethernet_0;
    static XScuTimer ps7_scutimer_0;
    static XScuWdt ps7_scuwdt_0;
    static XUartPs ps7_uart_0;
    Xil_ICacheEnable();
    Xil_DCacheEnable();
    int Status,i;
    

    print("\n\r\n\r ***************************************************\n\r");
    print(" ***      Start of the UUB proto Card test       ***\n\r");
    print(" ***                LPSC Grenoble                ***\n\r");
    print(" ***************************************************\n\r");
    
    {
       int data_display;
       unsigned int *state_register;
       state_register = UUB_STATE_REGISTER; // state register in test_uub module     
         
       print("\r\n Reading the state of the onboard switches : ");
       data_display = *state_register;
       printf(" %2x \n\r",data_display  & 0xff);
       if ( (data_display & 0xff) != 0x0 ) 
       { 
          print("  PLEASE set to ON all the switch\n\r");
        }
       // test if all switch are ON, easy for the next test
       while( (data_display & 0xff) != 0x0 ) {data_display = *state_register;}
    } 
    
//    TstRamBasis();
    
    {
       print("\r\n Running ScuGicSelfTest for ps7_scugic_0 . : ");
       Status = ScuGicSelfTestExample(XPAR_PS7_SCUGIC_0_DEVICE_ID);
       SendPassFail(Status);
    } 
    
    {
       Status = ScuGicInterruptSetup(&intc, XPAR_PS7_SCUGIC_0_DEVICE_ID);
       print("   ScuGic Interrupt Setup ................ : ");
       SendPassFail(Status);
    }
 
    {
       print("\r\n Test of the GPS UART link ............... : ");
       Status = UartLiteSelfTestExample(XPAR_AXI_UARTLITE_0_DEVICE_ID);
       SendPassFail(Status);
    }
    
    {
       print("\r\n Running DcfgSelfTest for ps7_dev_cfg_0 ...: ");
       Status = DcfgSelfTestExample(XPAR_PS7_DEV_CFG_0_DEVICE_ID);
       SendPassFail(Status);
    }
    
    {
       print("\r\n Running XDmaPs_W_Intr() for ps7_dma_s ... : ");     
       Status = XDmaPs_Example_W_Intr(&intc,XPAR_PS7_DMA_S_DEVICE_ID);      
       SendPassFail(Status);
    }
    
    {
       print("\r\n Running Int & DMA Test for ps7_ethernet_0 : ");
       Status = EmacPsDmaIntrExample(&intc, &ps7_ethernet_0, \
                                  XPAR_PS7_ETHERNET_0_DEVICE_ID, \
                                  XPAR_PS7_ETHERNET_0_INTR);
       SendPassFail(Status);
    }
    
    {
       print("\r\n Running IicPsSelfTest for ps7_i2c_0 ..... : ");
       Status = IicPsSelfTestExample(XPAR_PS7_I2C_0_DEVICE_ID);
       SendPassFail(Status);
    }
    
    {
       print("\r\n Running IicPsSelfTest for ps7_i2c_1 ..... : ");
       Status = IicPsSelfTestExample(XPAR_PS7_I2C_1_DEVICE_ID);
       SendPassFail(Status);
    }
    
    {
       print("\r\n Running QspiSelfTest for ps7_qspi_0 ..... : ");
       Status = QspiPsSelfTestExample(XPAR_PS7_QSPI_0_DEVICE_ID);     
       SendPassFail(Status);
    }
    
    {
       print("\r\n Running ScuTimerPolled for ps7_scutimer0  : ");      
       Status = ScuTimerPolledExample(XPAR_PS7_SCUTIMER_0_DEVICE_ID);      
       SendPassFail(Status);
    }

    {
       print("\r\n Running IT Test for ps7_scutimer_0 ...... : ");     
       Status = ScuTimerIntrExample(&intc, &ps7_scutimer_0, \
                                  XPAR_PS7_SCUTIMER_0_DEVICE_ID, \
                                  XPAR_PS7_SCUTIMER_0_INTR);    
       SendPassFail(Status);
    }
    
    {
       print("\r\n Running IT Test for ps7_scuwdt_0 ........ : ");      
       Status = ScuWdtIntrExample(&intc, &ps7_scuwdt_0,XPAR_PS7_SCUWDT_0_DEVICE_ID, \
                                  XPAR_PS7_SCUWDT_0_INTR);
       SendPassFail(Status);
    }
    
    {
       print("\r\n Running SpiPsSelfTest for ps7_spi_0 ..... : ");
       Status = SpiPsSelfTestExample(XPAR_PS7_SPI_0_DEVICE_ID);
       SendPassFail(Status);
    }
    
    {
       print("\r\n Running SpiPsSelfTest for ps7_spi_1 ..... : ");      
       Status = SpiPsSelfTestExample(XPAR_PS7_SPI_1_DEVICE_ID);      
       SendPassFail(Status);
    }
    
    {
       print("\r\n Running UartPsPolled for ps7_uart_0 ..... : ");
       Status = UartPsPolledExample(XPAR_PS7_UART_0_DEVICE_ID);
       SendPassFail(Status);
 
       print(" Running Interrupt Test for ps7_uart_0 ... : ");
       
       Status = UartPsIntrExample(&intc, &ps7_uart_0, XPAR_PS7_UART_0_DEVICE_ID,\
                                   XPAR_PS7_UART_0_INTR);
       SendPassFail(Status);
    }
      
  // Initialisation : 
  //        - du circuit clock generateur CDEL913   
  //        - des circuits ADC AD9628
  //        - du DAC AD7551 
  //        - du quad DAC AD5316 LED CONTROLER
    {
      int tst_enable ;
      
 
      // initialise le circuit clock generator CDEL913
      print("\r\n Initialization of I2C clock generator ... : ");
      XIicPs_ResetHw(XPAR_XIICPS_1_BASEADDR);
      Status = IicPsInitClockGenerator(XPAR_PS7_I2C_1_DEVICE_ID);
      SendPassFail(Status);
  
      // initialise le cleaner Jitter
      print(" Initialization of Jitter Cleaner ........ : ");
      Status = IicPsInitJitterCleaner(XPAR_PS7_I2C_1_DEVICE_ID);
      SendPassFail(Status);
      
      // initialise les circuits ADC9628
       print(" Initialization of ADC 9628 .............. : ");
       Status = SpiPs_Init_SPI(XPAR_PS7_SPI_0_DEVICE_ID, 0);
       SendPassFail(Status);
       
      // Initialize the DAC chip DAC7551
       tst_enable = false;
       print(" Initialization of DAC 7551 .............. : ");
       Status = SpiPs_Init_SPI_DAC(XPAR_PS7_SPI_1_DEVICE_ID, tst_enable);
       SendPassFail(Status);
       tst_enable = false;
 
      // Initialize the Quad DAC chip AD5316
       
       print(" Initialization of DAC AD5316 ............ : ");
       XIicPs_ResetHw(XPAR_XIICPS_0_BASEADDR);
       Status = IicPsInitI2C0(XPAR_PS7_I2C_0_DEVICE_ID);
       SendPassFail(Status);
    }
    
    //* Test will not be run for ps7_uart_1 because it was the STDOUT device

    //*********************************************************************
    // Access test to GPS sub systems :
    //   - Send data to the GPS UART and test if the UART receive them 
    //     throught a feed back
    //*********************************************************************
    
    u8 RadioSdDat[4] = {0x41,0x42,0x43,0x44};
    u8 RadioRvDat[4] = {0x00,0x00,0x00,0x00};
    int data_display;
    unsigned int *state_register;
       
    XUartLite_ResetFifos(&UartLite);
    XUartLite_Send(&UartLite,RadioSdDat,4);
    print(" UART GPS loop test ...................... : ");
    XUartLite_Recv(&UartLite,RadioRvDat,4);
    if ((RadioSdDat[0] == RadioRvDat[0]) && (RadioSdDat[1] == RadioRvDat[1]) && 
         (RadioSdDat[2] == RadioRvDat[2]) && (RadioSdDat[3] == RadioRvDat[3]) )  
    { Status = XST_SUCCESS;}  
    else
    { 
        Status = XST_FAILURE;
        printf("%x %x %x %x %x %x %x %x    ",RadioSdDat[0],RadioSdDat[1],
                                             RadioSdDat[2],RadioSdDat[3],
                                             RadioRvDat[0],RadioRvDat[1],
                                             RadioRvDat[2],RadioRvDat[3]);
    }
    
    SendPassFail(Status);  
   
    //*******************************************************
    // Reading the value of the PPS signal input
    //*******************************************************
     
    state_register = UUB_STATE_REGISTER;
    print(" Reading the PPS signal state ............ : ");
    data_display = *state_register;
    if ( (data_display & 0x2000) == 0x0) { print("Low level\n\r");}
    else                                 { print("High level\n\r");}
    
    //******************************************************
    //        Test of the Trigger signal ( IN & OUT )     
    //******************************************************
    
    unsigned int *test_trigger;
    
    test_trigger = UUB_TEST_TRIG_REG;
    print(" Test of the trigger signal ( IN & OUT ) . : ");
    
    Status = XST_SUCCESS;
    for ( i = 0x0; i <0x2; i++)
    { 
       *test_trigger = i ;
       data_display = *test_trigger;
       if ((data_display & 0x2)>>1 != (data_display & 0x01))
       {
          Status = XST_FAILURE;
          printf("%x %x %x %x    ",i,data_display,data_display & 0x2,data_display & 0x01);
       }
    }
    SendPassFail(Status);
       
    print("\n\r ***  THE END ***\n\r\n");
//    *test_trigger = 0x0;            // put the Trigger out signal in lower power
    
    print(" Use Switches for additionnal test ( only one at a time )\n\r");
    print("    switch 0 : Read the data inside the Jitter Cleaner component\n\r");
    print("    switch 1 : Read ADCs data randomly \n\r");
    print("    switch 2 : WRite a ramp on the DAC used for adjust the Clock generator\n\r");
    print("    switch 3 : Write a ramp of the LED controlor DAC\n\r");
  
    
    // infinite loop
    while(1)
    {
       data_display = *state_register;
       switch(data_display & 0xff)
       {
          case 0x1 : ReadJitterCleanerValue();
                     break;
          case 0x2 : SendADCData();
                     break;
          case 0x4 : TstDac7551();
                     break;
          case 0x8 : TstDacAD5316();
          default  : break;
       }
    }
    
    Xil_DCacheDisable();
    Xil_ICacheDisable();
    return 0;
 }
 
 //***********************************************************************
 //     Send PASSED or FAILLED to the console depend of STATUS value
 //***********************************************************************
 
 int SendPassFail(Status)
 {
   if (Status == 0) { print("passed\r\n"); } else { print("failed\r\n"); }
   return XST_SUCCESS;
 }

 //**********************************************************************
 //    Send the ADCs Datas buffers ( 10 x 13 bits x 1024 event
 //**********************************************************************

 int SendSyncADCData(void)
 {
	 
 }
     
     
