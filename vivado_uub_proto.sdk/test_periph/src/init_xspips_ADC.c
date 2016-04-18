 
 //************************************************************************
 //
 // @file xspi_init_ADC.c
 //
 // @note
 //
 // None.
 //
 // MODIFICATION HISTORY:
 //
 //***********************************************************************
 
 //************************** Include Files ******************************
 
 #include "xparameters.h"  /* EDK generated parameters */
 #include "xspips.h"       /* SPI device driver */
 #include "xil_printf.h"
 #include "new_uub.h"
 
 //*********************** Constant Definitions ************************
 
 // The following constant defines the slave select signal that is used to 
 // select the ADC device on the SPI bus
  
 #define SPI_SELECT_ADC0 0x00
 #define SPI_SELECT_ADC1 0x01
 #define SPI_SELECT_ADC2 0x02
 #define SPI_SELECT_ADC3 0x03
 #define SPI_SELECT_ADC4 0x04
 
 //**************************** Type Definitions ************************
 
 //***************** Macros (Inline Functions) Definitions **************
 
 XSpiPs Spi;
 
 #define read_buffer_size  10                // size of the SPI read buffer
 #define write_buffer_size 10                // size of the SPI write buffer
 u8 ReadBuffer[read_buffer_size]   = {0x00}; // SPI read buffer initialize to 0
 u8 WriteBuffer[write_buffer_size] = {0x00}; // SPI write buffer initialize to 0
 static u8 ADC_CONFIG0[3] = {0x00,0x14,0xA1} ; // ADC configuration word
 // R/W = 0, W1-W0 = 0, @ high = 0 ; @ register = 0x14; data to write = A1
 static u8 cmd2channel[3] = {0x00,0x05,0x03}; // Select the 2 channels for previous cmd
 static u8 cmdchannelA[3] = {0x00,0x05,0x01}; // Select the channel A for previous cmd
 static u8 cmdchannelB[3] = {0x00,0x05,0x02}; // Select the channel B for previous cmd
 static u8 TestModeMS[3]  = {0x00,0x0D,0x01}; // ADC Test Mode Middle Scale
 static u8 TestModeFS[3]  = {0x00,0x0D,0x02}; // ADC Test Mode Full Scale
 static u8 TestModeOff[3] = {0x00,0x0D,0x00}; // ADC Test Mode Off
 u8 DataUserValueMsb = 0xAA;
 u8 DataUserValueLsb = 0x55;
 static u8 TstUser1LSB[3] = {0x00,0x19,0x55}; // User defined pattern 1 LSB
 static u8 TstUser1MSB[3] = {0x00,0x1A,0xAA}; // User defined pattern 1 MSB
 static u8 TestModeUM[3]  = {0x00,0x0D,0x08}; // ADC Test Mode USER1
 static u8 AdcDelay[5]    = {0x00};           // Calculated ADC delay table
 
 //************************************************************************
 // 
 //  This function initialize the five ADC chips throught the XSpiPs device 
 //  driver configurated in polled mode. 
 // 
 //  @param  SpiInstancePtr is a pointer to the Spi Instance.
 //  @param  SpiDeviceId is the Device Id of Spi.
 // 
 //  @return XST_SUCCESS if successful else XST_FAILURE.
 // 
 //  @note
 // 
 //*************************************************************************
 int SpiPs_Init_SPI(u16 SpiDeviceId, char valid_display)
 {
   int Status,j;
   u8 k;   
   XSpiPs_Config *SpiConfig;
 
   // Initialize the SPI driver so that it's ready to use
   SpiConfig = XSpiPs_LookupConfig(SpiDeviceId);
   if (NULL == SpiConfig) { return XST_FAILURE; }
 
   Status = XSpiPs_CfgInitialize(&Spi, SpiConfig, SpiConfig->BaseAddress);
   if (Status != XST_SUCCESS) { return XST_FAILURE; }
 
   // Perform a self-test to check hardware build
   Status = XSpiPs_SelfTest(&Spi);
   if (Status != XST_SUCCESS) { return XST_FAILURE; }
 
   // Set the SCLK frequency to SPI_REF_CLK / XSPIPS_CLK_PRESCALE_xx
   XSpiPs_SetClkPrescaler(&Spi, XSPIPS_CLK_PRESCALE_32);
   if (Status != XST_SUCCESS) { return XST_FAILURE; }
 
 //**********************************************************************
 //                    Initialize The ADC components  
 //**********************************************************************
 
   // Set the Spi device as a master ( is slave by default).
   XSpiPs_SetOptions(&Spi, XSPIPS_MASTER_OPTION |
 		                  XSPIPS_FORCE_SSELECT_OPTION |
 		                  XSPIPS_DECODE_SSELECT_OPTION);
   if (Status != XST_SUCCESS) { return XST_FAILURE; }
   
   // ADC AD9628 configuration : * output format : twos complement
   //                            * Output port logic : LVDS ANSI
   //                            * Output interleave
   
     for (k = SPI_SELECT_ADC0; k < (SPI_SELECT_ADC4 + 0x01); k++)
      {
        XSpiPs_SetSlaveSelect(&Spi, k);                         // Assert the chip select
        if (Status != XST_SUCCESS) { return XST_FAILURE; }
        XSpiPs_PolledTransfer(&Spi, cmd2channel, ReadBuffer, 3);// select the 2 channels
        if (Status != XST_SUCCESS) { return XST_FAILURE; }
        XSpiPs_PolledTransfer(&Spi, ADC_CONFIG0, ReadBuffer, 3);// send configuration
        if (Status != XST_SUCCESS) { return XST_FAILURE; }
      }  
 
   //******************************************************************
   //                 Search the middle of the eye
   //******************************************************************
     unsigned int *registre_adc;
     
     int data_display;
     char channel_first,channel_nb;
    
     for (k = SPI_SELECT_ADC0; k < (SPI_SELECT_ADC4 + 0x01); k++)
     {
       // on accedera aux deus channel A et B
       // Write config data into ADC0 Chip
       XSpiPs_SetSlaveSelect(&Spi, SPI_SELECT_ADC0);     // Assert the chip select
       XSpiPs_PolledTransfer(&Spi, cmd2channel, ReadBuffer, 3);
       
       // les 2 ADCs sont placé au point milieu => 0
       XSpiPs_SetSlaveSelect(&Spi, k);     // Assert the chip select
       XSpiPs_PolledTransfer(&Spi, TestModeMS, ReadBuffer, 3); // A & B midle Scale

       // Write the USER-<defined pzttern 1
       XSpiPs_SetSlaveSelect(&Spi, k);     // Assert the chip select
       XSpiPs_PolledTransfer(&Spi, TstUser1MSB, ReadBuffer, 3); // MSB = 0x0A
       XSpiPs_SetSlaveSelect(&Spi, k);     // Assert the chip select
       XSpiPs_PolledTransfer(&Spi, TstUser1LSB, ReadBuffer, 3); // LSB = 0x55
              
       // on accedera plus que la channel A
       // Write config data into ADC0 Chip
       XSpiPs_SetSlaveSelect(&Spi, k);     // Assert the chip select
       XSpiPs_PolledTransfer(&Spi, cmdchannelA, ReadBuffer, 3);
       
       // les channel A est place en positive Full Scale
       XSpiPs_SetSlaveSelect(&Spi, k);     // Assert the chip select
       XSpiPs_PolledTransfer(&Spi, TestModeUM, ReadBuffer, 3);
       
       WriteBuffer[0] = 0x00;  // writing cycle
       WriteBuffer[1] = 0x17;  // @ register : Output Delay   
       registre_adc = XPAR_INTERFACE_UUB_0_S00_AXI_BASEADDR + ( k * 4);
       channel_first = 0;
       channel_nb = 0;
       
       if ( valid_display == 1 ) { print("\r\n"); } // pour mettre en forme l'affichage
       for (j = 0; j<8;j++)
       {
   	     WriteBuffer[2] = 0x20 + j;                               // data to write
   	     XSpiPs_SetSlaveSelect(&Spi, k);                          // Assert the CSb
   	     XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3); // send delay
         data_display = *registre_adc;
         if (data_display == 0xAA5)
         { 
	       if ( channel_first == 0x0) { channel_first = j ; } 
	       channel_nb = channel_nb + 1;
         }
         if (valid_display == 1)
         {
     	   printf( " Delay = %d, data_delay = %X, Channel A = %4X,  Channel B = %4X @read %8X \r\n",j,WriteBuffer[2],data_display & 0xffff,data_display >>16,registre_adc);
 	     }
       }
              
   	   WriteBuffer[2] = 0x20 + channel_first + ( channel_nb >> 1);   // data to write
   	   AdcDelay[k] = WriteBuffer[2];
       XSpiPs_PolledTransfer(&Spi, WriteBuffer, ReadBuffer, 3); // send delay
       XSpiPs_PolledTransfer(&Spi, cmd2channel, ReadBuffer, 3); // Select the 2 channel
   	   XSpiPs_PolledTransfer(&Spi, TestModeOff, ReadBuffer, 3); // ADC Test Mode Off
       
     }
   return XST_SUCCESS;
 }  
   
 //***********************************************************************
 //            Send the ADC data throught the UART SYTEM
 //***********************************************************************
 
 int SendADCData(void)
 {
    unsigned int *registre_adc, *state_register;
    int data_display;
    int j; 
    
    state_register = UUB_STATE_REGISTER;
    data_display = *state_register;
    while( (data_display & 0xff) != 0x0 )
    {
       registre_adc = XPAR_INTERFACE_UUB_0_S00_AXI_BASEADDR;
      for (j = 0; j<5;j++)
      {
         data_display = *registre_adc;
         printf( " Cha. A = %5D, Cha. B = %5D",data_display & 0xffff,data_display >>16);
         registre_adc = registre_adc + 1; 
      }
      print(" \n\r");             // New line = Send Carriagereturn et line feed
      data_display = *state_register;
    }

   return XST_SUCCESS;
 }
