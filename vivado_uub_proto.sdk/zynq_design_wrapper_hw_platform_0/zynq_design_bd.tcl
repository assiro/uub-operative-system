
################################################################
# This is a generated script based on design: zynq_design
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source zynq_design_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg484-2

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name zynq_design

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set ADC0_CK_N [ create_bd_port -dir I -type clk ADC0_CK_N ]
  set_property -dict [ list CONFIG.FREQ_HZ {120000000}  ] $ADC0_CK_N
  set ADC0_CK_P [ create_bd_port -dir I -type clk ADC0_CK_P ]
  set_property -dict [ list CONFIG.FREQ_HZ {120000000}  ] $ADC0_CK_P
  set ADC1_CK_N [ create_bd_port -dir I -type clk ADC1_CK_N ]
  set_property -dict [ list CONFIG.FREQ_HZ {120000000}  ] $ADC1_CK_N
  set ADC1_CK_P [ create_bd_port -dir I -type clk ADC1_CK_P ]
  set_property -dict [ list CONFIG.FREQ_HZ {120000000}  ] $ADC1_CK_P
  set ADC2_CK_N [ create_bd_port -dir I -type clk ADC2_CK_N ]
  set_property -dict [ list CONFIG.FREQ_HZ {120000000}  ] $ADC2_CK_N
  set ADC2_CK_P [ create_bd_port -dir I -type clk ADC2_CK_P ]
  set_property -dict [ list CONFIG.FREQ_HZ {120000000}  ] $ADC2_CK_P
  set ADC3_CK_N [ create_bd_port -dir I -type clk ADC3_CK_N ]
  set_property -dict [ list CONFIG.FREQ_HZ {120000000}  ] $ADC3_CK_N
  set ADC3_CK_P [ create_bd_port -dir I -type clk ADC3_CK_P ]
  set_property -dict [ list CONFIG.FREQ_HZ {120000000}  ] $ADC3_CK_P
  set ADC4_CK_N [ create_bd_port -dir I -type clk ADC4_CK_N ]
  set_property -dict [ list CONFIG.FREQ_HZ {120000000}  ] $ADC4_CK_N
  set ADC4_CK_P [ create_bd_port -dir I -type clk ADC4_CK_P ]
  set_property -dict [ list CONFIG.FREQ_HZ {120000000}  ] $ADC4_CK_P
  set FPGA_CK_N [ create_bd_port -dir I -type clk FPGA_CK_N ]
  set_property -dict [ list CONFIG.FREQ_HZ {120000000}  ] $FPGA_CK_N
  set FPGA_CK_P [ create_bd_port -dir I -type clk FPGA_CK_P ]
  set_property -dict [ list CONFIG.FREQ_HZ {120000000}  ] $FPGA_CK_P
  set GPS_PPS [ create_bd_port -dir I GPS_PPS ]
  set GPS_RX [ create_bd_port -dir I GPS_RX ]
  set GPS_TX [ create_bd_port -dir O GPS_TX ]
  set LED_ASY [ create_bd_port -dir O LED_ASY ]
  set LED_FLG [ create_bd_port -dir I LED_FLG ]
  set RADIO_CTS [ create_bd_port -dir I RADIO_CTS ]
  set RADIO_RST_IN [ create_bd_port -dir I RADIO_RST_IN ]
  set RADIO_RST_OUT [ create_bd_port -dir O RADIO_RST_OUT ]
  set RADIO_RTS [ create_bd_port -dir O RADIO_RTS ]
  set TP [ create_bd_port -dir O -from 6 -to 2 TP ]
  set TRIG_IN [ create_bd_port -dir I TRIG_IN ]
  set TRIG_OUT [ create_bd_port -dir O TRIG_OUT ]
  set USB_IFAULT [ create_bd_port -dir I USB_IFAULT ]
  set WATCHDOG [ create_bd_port -dir I WATCHDOG ]
  set adc0_n [ create_bd_port -dir I -from 12 -to 0 -type data adc0_n ]
  set adc0_p [ create_bd_port -dir I -from 12 -to 0 -type data adc0_p ]
  set adc1_n [ create_bd_port -dir I -from 12 -to 0 -type data adc1_n ]
  set adc1_p [ create_bd_port -dir I -from 12 -to 0 -type data adc1_p ]
  set adc2_n [ create_bd_port -dir I -from 12 -to 0 -type data adc2_n ]
  set adc2_p [ create_bd_port -dir I -from 12 -to 0 -type data adc2_p ]
  set adc3_n [ create_bd_port -dir I -from 12 -to 0 -type data adc3_n ]
  set adc3_p [ create_bd_port -dir I -from 12 -to 0 -type data adc3_p ]
  set adc4_n [ create_bd_port -dir I -from 12 -to 0 -type data adc4_n ]
  set adc4_p [ create_bd_port -dir I -from 12 -to 0 -type data adc4_p ]
  set ext0_ctl [ create_bd_port -dir O -from 7 -to 0 ext0_ctl ]
  set ext0_dat [ create_bd_port -dir I -from 7 -to 0 -type data ext0_dat ]
  set ext1_ctl [ create_bd_port -dir O -from 7 -to 0 ext1_ctl ]
  set ext1_dat [ create_bd_port -dir I -from 7 -to 0 -type data ext1_dat ]
  set hconf [ create_bd_port -dir I -from 7 -to 0 hconf ]

  # Create instance: In_regional_ck_0, and set properties
  set In_regional_ck_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:In_regional_ck:1.0 In_regional_ck_0 ]

  # Create instance: Interface_uub_0, and set properties
  set Interface_uub_0 [ create_bd_cell -type ip -vlnv Lpsc.in2p3.fr:user:Interface_uub:2.00 Interface_uub_0 ]

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_0 ]

  # Create instance: axi_bram_ctrl_0_bram, and set properties
  set axi_bram_ctrl_0_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 axi_bram_ctrl_0_bram ]
  set_property -dict [ list CONFIG.Memory_Type {True_Dual_Port_RAM}  ] $axi_bram_ctrl_0_bram

  # Create instance: axi_mem_intercon, and set properties
  set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon ]
  set_property -dict [ list CONFIG.NUM_MI {3}  ] $axi_mem_intercon

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]

  # Create instance: delay_input_0, and set properties
  set delay_input_0 [ create_bd_cell -type ip -vlnv in2p3.fr:user:delay_input:1.0 delay_input_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list CONFIG.PCW_ENET0_RESET_ENABLE {1} \
CONFIG.PCW_ENET0_RESET_IO {MIO 50} CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {DDR PLL} CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {DDR PLL} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200.000000} CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_I2C0_I2C0_IO {MIO 14 .. 15} CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_I2C_RESET_ENABLE {0} CONFIG.PCW_IMPORT_BOARD_PRESET {Z:/cao-projets/SPB16X/lagorio/Auger/Document_travail/xilinx/edk_20140221/ps7_system_prj.xml} \
CONFIG.PCW_MIO_0_SLEW {fast} CONFIG.PCW_MIO_10_SLEW {fast} \
CONFIG.PCW_MIO_11_SLEW {fast} CONFIG.PCW_MIO_12_SLEW {fast} \
CONFIG.PCW_MIO_13_SLEW {fast} CONFIG.PCW_MIO_14_SLEW {fast} \
CONFIG.PCW_MIO_15_SLEW {fast} CONFIG.PCW_MIO_1_PULLUP {enabled} \
CONFIG.PCW_MIO_40_SLEW {slow} CONFIG.PCW_MIO_41_SLEW {slow} \
CONFIG.PCW_MIO_42_SLEW {slow} CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {0} CONFIG.PCW_QSPI_GRP_SS1_ENABLE {1} \
CONFIG.PCW_SPI0_GRP_SS1_ENABLE {1} CONFIG.PCW_SPI0_GRP_SS2_ENABLE {1} \
CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1} CONFIG.PCW_SPI0_SPI0_IO {MIO 40 .. 45} \
CONFIG.PCW_SPI1_GRP_SS1_ENABLE {0} CONFIG.PCW_SPI1_GRP_SS2_ENABLE {0} \
CONFIG.PCW_UART0_GRP_FULL_ENABLE {1} CONFIG.PCW_UART0_UART0_IO {MIO 46 .. 47} \
CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} CONFIG.PCW_USB0_RESET_ENABLE {1} \
CONFIG.PCW_USB0_RESET_IO {MIO 51} CONFIG.PCW_USE_EXPANDED_IOP {1} \
 ] $processing_system7_0

  # Create instance: rst_processing_system7_0_97M, and set properties
  set rst_processing_system7_0_97M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_97M ]

  # Create instance: selectio_wiz_0, and set properties
  set selectio_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:selectio_wiz:5.1 selectio_wiz_0 ]
  set_property -dict [ list CONFIG.BUS_IO_STD {LVCMOS25} CONFIG.BUS_SIG_TYPE {SINGLE} CONFIG.SELIO_ACTIVE_EDGE {DDR} CONFIG.SELIO_BUS_IN_DELAY {NONE} CONFIG.SELIO_CLK_BUF {MMCM} CONFIG.SYSTEM_DATA_WIDTH {13}  ] $selectio_wiz_0

  # Create instance: selectio_wiz_1, and set properties
  set selectio_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:selectio_wiz:5.1 selectio_wiz_1 ]
  set_property -dict [ list CONFIG.BUS_IO_STD {LVCMOS25} CONFIG.BUS_SIG_TYPE {SINGLE} CONFIG.SELIO_ACTIVE_EDGE {DDR} CONFIG.SELIO_BUS_IN_DELAY {NONE} CONFIG.SELIO_CLK_BUF {MMCM} CONFIG.SYSTEM_DATA_WIDTH {13}  ] $selectio_wiz_1

  # Create instance: selectio_wiz_2, and set properties
  set selectio_wiz_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:selectio_wiz:5.1 selectio_wiz_2 ]
  set_property -dict [ list CONFIG.BUS_IO_STD {LVCMOS25} CONFIG.BUS_SIG_TYPE {SINGLE} CONFIG.SELIO_ACTIVE_EDGE {DDR} CONFIG.SELIO_BUS_IN_DELAY {NONE} CONFIG.SELIO_CLK_BUF {MMCM} CONFIG.SYSTEM_DATA_WIDTH {13}  ] $selectio_wiz_2

  # Create instance: selectio_wiz_3, and set properties
  set selectio_wiz_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:selectio_wiz:5.1 selectio_wiz_3 ]
  set_property -dict [ list CONFIG.BUS_IO_STD {LVCMOS25} CONFIG.BUS_SIG_TYPE {SINGLE} CONFIG.SELIO_ACTIVE_EDGE {DDR} CONFIG.SELIO_BUS_IN_DELAY {NONE} CONFIG.SELIO_CLK_BUF {MMCM} CONFIG.SYSTEM_DATA_WIDTH {13}  ] $selectio_wiz_3

  # Create instance: selectio_wiz_4, and set properties
  set selectio_wiz_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:selectio_wiz:5.1 selectio_wiz_4 ]
  set_property -dict [ list CONFIG.BUS_IO_STD {LVCMOS25} CONFIG.BUS_SIG_TYPE {SINGLE} CONFIG.SELIO_ACTIVE_EDGE {DDR} CONFIG.SELIO_BUS_IN_DELAY {NONE} CONFIG.SELIO_CLK_BUF {MMCM} CONFIG.SYSTEM_DATA_WIDTH {13}  ] $selectio_wiz_4

  # Create instance: util_ds_buf_3, and set properties
  set util_ds_buf_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_3 ]

  # Create instance: util_ds_buf_4, and set properties
  set util_ds_buf_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_4 ]

  # Create instance: util_ds_buf_5, and set properties
  set util_ds_buf_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_5 ]

  # Create instance: util_ds_buf_6, and set properties
  set util_ds_buf_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_6 ]

  # Create instance: util_ds_buf_7, and set properties
  set util_ds_buf_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_7 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTB [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTB] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_mem_intercon/M00_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M01_AXI [get_bd_intf_pins Interface_uub_0/S00_AXI] [get_bd_intf_pins axi_mem_intercon/M01_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M02_AXI [get_bd_intf_pins axi_mem_intercon/M02_AXI] [get_bd_intf_pins axi_uartlite_0/S_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins processing_system7_0/M_AXI_GP0]

  # Create port connections
  connect_bd_net -net ADC0_CK_N_1 [get_bd_ports ADC0_CK_N] [get_bd_pins util_ds_buf_3/IBUF_DS_N]
  connect_bd_net -net ADC0_CK_P_1 [get_bd_ports ADC0_CK_P] [get_bd_pins util_ds_buf_3/IBUF_DS_P]
  connect_bd_net -net ADC1_CK_N_1 [get_bd_ports ADC1_CK_N] [get_bd_pins util_ds_buf_4/IBUF_DS_N]
  connect_bd_net -net ADC1_CK_P_1 [get_bd_ports ADC1_CK_P] [get_bd_pins util_ds_buf_4/IBUF_DS_P]
  connect_bd_net -net ADC2_CK_N_1 [get_bd_ports ADC2_CK_N] [get_bd_pins util_ds_buf_5/IBUF_DS_N]
  connect_bd_net -net ADC2_CK_P_1 [get_bd_ports ADC2_CK_P] [get_bd_pins util_ds_buf_5/IBUF_DS_P]
  connect_bd_net -net ADC3_CK_N_1 [get_bd_ports ADC3_CK_N] [get_bd_pins util_ds_buf_6/IBUF_DS_N]
  connect_bd_net -net ADC3_CK_P_1 [get_bd_ports ADC3_CK_P] [get_bd_pins util_ds_buf_6/IBUF_DS_P]
  connect_bd_net -net ADC4_CK_N_1 [get_bd_ports ADC4_CK_N] [get_bd_pins util_ds_buf_7/IBUF_DS_N]
  connect_bd_net -net ADC4_CK_P_1 [get_bd_ports ADC4_CK_P] [get_bd_pins util_ds_buf_7/IBUF_DS_P]
  connect_bd_net -net FPGA_CK_N_1 [get_bd_ports FPGA_CK_N] [get_bd_pins In_regional_ck_0/IBUF_DS_N]
  connect_bd_net -net FPGA_CK_P_1 [get_bd_ports FPGA_CK_P] [get_bd_pins In_regional_ck_0/IBUF_DS_P]
  connect_bd_net -net In_regional_ck_0_IBUF_OUT [get_bd_pins In_regional_ck_0/IBUF_OUT] [get_bd_pins Interface_uub_0/FPGA_CK] [get_bd_pins selectio_wiz_0/clk_in] [get_bd_pins selectio_wiz_1/clk_in] [get_bd_pins selectio_wiz_2/clk_in] [get_bd_pins selectio_wiz_3/clk_in] [get_bd_pins selectio_wiz_4/clk_in]
  connect_bd_net -net Interface_uub_0_LED_ASY [get_bd_ports LED_ASY] [get_bd_pins Interface_uub_0/LED_ASY]
  connect_bd_net -net Interface_uub_0_RADIO_RST_OUT [get_bd_ports RADIO_RST_OUT] [get_bd_pins Interface_uub_0/RADIO_RST_OUT]
  connect_bd_net -net Interface_uub_0_TRIG_OUT [get_bd_ports TRIG_OUT] [get_bd_pins Interface_uub_0/TRIG_OUT]
  connect_bd_net -net Interface_uub_0_ec0_out [get_bd_ports ext0_ctl] [get_bd_pins Interface_uub_0/ext0_ctl]
  connect_bd_net -net Interface_uub_0_ec1_out [get_bd_ports ext1_ctl] [get_bd_pins Interface_uub_0/ext1_ctl]
  connect_bd_net -net Interface_uub_0_tp [get_bd_ports TP] [get_bd_pins Interface_uub_0/tp]
  connect_bd_net -net LED_FLG_1 [get_bd_ports LED_FLG] [get_bd_pins Interface_uub_0/LED_FLG]
  connect_bd_net -net PPS_IN_1 [get_bd_ports GPS_PPS] [get_bd_pins Interface_uub_0/GPS_PPS]
  connect_bd_net -net RADIO_RST_IN_1 [get_bd_ports RADIO_RST_IN] [get_bd_pins Interface_uub_0/RADIO_RST_IN]
  connect_bd_net -net TRIG_IN_1 [get_bd_ports TRIG_IN] [get_bd_pins Interface_uub_0/TRIG_IN]
  connect_bd_net -net UART_0_CTSN_1 [get_bd_ports RADIO_CTS] [get_bd_pins processing_system7_0/UART0_CTSN]
  connect_bd_net -net USB_IFAULT_1 [get_bd_ports USB_IFAULT] [get_bd_pins Interface_uub_0/USB_IFAULT]
  connect_bd_net -net WATCHDOG_1 [get_bd_ports WATCHDOG] [get_bd_pins Interface_uub_0/WATCHDOG]
  connect_bd_net -net adc0_n_1 [get_bd_ports adc0_n] [get_bd_pins delay_input_0/IBUF_0_N]
  connect_bd_net -net adc0_p_1 [get_bd_ports adc0_p] [get_bd_pins delay_input_0/IBUF_0_P]
  connect_bd_net -net adc1_n_1 [get_bd_ports adc1_n] [get_bd_pins delay_input_0/IBUF_1_N]
  connect_bd_net -net adc1_p_1 [get_bd_ports adc1_p] [get_bd_pins delay_input_0/IBUF_1_P]
  connect_bd_net -net adc2_n_1 [get_bd_ports adc2_n] [get_bd_pins delay_input_0/IBUF_2_N]
  connect_bd_net -net adc2_p_1 [get_bd_ports adc2_p] [get_bd_pins delay_input_0/IBUF_2_P]
  connect_bd_net -net adc3_n_1 [get_bd_ports adc3_n] [get_bd_pins delay_input_0/IBUF_3_N]
  connect_bd_net -net adc3_p_1 [get_bd_ports adc3_p] [get_bd_pins delay_input_0/IBUF_3_P]
  connect_bd_net -net adc4_n_1 [get_bd_ports adc4_n] [get_bd_pins delay_input_0/IBUF_4_N]
  connect_bd_net -net adc4_p_1 [get_bd_ports adc4_p] [get_bd_pins delay_input_0/IBUF_4_P]
  connect_bd_net -net axi_uartlite_0_tx [get_bd_ports GPS_TX] [get_bd_pins axi_uartlite_0/tx]
  connect_bd_net -net delay_input_0_DDELAY_0 [get_bd_pins delay_input_0/DDELAY_0] [get_bd_pins selectio_wiz_0/data_in_from_pins]
  connect_bd_net -net delay_input_0_DDELAY_1 [get_bd_pins delay_input_0/DDELAY_1] [get_bd_pins selectio_wiz_1/data_in_from_pins]
  connect_bd_net -net delay_input_0_DDELAY_2 [get_bd_pins delay_input_0/DDELAY_2] [get_bd_pins selectio_wiz_2/data_in_from_pins]
  connect_bd_net -net delay_input_0_DDELAY_3 [get_bd_pins delay_input_0/DDELAY_3] [get_bd_pins selectio_wiz_3/data_in_from_pins]
  connect_bd_net -net delay_input_0_DDELAY_4 [get_bd_pins delay_input_0/DDELAY_4] [get_bd_pins selectio_wiz_4/data_in_from_pins]
  connect_bd_net -net ec0_in_1 [get_bd_ports ext0_dat] [get_bd_pins Interface_uub_0/ext0_dat]
  connect_bd_net -net ec1_in_1 [get_bd_ports ext1_dat] [get_bd_pins Interface_uub_0/ext1_dat]
  connect_bd_net -net hconf_1 [get_bd_ports hconf] [get_bd_pins Interface_uub_0/hconf]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins Interface_uub_0/s00_axi_aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/M01_ACLK] [get_bd_pins axi_mem_intercon/M02_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins rst_processing_system7_0_97M/slowest_sync_clk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins delay_input_0/REF_CLOCK] [get_bd_pins processing_system7_0/FCLK_CLK1]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_97M/aux_reset_in] [get_bd_pins rst_processing_system7_0_97M/ext_reset_in]
  connect_bd_net -net processing_system7_0_UART0_RTSN [get_bd_ports RADIO_RTS] [get_bd_pins processing_system7_0/UART0_RTSN]
  connect_bd_net -net rst_processing_system7_0_97M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_processing_system7_0_97M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_97M_peripheral_aresetn [get_bd_pins Interface_uub_0/s00_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/M01_ARESETN] [get_bd_pins axi_mem_intercon/M02_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins rst_processing_system7_0_97M/peripheral_aresetn]
  connect_bd_net -net rst_processing_system7_0_97M_peripheral_reset [get_bd_pins delay_input_0/IO_RESET] [get_bd_pins rst_processing_system7_0_97M/peripheral_reset] [get_bd_pins selectio_wiz_0/io_reset] [get_bd_pins selectio_wiz_1/io_reset] [get_bd_pins selectio_wiz_2/io_reset] [get_bd_pins selectio_wiz_3/io_reset] [get_bd_pins selectio_wiz_4/io_reset]
  connect_bd_net -net rx_1 [get_bd_ports GPS_RX] [get_bd_pins axi_uartlite_0/rx]
  connect_bd_net -net selectio_wiz_0_data_in_to_device [get_bd_pins Interface_uub_0/adc0] [get_bd_pins selectio_wiz_0/data_in_to_device]
  connect_bd_net -net selectio_wiz_1_data_in_to_device [get_bd_pins Interface_uub_0/adc1] [get_bd_pins selectio_wiz_1/data_in_to_device]
  connect_bd_net -net selectio_wiz_2_data_in_to_device [get_bd_pins Interface_uub_0/adc2] [get_bd_pins selectio_wiz_2/data_in_to_device]
  connect_bd_net -net selectio_wiz_3_data_in_to_device [get_bd_pins Interface_uub_0/adc3] [get_bd_pins selectio_wiz_3/data_in_to_device]
  connect_bd_net -net selectio_wiz_4_data_in_to_device [get_bd_pins Interface_uub_0/adc4] [get_bd_pins selectio_wiz_4/data_in_to_device]
  connect_bd_net -net util_ds_buf_3_IBUF_OUT [get_bd_pins Interface_uub_0/ADC0_CK] [get_bd_pins util_ds_buf_3/IBUF_OUT]
  connect_bd_net -net util_ds_buf_4_IBUF_OUT [get_bd_pins Interface_uub_0/ADC1_CK] [get_bd_pins util_ds_buf_4/IBUF_OUT]
  connect_bd_net -net util_ds_buf_5_IBUF_OUT [get_bd_pins Interface_uub_0/ADC2_CK] [get_bd_pins util_ds_buf_5/IBUF_OUT]
  connect_bd_net -net util_ds_buf_6_IBUF_OUT [get_bd_pins Interface_uub_0/ADC3_CK] [get_bd_pins util_ds_buf_6/IBUF_OUT]
  connect_bd_net -net util_ds_buf_7_IBUF_OUT [get_bd_pins Interface_uub_0/ADC4_CK] [get_bd_pins util_ds_buf_7/IBUF_OUT]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs Interface_uub_0/S00_AXI/S00_AXI_reg] SEG_Interface_uub_0_S00_AXI_reg
  create_bd_addr_seg -range 0x2000 -offset 0x40000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x10000 -offset 0x42C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


