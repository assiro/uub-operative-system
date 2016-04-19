  // Developed by Assiro Roberto 11/2015
  
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

#define IIC_DEVICE_ID		XPAR_PS7_I2C_0_DEVICE_ID
#define IIC_SLAVE_ADDR		0x0C // DAC slave address DAC AD5316
#define IIC_SLAVE2_ADDR		0x65 // DAC slave address DAC LTC2637
#define IIC_SCLK_RATE		100000
#define BUFFER_SIZE	132
#define true  1
#define false 0
extern XUartLite UartLite;      /* Instance of the UartLite device */

u8 pointer_byte;
u8 RecvChar;
u32 CntrlRegister;
u32 CntrlRegister2;
int led_controller_setting(u16 DeviceId);
int hv_voltage_setting(u16 DeviceId);

XIicPs Iic;		/**< Instance of the IIC Device */
u8 SendBuffer[BUFFER_SIZE];    /**< Buffer for Transmitting Data */

 int dac_led1, dac_led2, dac_led3, dac_led4, hv;
// USCITA PX3
 dac_led1 = 230;//valore canale 1 dac led
 dac_led3 = 180;//valore canale 3 dac led

 // USCITA PX4
 dac_led2 = 400;//valore canale 2 dac led
 dac_led4 = 400;//valore canale 4 dac led

 hv = 1100; //high voltage... volts

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
    

    print(" ***************************************************\n\r");
    print(" ***                 WP1 RUN Process             ***\n\r");
    print(" ***************************************************\n\r");

    {
       print(" Initialization of GPS UART link ............... : ");
       Status = UartLiteSelfTestExample(XPAR_AXI_UARTLITE_0_DEVICE_ID);
       SendPassFail(Status);
    }


    {
      int tst_enable ;
      

      // initialise le circuit clock generator CDEL913
      print(" Initialization of I2C clock generator ... : ");
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

      // Initialize the Quad DAC chip AD5316
       print(" Initialization of DAC AD5316 ............ : ");
       XIicPs_ResetHw(XPAR_XIICPS_0_BASEADDR);
       Status = IicPsInitI2C0(XPAR_PS7_I2C_0_DEVICE_ID);
       SendPassFail(Status);

       // Initialize the Octa DAC chip LTC2637
              print(" Initialization of DAC LTC2637 ............ : ");
              XIicPs_ResetHw(XPAR_XIICPS_0_BASEADDR);
              Status = IicPsInitI2C0(XPAR_PS7_I2C_0_DEVICE_ID);
              SendPassFail(Status);

    }
    // Configurazione DAC LED I2C
            	Status = led_controller_setting(IIC_DEVICE_ID);
            	if (Status != XST_SUCCESS) {
            		print("IIC Master non riceve risposta dal DAC\r\n");
            		return XST_FAILURE;
            	}
            	print(" Impostazione LED inviata al DAC...\r\n");
/**/
    // Configurazione DAC High voltage
                Status = hv_voltage_setting(IIC_DEVICE_ID);
                print(" Impostazione HV inviata al DAC...\r\n");


        sleep(1);

    //*********************************************************************
    //   - Send ADC data to the GPS UART
    //
    //*********************************************************************
/*
    u8 RadioSdDat[4] = {0x41,0x42,0x43,0x44};
    u8 RadioRvDat[4] = {0x00,0x00,0x00,0x00};
    int data_display;
    unsigned int *state_register;
     print(" SEND ADC TO GPS UART ...\n\r\n");
    XUartLite_ResetFifos(&UartLite);
    XUartLite_Send(&UartLite,RadioSdDat,4);

    XUartLite_Recv(&UartLite,RadioRvDat,4);    //ricevo dati da seriale
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
*/




    print(" ***  END START UP  ***\n\r\n");
