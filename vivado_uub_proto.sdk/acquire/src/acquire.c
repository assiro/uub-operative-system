// Data from ADC to file

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>


int main(int argc, char *argv[])
{
	int fd, file,i,j, Status, data_trig, ord;
	int nev = 100;
	int int_trig =  0x41200000;
	int stop_trig = 0x41210000;
	int value = 0;
	unsigned page_addr, page_offset;
	void *ptr,*pt[5],*ptrt,*ptrt1;
	unsigned page_size=sysconf(_SC_PAGESIZE);
	page_offset = 16;
	FILE *fp, *fp1, *fp2;
	int nevt=0;
	if (argc>1) ord = argv[1];
	char filename1[100];
	char filename2[100];
	sprintf(filename1,"/home/root/data/adc_data%s.dat", argv[1]);
	sprintf(filename2,"/home/root/data/adc_data_bin%s.dat", argv[1]);
	fp1 = fopen (filename1, "w" );
	fp2 = fopen (filename2, "w" );



while(nevt<1000)
	{
	fp = fopen ("/srv/www/adc_data.json", "w" );
	/* Open /dev/mem file */
	fd = open ("/dev/mem", O_RDWR);

	//////////////// TRIGGER INTERNO ////////////////////////////////////////
	/* mmap the device into memory */
	page_addr = (int_trig & (~(page_size-1)));
	page_offset = int_trig - page_addr;
	ptrt = mmap(NULL, page_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, page_addr);
/*
	value = 0b00000011; //*int_trig = 0b00000011;//genero trigger e acquisisco segnale in BRAM
	*((unsigned *)(ptr + page_offset)) = value;// Write value to the device register
	usleep(1);
	value = 0b00000010; //*int_trig = 0b00000010;
	*((unsigned *)(ptr + page_offset)) = value;
	////////////////////////////////////////////////////////////////////////
*/
	unsigned int bram[5];
	int w, ADC0A[5], ADC0B[5];
	bram[0] = 0x42000000;// ADC 1
	bram[1] = 0x44000000;// ADC 2
	bram[2] = 0x46000000;// ADC 3
	bram[3] = 0x48000000;// ADC 4
	bram[4] = 0x4A000000;// ADC 5

	//////////   TRIGGER ESTERNO //////////////////////////////////
	data_trig = 0;
	value = 0b10000000; //impostazione per trigger esterno
	*((unsigned *)(ptrt + page_offset)) = value;// Write value to the device register
	usleep(1);
	value = 0b00000000;
	*((unsigned *)(ptrt + page_offset)) = value;

	printf("Waiting trigger... ");


	page_addr = (stop_trig & (~(page_size-1)));	//		data_trig = *stop_trig;
	page_offset = stop_trig - page_addr;
	ptrt1 = mmap(NULL, page_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, page_addr);
	Status = 0;
	while(Status != 1)		// wait trigger
	{
		data_trig = *((unsigned *)(ptrt1 + page_offset));
		if (data_trig > 0b1000000000000000) {
				Status = 1;
				data_trig = data_trig & 0b0111111111111111;
				data_trig = (data_trig + 4095 * 4 - 1000) % (4095 * 4);

                page_offset=data_trig;
	       	}

	}
	printf ("Done! ... Event %d\n",nevt);

		  fprintf(fp1,"Event %d\n",nevt);
	  for(i=0;i<5;i++){
		  //fprintf(fp2,"======adc: =%d=====",i);
		 pt[i] = mmap(NULL, page_size*4, PROT_READ|PROT_WRITE, MAP_SHARED, fd, bram[i]);
         fwrite("!!!!",1,4,fp2);
		 fwrite(&page_offset,sizeof(page_offset),1,fp2);
         fwrite(&i,sizeof(i),1,fp2);
         fwrite((char *)pt[i],1,page_size*4,fp2);
	  }
      nevt++;

	  fprintf(fp,"[");
	  for(j=0; j<nev; j++)  //
	  {
	    fprintf(fp,"{");
	    for (i =0; i<5; i++){
	    		ADC0A[i] = *((unsigned *)(pt[i] + page_offset));

	    		ADC0B[i] =ADC0A[i]&0x1fff;

		           fprintf(fp1,"adc%d %4d\t",i*2, (ADC0A[i]>>16)&0x1fff);
		           fprintf(fp1,"adc%d %4d\t",i*2+1, ADC0B[i]);
//		           printf  ("\"adc%d\": \"%d\"",i*2,(ADC0A[i]>>16)&0x1fff);
//		           printf(", \"adc%d\": \"%d\"",i*2+1, ADC0B[i]);
		           fprintf  (fp,"\"adc%d\": \"%d\"",i*2, (ADC0A[i]>>16)&0x1fff);
		           fprintf(fp,", \"adc%d\": \"%d\"",i*2+1, ADC0B[i]);
	           if (i != 4) {fprintf(fp,", ");}
	           else {fprintf(fp1,"\n");}
	           page_offset=(page_offset+4)&0x3ffc;
		}
	    fprintf(fp,"}");
	    if (j!=nev-1)  fprintf(fp,", ");

	  }
	  fprintf(fp,"]");

	    fclose(fp);
//sleep(1);
	    usleep(10000);
		}
printf("Files written!\n\r");
fclose(fp1);
fclose(fp2);

	    return 0;


}
