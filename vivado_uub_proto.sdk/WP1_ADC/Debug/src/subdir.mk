################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/ADC_run.c \
../src/init_xiicps_clock_generator.c \
../src/init_xiicps_slow_led.c \
../src/init_xspips_ADC.c \
../src/init_xspips_DAC.c \
../src/memorytest.c \
../src/xdevcfg_selftest_example.c \
../src/xdmaps_example_w_intr.c \
../src/xemacps_example_intr_dma.c \
../src/xemacps_example_util.c \
../src/xiicps_selftest_example.c \
../src/xqspips_selftest_example.c \
../src/xscugic_tapp_example.c \
../src/xscutimer_intr_example.c \
../src/xscutimer_polled_example.c \
../src/xscuwdt_intr_example.c \
../src/xspips_selftest_example.c \
../src/xuartlite_selftest_example.c \
../src/xuartps_intr_example.c \
../src/xuartps_polled_example.c 

OBJS += \
./src/ADC_run.o \
./src/init_xiicps_clock_generator.o \
./src/init_xiicps_slow_led.o \
./src/init_xspips_ADC.o \
./src/init_xspips_DAC.o \
./src/memorytest.o \
./src/xdevcfg_selftest_example.o \
./src/xdmaps_example_w_intr.o \
./src/xemacps_example_intr_dma.o \
./src/xemacps_example_util.o \
./src/xiicps_selftest_example.o \
./src/xqspips_selftest_example.o \
./src/xscugic_tapp_example.o \
./src/xscutimer_intr_example.o \
./src/xscutimer_polled_example.o \
./src/xscuwdt_intr_example.o \
./src/xspips_selftest_example.o \
./src/xuartlite_selftest_example.o \
./src/xuartps_intr_example.o \
./src/xuartps_polled_example.o 

C_DEPS += \
./src/ADC_run.d \
./src/init_xiicps_clock_generator.d \
./src/init_xiicps_slow_led.d \
./src/init_xspips_ADC.d \
./src/init_xspips_DAC.d \
./src/memorytest.d \
./src/xdevcfg_selftest_example.d \
./src/xdmaps_example_w_intr.d \
./src/xemacps_example_intr_dma.d \
./src/xemacps_example_util.d \
./src/xiicps_selftest_example.d \
./src/xqspips_selftest_example.d \
./src/xscugic_tapp_example.d \
./src/xscutimer_intr_example.d \
./src/xscutimer_polled_example.d \
./src/xscuwdt_intr_example.d \
./src/xspips_selftest_example.d \
./src/xuartlite_selftest_example.d \
./src/xuartps_intr_example.d \
./src/xuartps_polled_example.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -I../../standalone_bsp_1/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