while(1)
{


//   Status = SpiPs_Init_SPI(XPAR_PS7_SPI_1_DEVICE_ID, 0);	// funzione di setup_ADC
//   SendADCData();


	unsigned int *bram0, *bram1, *bram2, *bram3, *bram4, *int_trig, *stop_trig;
	int w, z, x, y,j ,h, ADC0A, ADC0B, ADC1A, ADC1B, ADC2A, ADC2B, ADC3A, ADC3B, ADC4A, ADC4B, data_trig;
	int_trig = 0x41200000;
    bram0 = 0x42000320;	// ADC 1
    bram1 = 0x44000320; // ADC 2
    bram2 = 0x46000320;	// ADC 3
    bram3 = 0x48000320; // ADC 4
    bram4 = 0x4A000320;	// ADC 5
    data_trig = 0;
/*
//////////   TRIGGER ESTERNO //////////////////////////////////

	  *int_trig = 0b10000000;
      usleep(1);
      *int_trig = 0b00000000;
      print("Waiting trigger... ");
      stop_trig = 0x41210000;
      Status = 0;

while(Status != 1)
{
	data_trig = *stop_trig;
	if (data_trig > 0b1000000000000000) {
			Status = 1;
			printf("Trigger  %x\n\r",data_trig);
			data_trig = data_trig & 0b0111111111111111;
			data_trig = data_trig / 4;
//		    bram0 = 0x42000000 + data_trig;	// ADC 1
//		    bram1 = 0x44000000 + data_trig;   // ADC 2
//		    bram2 = 0x46000000 + data_trig;	// ADC 3
//		    bram3 = 0x48000000 + (data_trig / 2);   // ADC 4
//		    bram4 = 0x4A000000 + (data_trig / 2);	// ADC 5
//		    printf("memoria0  %X\n\r",bram0);

    	    printf("Trigger ext ricevuto %D\n\r",data_trig);
       	}
}
*/
///////////////////////////////////////////////////////////////
//					INVIO DATI SU SERIALE GPS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    print("Invio dati su UART GPS...  ");
// Lettura BRAM


/**/
//////////////// TRIGGER INTERNO ////////////////////////////////////////
    *int_trig = 0b00000011;//genero trigger e acquisisco segnale in BRAM
    usleep(1);
    *int_trig = 0b00000010;
////////////////////////////////////////////////////////////////////////


    XUartLite_Send(&UartLite,"UUB",3);// invio header trasmissione seriale su AXI UART

    for ( w = 0; w < 100; w++) //da usare con programma uub_json_ch
//    for ( w = 0; w < 4096; w++) //da usare con programma di francesca
//    for ( w = 0; w < 2000; w++) //numero dilocazioni BRAM da inviare su seriale.
           {
    	   ADC0A = *bram0;
           ADC0B = *bram0&0xfff;
           ADC1A = *bram1;
           ADC1B = *bram1&0xfff;
    	   ADC2A = *bram2;
    	   ADC2B = *bram2&0xfff;	//  ADC2B = 0x0800;
           ADC3A = *bram3;
           ADC3B = *bram3&0xfff;
    	   ADC4A = *bram4;
           ADC4B = *bram4&0xfff;
           y = (ADC0A>>16)&0xfff;
           x = (ADC1A>>16)&0xfff;
           z = (ADC2A>>16)&0xfff;	//z = 0x0800;
           j = (ADC3A>>16)&0xfff;
           h = (ADC4A>>16)&0xfff;
//           printf("chA = %D chB = %D | chA = %D chB = %D | chA = %D chB = %D | chA = %D chB = %D | chA = %D chB = %D\r\n", y, ADC0B, x, ADC1B, z, ADC2B, j, ADC3B, h, ADC4B);
//           printf("chA = %X chB = %X | chA = %X chB = %X | chA = %X chB = %X | chA = %X chB = %X | chA = %X chB = %X\r\n", y, ADC0B, x, ADC1B, z, ADC2B, j, ADC3B, h, ADC4B);
//     	     printf( " Cha. A = %5D, Cha. B = %5D",data_display & 0xffff,data_display >>16);

/////////////// invio seti su AXI lite /////////////////////////////////
/*
*/

    	   XUartLite_Send(&UartLite,&y,2);
           usleep(3000);
           XUartLite_Send(&UartLite,&ADC0B,2);
           usleep(3000);

           XUartLite_Send(&UartLite,&x,2);
           usleep(3000);
           XUartLite_Send(&UartLite,&ADC1B,2);
           usleep(3000);

           XUartLite_Send(&UartLite,&z,2);
           usleep(3000);
           XUartLite_Send(&UartLite,&ADC2B,2);
           usleep(3000);
/*
           XUartLite_Send(&UartLite,&j,2);
           usleep(3000);
           XUartLite_Send(&UartLite,&ADC3B,2);
           usleep(3000);

           XUartLite_Send(&UartLite,&h,2);
           usleep(3000);
           XUartLite_Send(&UartLite,&ADC4B,2);
           usleep(3000);
*/


           bram0 ++;
           bram1 ++;
           bram2 ++;
           bram3 ++;
           bram4 ++;
           }

//    	   usleep(3000);
//    	   XUartLite_Send(&UartLite,&data_trig,2); // invio valore trigger

           print("Ok inviati!\n\r");
/*
           stop_trig = 0x41210000;
           data_trig = *stop_trig;
           printf("Indirizzo trigger = %X \n\r",data_trig);
           *int_trig = 0b10000000;//genero trigger e acquisisco segnale in BRAM
           usleep(1);
           *int_trig = 0b00000000;
*/

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

 /////////////////////////////////////////////////////////////////////////////////
 //LED CONTROLLER
 //////////////////////////////////////////////////////////////////////////////////
 //int IicPsMasterPolledExample(u16 DeviceId)
 int led_controller_setting(u16 DeviceId)
 {
 	int Stato;
 	XIicPs_Config *Config;
 	int Index;

 	Config = XIicPs_LookupConfig(DeviceId);
 	if (NULL == Config) {
 		return XST_FAILURE;
 	}

 	Stato = XIicPs_CfgInitialize(&Iic, Config, Config->BaseAddress);
 	if (Stato != XST_SUCCESS) {
 		return XST_FAILURE;
 	}

 	Stato = XIicPs_SelfTest(&Iic);
 	if (Stato != XST_SUCCESS) {
 		return XST_FAILURE;
 	}

 	XIicPs_SetSClk(&Iic, IIC_SCLK_RATE);  //Set the IIC serial clock rate
 	pointer_byte = 0x01;
 // calcolo dei dati da inviare si I2c per programmare DAC
 //	ctrl_reg = 112 #registro di controllo del DAC impostato 01110000 (4 bit significativi)
 //	a = (val_ch1/64)+ctrl_reg	#primi 4 bit piu' significativi di val trasferiti nei meno 4 significativi di a e aggiungo ctrl_reg
 //	b = (val_ch1 & 0x3F)*4
 //	values1 = [a, b]

 //	val_hv = val_hv / 1.85;
 // Preparo i byte da inviare in sendbuffer
 // calcolo canale 1
 	SendBuffer[0] = 0x01;	//Seleziono canale del DAC
 	SendBuffer[1] = (dac_led1/64) + 112; //primi 4 bit piu' significativi di val trasferiti nei meno 4 significativi di a e aggiungo ctrl_reg=112
 	SendBuffer[2] = (dac_led1 & 0x3F)*4;
 	XIicPs_MasterSendPolled(&Iic, SendBuffer, 3, IIC_SLAVE_ADDR); // invio al DAC tutti i byte di programmazione di 4 canali
 	usleep(1000);

 // calcolo canale 2
 	SendBuffer[0] = 0x02;	//Seleziono canale del DAC
 	SendBuffer[1] = (dac_led2/64) + 112; //primi 4 bit piu' significativi di val trasferiti nei meno 4 significativi di a e aggiungo ctrl_reg=112
 	SendBuffer[2] = (dac_led2 & 0x3F)*4;
 	XIicPs_MasterSendPolled(&Iic, SendBuffer, 3, IIC_SLAVE_ADDR); // invio al DAC tutti i byte di programmazione di 4 canali
 	usleep(1000);

 // calcolo canale 3
 	SendBuffer[0] = 0x04;	//Seleziono canale del DAC
 	SendBuffer[1] = (dac_led3/64) + 112; //primi 4 bit piu' significativi di val trasferiti nei meno 4 significativi di a e aggiungo ctrl_reg=112
 	SendBuffer[2] = (dac_led3 & 0x3F)*4;
 	XIicPs_MasterSendPolled(&Iic, SendBuffer, 3, IIC_SLAVE_ADDR); // invio al DAC tutti i byte di programmazione di 4 canali
 	usleep(1000);

 // calcolo canale 4
 	SendBuffer[0] = 0x08;	//Seleziono canale del DAC
 	SendBuffer[1] = (dac_led4/64) + 112; //primi 4 bit piu' significativi di val trasferiti nei meno 4 significativi di a e aggiungo ctrl_reg=112
 	SendBuffer[2] = (dac_led4 & 0x3F)*4;
 	XIicPs_MasterSendPolled(&Iic, SendBuffer, 3, IIC_SLAVE_ADDR); // invio al DAC tutti i byte di programmazione di 4 canali

 	return XST_SUCCESS;
 }


 /////////////////////////////////////////////////////////////////////////////////
  //HIGH VOLTAGE
  //////////////////////////////////////////////////////////////////////////////////
  int hv_voltage_setting(u16 DeviceId)
  {
  	int Stato;
  	XIicPs_Config *Config;
  	int Index;

  	Config = XIicPs_LookupConfig(DeviceId);
  	if (NULL == Config) {
  		return XST_FAILURE;
  	}

  	Stato = XIicPs_CfgInitialize(&Iic, Config, Config->BaseAddress);
  	if (Stato != XST_SUCCESS) {
  		return XST_FAILURE;
  	}

  	Stato = XIicPs_SelfTest(&Iic);
  	if (Stato != XST_SUCCESS) {
  		return XST_FAILURE;
  	}

  	XIicPs_SetSClk(&Iic, IIC_SCLK_RATE);  //Set the IIC serial clock rate

  	hv = hv * 1.92;		// alimentatore hv CAEN
//	hv = hv * 4.05;		// alimentatore hv roberto
// Preparo i byte da inviare in sendbuffer
	SendBuffer[0] = 0x3F;	//Seleziono tutti i canali del DAC e invio comando scrittura
	SendBuffer[1] = (hv/16); //primi 8 bit piu' significativi di val
	SendBuffer[2] = (hv&0xFF)*16;
	XIicPs_MasterSendPolled(&Iic, SendBuffer, 3, IIC_SLAVE2_ADDR); // invio al DAC tutti i byte di programmazione di 4 canali
  	usleep(1000);

  	return XST_SUCCESS;
  }
