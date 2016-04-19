
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


# Hierarchical cell: ZYNC_block
proc create_hier_cell_ZYNC_block { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_ZYNC_block() - Empty argument(s)!"
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR
  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M03_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M04_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M05_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M06_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M07_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M08_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M09_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M10_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M11_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M12_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M13_AXI

  # Create pins
  create_bd_pin -dir O -type clk FCLK_CLK0
  create_bd_pin -dir O -type clk FCLK_CLK1
  create_bd_pin -dir I -from 1 -to 0 -type intr IRQ_F2P
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_reset
  create_bd_pin -dir I rx
  create_bd_pin -dir O -from 0 -to 0 -type rst s_axi_aresetn
  create_bd_pin -dir O tx

  # Create instance: axi_mem_intercon, and set properties
  set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon ]
  set_property -dict [ list CONFIG.NUM_MI {14}  ] $axi_mem_intercon

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list CONFIG.PCW_ENET0_RESET_ENABLE {1} \
CONFIG.PCW_ENET0_RESET_IO {MIO 50} CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {DDR PLL} CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {DDR PLL} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200.000000} CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_I2C0_I2C0_IO {MIO 14 .. 15} CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_I2C_RESET_ENABLE {0} CONFIG.PCW_IMPORT_BOARD_PRESET {Z:/cao-projets/SPB16X/lagorio/Auger/Document_travail/xilinx/edk_20140221/ps7_system_prj.xml} \
CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_MIO_0_SLEW {fast} \
CONFIG.PCW_MIO_10_SLEW {fast} CONFIG.PCW_MIO_11_SLEW {fast} \
CONFIG.PCW_MIO_12_SLEW {fast} CONFIG.PCW_MIO_13_SLEW {fast} \
CONFIG.PCW_MIO_14_SLEW {fast} CONFIG.PCW_MIO_15_SLEW {fast} \
CONFIG.PCW_MIO_1_PULLUP {enabled} CONFIG.PCW_MIO_40_SLEW {slow} \
CONFIG.PCW_MIO_41_SLEW {slow} CONFIG.PCW_MIO_42_SLEW {slow} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_SS1_ENABLE {1} CONFIG.PCW_SPI0_GRP_SS1_ENABLE {1} \
CONFIG.PCW_SPI0_GRP_SS2_ENABLE {1} CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SPI0_SPI0_IO {MIO 40 .. 45} CONFIG.PCW_SPI1_GRP_SS1_ENABLE {0} \
CONFIG.PCW_SPI1_GRP_SS2_ENABLE {0} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART0_GRP_FULL_ENABLE {0} CONFIG.PCW_UART0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_UART0_UART0_IO {<Select>} CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} \
CONFIG.PCW_USB0_RESET_ENABLE {1} CONFIG.PCW_USB0_RESET_IO {MIO 51} \
CONFIG.PCW_USE_EXPANDED_IOP {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
 ] $processing_system7_0

  # Create instance: rst_processing_system7_0_97M, and set properties
  set rst_processing_system7_0_97M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_97M ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins M13_AXI] [get_bd_intf_pins axi_mem_intercon/M13_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi_mem_intercon/M00_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M01_AXI [get_bd_intf_pins M01_AXI] [get_bd_intf_pins axi_mem_intercon/M01_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M02_AXI [get_bd_intf_pins axi_mem_intercon/M02_AXI] [get_bd_intf_pins axi_uartlite_0/S_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M03_AXI [get_bd_intf_pins M03_AXI] [get_bd_intf_pins axi_mem_intercon/M03_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M04_AXI [get_bd_intf_pins M04_AXI] [get_bd_intf_pins axi_mem_intercon/M04_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M05_AXI [get_bd_intf_pins M05_AXI] [get_bd_intf_pins axi_mem_intercon/M05_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M06_AXI [get_bd_intf_pins M06_AXI] [get_bd_intf_pins axi_mem_intercon/M06_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M07_AXI [get_bd_intf_pins M07_AXI] [get_bd_intf_pins axi_mem_intercon/M07_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M08_AXI [get_bd_intf_pins M08_AXI] [get_bd_intf_pins axi_mem_intercon/M08_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M09_AXI [get_bd_intf_pins M09_AXI] [get_bd_intf_pins axi_mem_intercon/M09_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M10_AXI [get_bd_intf_pins M10_AXI] [get_bd_intf_pins axi_mem_intercon/M10_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M11_AXI [get_bd_intf_pins M11_AXI] [get_bd_intf_pins axi_mem_intercon/M11_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M12_AXI [get_bd_intf_pins M12_AXI] [get_bd_intf_pins axi_mem_intercon/M12_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_pins DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_pins FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins processing_system7_0/M_AXI_GP0]

  # Create port connections
  connect_bd_net -net axi_uartlite_0_tx [get_bd_pins tx] [get_bd_pins axi_uartlite_0/tx]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins FCLK_CLK0] [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/M01_ACLK] [get_bd_pins axi_mem_intercon/M02_ACLK] [get_bd_pins axi_mem_intercon/M03_ACLK] [get_bd_pins axi_mem_intercon/M04_ACLK] [get_bd_pins axi_mem_intercon/M05_ACLK] [get_bd_pins axi_mem_intercon/M06_ACLK] [get_bd_pins axi_mem_intercon/M07_ACLK] [get_bd_pins axi_mem_intercon/M08_ACLK] [get_bd_pins axi_mem_intercon/M09_ACLK] [get_bd_pins axi_mem_intercon/M10_ACLK] [get_bd_pins axi_mem_intercon/M11_ACLK] [get_bd_pins axi_mem_intercon/M12_ACLK] [get_bd_pins axi_mem_intercon/M13_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins rst_processing_system7_0_97M/slowest_sync_clk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins FCLK_CLK1] [get_bd_pins processing_system7_0/FCLK_CLK1]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_97M/aux_reset_in] [get_bd_pins rst_processing_system7_0_97M/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_97M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_processing_system7_0_97M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_97M_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/M01_ARESETN] [get_bd_pins axi_mem_intercon/M02_ARESETN] [get_bd_pins axi_mem_intercon/M03_ARESETN] [get_bd_pins axi_mem_intercon/M04_ARESETN] [get_bd_pins axi_mem_intercon/M05_ARESETN] [get_bd_pins axi_mem_intercon/M06_ARESETN] [get_bd_pins axi_mem_intercon/M07_ARESETN] [get_bd_pins axi_mem_intercon/M08_ARESETN] [get_bd_pins axi_mem_intercon/M09_ARESETN] [get_bd_pins axi_mem_intercon/M10_ARESETN] [get_bd_pins axi_mem_intercon/M11_ARESETN] [get_bd_pins axi_mem_intercon/M12_ARESETN] [get_bd_pins axi_mem_intercon/M13_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins rst_processing_system7_0_97M/peripheral_aresetn]
  connect_bd_net -net rst_processing_system7_0_97M_peripheral_reset [get_bd_pins peripheral_reset] [get_bd_pins rst_processing_system7_0_97M/peripheral_reset]
  connect_bd_net -net rx_1 [get_bd_pins rx] [get_bd_pins axi_uartlite_0/rx]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins IRQ_F2P] [get_bd_pins processing_system7_0/IRQ_F2P]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Wp2_Trigger_block
proc create_hier_cell_Wp2_Trigger_block { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_Wp2_Trigger_block() - Empty argument(s)!"
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI1
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI2
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_INTR

  # Create pins
  create_bd_pin -dir I -from 119 -to 0 ADC
  create_bd_pin -dir O TRIG_OUT
  create_bd_pin -dir I clkb
  create_bd_pin -dir O -from 1 -to 0 dout
  create_bd_pin -dir I pps
  create_bd_pin -dir I -from 0 -to 0 rstb
  create_bd_pin -dir I -type clk s00_axi_aclk
  create_bd_pin -dir I -from 0 -to 0 -type rst s00_axi_aresetn

  # Create instance: axi_bram_ctrl_6, and set properties
  set axi_bram_ctrl_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_6 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_6

  # Create instance: axi_bram_ctrl_7, and set properties
  set axi_bram_ctrl_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_7 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_7

  # Create instance: axi_bram_ctrl_8, and set properties
  set axi_bram_ctrl_8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_8 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_8

  # Create instance: axi_bram_ctrl_9, and set properties
  set axi_bram_ctrl_9 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_9 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_9

  # Create instance: axi_bram_ctrl_10, and set properties
  set axi_bram_ctrl_10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_10 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_10

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list CONFIG.NUM_MI {5}  ] $axi_interconnect_0

  # Create instance: blk_mem_gen_5, and set properties
  set blk_mem_gen_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_5 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true} CONFIG.Write_Depth_A {8192}  ] $blk_mem_gen_5

  # Create instance: blk_mem_gen_6, and set properties
  set blk_mem_gen_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_6 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true} CONFIG.Write_Depth_A {8192}  ] $blk_mem_gen_6

  # Create instance: blk_mem_gen_7, and set properties
  set blk_mem_gen_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_7 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true} CONFIG.Write_Depth_A {8192}  ] $blk_mem_gen_7

  # Create instance: blk_mem_gen_8, and set properties
  set blk_mem_gen_8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_8 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true} CONFIG.Write_Depth_A {8192}  ] $blk_mem_gen_8

  # Create instance: blk_mem_gen_9, and set properties
  set blk_mem_gen_9 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_9 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true} CONFIG.Write_Depth_A {8192}  ] $blk_mem_gen_9

  # Create instance: sde_trigger_0, and set properties
  set sde_trigger_0 [ create_bd_cell -type ip -vlnv auger.mtu.edu:user:sde_trigger:1.2 sde_trigger_0 ]

  # Create instance: time_tagging_0, and set properties
  set time_tagging_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:time_tagging:1.0 time_tagging_0 ]

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins S00_AXI2] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_bram_ctrl_6_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_6/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_5/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_bram_ctrl_6_BRAM_PORTA1 [get_bd_intf_pins axi_bram_ctrl_8/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_7/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_bram_ctrl_7_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_7/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_6/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_bram_ctrl_7_BRAM_PORTA1 [get_bd_intf_pins axi_bram_ctrl_9/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_8/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_bram_ctrl_7_BRAM_PORTA2 [get_bd_intf_pins axi_bram_ctrl_10/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_9/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_bram_ctrl_6/S_AXI] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_bram_ctrl_7/S_AXI] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins axi_bram_ctrl_8/S_AXI] [get_bd_intf_pins axi_interconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins axi_bram_ctrl_9/S_AXI] [get_bd_intf_pins axi_interconnect_0/M03_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M04_AXI [get_bd_intf_pins axi_bram_ctrl_10/S_AXI] [get_bd_intf_pins axi_interconnect_0/M04_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M10_AXI [get_bd_intf_pins S00_AXI1] [get_bd_intf_pins time_tagging_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M11_AXI [get_bd_intf_pins S00_AXI] [get_bd_intf_pins sde_trigger_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M12_AXI [get_bd_intf_pins S_AXI_INTR] [get_bd_intf_pins sde_trigger_0/S_AXI_INTR]

  # Create port connections
  connect_bd_net -net GPS_PPS_1 [get_bd_pins pps] [get_bd_pins time_tagging_0/pps]
  connect_bd_net -net In_regional_ck_0_IBUF_OUT [get_bd_pins clkb] [get_bd_pins blk_mem_gen_5/clkb] [get_bd_pins blk_mem_gen_6/clkb] [get_bd_pins blk_mem_gen_7/clkb] [get_bd_pins blk_mem_gen_8/clkb] [get_bd_pins blk_mem_gen_9/clkb] [get_bd_pins sde_trigger_0/CLK120] [get_bd_pins time_tagging_0/clk_120m]
  connect_bd_net -net WP1_ADC_Control_0_ADC_data [get_bd_pins ADC] [get_bd_pins sde_trigger_0/ADC]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins s00_axi_aclk] [get_bd_pins axi_bram_ctrl_10/s_axi_aclk] [get_bd_pins axi_bram_ctrl_6/s_axi_aclk] [get_bd_pins axi_bram_ctrl_7/s_axi_aclk] [get_bd_pins axi_bram_ctrl_8/s_axi_aclk] [get_bd_pins axi_bram_ctrl_9/s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_0/M03_ACLK] [get_bd_pins axi_interconnect_0/M04_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins sde_trigger_0/s00_axi_aclk] [get_bd_pins sde_trigger_0/s_axi_intr_aclk] [get_bd_pins time_tagging_0/s00_axi_aclk]
  connect_bd_net -net rst_processing_system7_0_97M_peripheral_aresetn [get_bd_pins s00_axi_aresetn] [get_bd_pins axi_bram_ctrl_10/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_6/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_7/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_8/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_9/s_axi_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_0/M03_ARESETN] [get_bd_pins axi_interconnect_0/M04_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins sde_trigger_0/s00_axi_aresetn] [get_bd_pins sde_trigger_0/s_axi_intr_aresetn] [get_bd_pins time_tagging_0/s00_axi_aresetn]
  connect_bd_net -net rst_processing_system7_0_97M_peripheral_reset [get_bd_pins rstb] [get_bd_pins blk_mem_gen_5/rstb] [get_bd_pins blk_mem_gen_6/rstb] [get_bd_pins blk_mem_gen_7/rstb] [get_bd_pins blk_mem_gen_8/rstb] [get_bd_pins blk_mem_gen_9/rstb]
  connect_bd_net -net sde_trigger_0_DEAD [get_bd_pins sde_trigger_0/DEAD] [get_bd_pins time_tagging_0/dead]
  connect_bd_net -net sde_trigger_0_MUON_ADDR [get_bd_pins blk_mem_gen_9/addrb] [get_bd_pins sde_trigger_0/MUON_ADDR]
  connect_bd_net -net sde_trigger_0_MUON_BUF_RNUM [get_bd_pins sde_trigger_0/MUON_BUF_RNUM] [get_bd_pins time_tagging_0/address_rmb]
  connect_bd_net -net sde_trigger_0_MUON_BUF_WNUM [get_bd_pins sde_trigger_0/MUON_BUF_WNUM] [get_bd_pins time_tagging_0/address_wmb]
  connect_bd_net -net sde_trigger_0_MUON_DATA0 [get_bd_pins blk_mem_gen_9/dinb] [get_bd_pins sde_trigger_0/MUON_DATA0]
  connect_bd_net -net sde_trigger_0_MUON_ENB [get_bd_pins blk_mem_gen_9/enb] [get_bd_pins sde_trigger_0/MUON_ENB]
  connect_bd_net -net sde_trigger_0_MUON_TRIGGER [get_bd_pins sde_trigger_0/MUON_TRIGGER] [get_bd_pins time_tagging_0/evtclks]
  connect_bd_net -net sde_trigger_0_SHWR_ADDR [get_bd_pins blk_mem_gen_5/addrb] [get_bd_pins blk_mem_gen_6/addrb] [get_bd_pins blk_mem_gen_7/addrb] [get_bd_pins blk_mem_gen_8/addrb] [get_bd_pins sde_trigger_0/SHWR_ADDR]
  connect_bd_net -net sde_trigger_0_SHWR_BUF_RNUM [get_bd_pins sde_trigger_0/SHWR_BUF_RNUM] [get_bd_pins time_tagging_0/address_rsb]
  connect_bd_net -net sde_trigger_0_SHWR_BUF_WNUM [get_bd_pins sde_trigger_0/SHWR_BUF_WNUM] [get_bd_pins time_tagging_0/address_wsb]
  connect_bd_net -net sde_trigger_0_SHWR_DATA0 [get_bd_pins blk_mem_gen_5/dinb] [get_bd_pins sde_trigger_0/SHWR_DATA0]
  connect_bd_net -net sde_trigger_0_SHWR_DATA1 [get_bd_pins blk_mem_gen_6/dinb] [get_bd_pins sde_trigger_0/SHWR_DATA1]
  connect_bd_net -net sde_trigger_0_SHWR_DATA2 [get_bd_pins blk_mem_gen_7/dinb] [get_bd_pins sde_trigger_0/SHWR_DATA2]
  connect_bd_net -net sde_trigger_0_SHWR_DATA3 [get_bd_pins blk_mem_gen_8/dinb] [get_bd_pins sde_trigger_0/SHWR_DATA3]
  connect_bd_net -net sde_trigger_0_SHWR_EVT_CTR [get_bd_pins sde_trigger_0/SHWR_EVT_CTR] [get_bd_pins time_tagging_0/evtcnt]
  connect_bd_net -net sde_trigger_0_SHWR_TRIGGER [get_bd_pins sde_trigger_0/SHWR_TRIGGER] [get_bd_pins time_tagging_0/evtclkf]
  connect_bd_net -net sde_trigger_0_TRIG_OUT [get_bd_pins TRIG_OUT] [get_bd_pins sde_trigger_0/TRIG_OUT]
  connect_bd_net -net sde_trigger_0_WEB [get_bd_pins blk_mem_gen_5/web] [get_bd_pins blk_mem_gen_6/web] [get_bd_pins blk_mem_gen_7/web] [get_bd_pins blk_mem_gen_8/web] [get_bd_pins blk_mem_gen_9/web] [get_bd_pins sde_trigger_0/WEB]
  connect_bd_net -net sde_trigger_0_irq [get_bd_pins sde_trigger_0/irq] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins dout] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconcat_0/In0] [get_bd_pins xlconstant_0/dout]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: WP5_data_blok
proc create_hier_cell_WP5_data_blok { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_WP5_data_blok() - Empty argument(s)!"
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  # Create pins
  create_bd_pin -dir I -from 12 -to 0 IBUF_0_N
  create_bd_pin -dir I -from 12 -to 0 IBUF_0_P
  create_bd_pin -dir I -from 12 -to 0 IBUF_1_N
  create_bd_pin -dir I -from 12 -to 0 IBUF_1_P
  create_bd_pin -dir I -from 12 -to 0 IBUF_2_N
  create_bd_pin -dir I -from 12 -to 0 IBUF_2_P
  create_bd_pin -dir I -from 12 -to 0 IBUF_3_N
  create_bd_pin -dir I -from 12 -to 0 IBUF_3_P
  create_bd_pin -dir I -from 12 -to 0 IBUF_4_N
  create_bd_pin -dir I -from 12 -to 0 IBUF_4_P
  create_bd_pin -dir I IBUF_DS_N
  create_bd_pin -dir I -from 0 -to 0 IBUF_DS_N1
  create_bd_pin -dir I -from 0 -to 0 IBUF_DS_N2
  create_bd_pin -dir I -from 0 -to 0 IBUF_DS_N3
  create_bd_pin -dir I -from 0 -to 0 IBUF_DS_N4
  create_bd_pin -dir I -from 0 -to 0 IBUF_DS_N5
  create_bd_pin -dir I IBUF_DS_P
  create_bd_pin -dir I -from 0 -to 0 IBUF_DS_P1
  create_bd_pin -dir I -from 0 -to 0 IBUF_DS_P2
  create_bd_pin -dir I -from 0 -to 0 IBUF_DS_P3
  create_bd_pin -dir I -from 0 -to 0 IBUF_DS_P4
  create_bd_pin -dir I -from 0 -to 0 IBUF_DS_P5
  create_bd_pin -dir O -from 0 -to 0 IBUF_OUT
  create_bd_pin -dir O IBUF_OUT1
  create_bd_pin -dir O -from 0 -to 0 IBUF_OUT2
  create_bd_pin -dir O -from 0 -to 0 IBUF_OUT3
  create_bd_pin -dir O -from 0 -to 0 IBUF_OUT4
  create_bd_pin -dir O -from 0 -to 0 IBUF_OUT5
  create_bd_pin -dir I REF_CLOCK
  create_bd_pin -dir O -from 25 -to 0 -type data data_in_to_device
  create_bd_pin -dir O -from 25 -to 0 -type data data_in_to_device1
  create_bd_pin -dir O -from 25 -to 0 -type data data_in_to_device2
  create_bd_pin -dir O -from 25 -to 0 -type data data_in_to_device3
  create_bd_pin -dir O -from 25 -to 0 -type data data_in_to_device4
  create_bd_pin -dir I -from 0 -to 0 -type rst io_reset
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -from 0 -to 0 -type rst s_axi_aresetn

  # Create instance: In_regional_ck_0, and set properties
  set In_regional_ck_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:In_regional_ck:1.0 In_regional_ck_0 ]

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_0 ]

  # Create instance: axi_bram_ctrl_0_bram, and set properties
  set axi_bram_ctrl_0_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 axi_bram_ctrl_0_bram ]
  set_property -dict [ list CONFIG.Memory_Type {True_Dual_Port_RAM}  ] $axi_bram_ctrl_0_bram

  # Create instance: delay_input_0, and set properties
  set delay_input_0 [ create_bd_cell -type ip -vlnv in2p3.fr:user:delay_input:1.0 delay_input_0 ]

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
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]

  # Create port connections
  connect_bd_net -net ADC0_CK_N_1 [get_bd_pins IBUF_DS_N2] [get_bd_pins util_ds_buf_3/IBUF_DS_N]
  connect_bd_net -net ADC0_CK_P_1 [get_bd_pins IBUF_DS_P2] [get_bd_pins util_ds_buf_3/IBUF_DS_P]
  connect_bd_net -net ADC1_CK_N_1 [get_bd_pins IBUF_DS_N1] [get_bd_pins util_ds_buf_4/IBUF_DS_N]
  connect_bd_net -net ADC1_CK_P_1 [get_bd_pins IBUF_DS_P1] [get_bd_pins util_ds_buf_4/IBUF_DS_P]
  connect_bd_net -net ADC2_CK_N_1 [get_bd_pins IBUF_DS_N3] [get_bd_pins util_ds_buf_5/IBUF_DS_N]
  connect_bd_net -net ADC2_CK_P_1 [get_bd_pins IBUF_DS_P3] [get_bd_pins util_ds_buf_5/IBUF_DS_P]
  connect_bd_net -net ADC3_CK_N_1 [get_bd_pins IBUF_DS_N4] [get_bd_pins util_ds_buf_6/IBUF_DS_N]
  connect_bd_net -net ADC3_CK_P_1 [get_bd_pins IBUF_DS_P4] [get_bd_pins util_ds_buf_6/IBUF_DS_P]
  connect_bd_net -net ADC4_CK_N_1 [get_bd_pins IBUF_DS_N5] [get_bd_pins util_ds_buf_7/IBUF_DS_N]
  connect_bd_net -net ADC4_CK_P_1 [get_bd_pins IBUF_DS_P5] [get_bd_pins util_ds_buf_7/IBUF_DS_P]
  connect_bd_net -net FPGA_CK_N_1 [get_bd_pins IBUF_DS_N] [get_bd_pins In_regional_ck_0/IBUF_DS_N]
  connect_bd_net -net FPGA_CK_P_1 [get_bd_pins IBUF_DS_P] [get_bd_pins In_regional_ck_0/IBUF_DS_P]
  connect_bd_net -net In_regional_ck_0_IBUF_OUT [get_bd_pins IBUF_OUT1] [get_bd_pins In_regional_ck_0/IBUF_OUT] [get_bd_pins selectio_wiz_0/clk_in] [get_bd_pins selectio_wiz_1/clk_in] [get_bd_pins selectio_wiz_2/clk_in] [get_bd_pins selectio_wiz_3/clk_in] [get_bd_pins selectio_wiz_4/clk_in]
  connect_bd_net -net adc0_n_1 [get_bd_pins IBUF_0_N] [get_bd_pins delay_input_0/IBUF_0_N]
  connect_bd_net -net adc0_p_1 [get_bd_pins IBUF_0_P] [get_bd_pins delay_input_0/IBUF_0_P]
  connect_bd_net -net adc1_n_1 [get_bd_pins IBUF_1_N] [get_bd_pins delay_input_0/IBUF_1_N]
  connect_bd_net -net adc1_p_1 [get_bd_pins IBUF_1_P] [get_bd_pins delay_input_0/IBUF_1_P]
  connect_bd_net -net adc2_n_1 [get_bd_pins IBUF_2_N] [get_bd_pins delay_input_0/IBUF_2_N]
  connect_bd_net -net adc2_p_1 [get_bd_pins IBUF_2_P] [get_bd_pins delay_input_0/IBUF_2_P]
  connect_bd_net -net adc3_n_1 [get_bd_pins IBUF_3_N] [get_bd_pins delay_input_0/IBUF_3_N]
  connect_bd_net -net adc3_p_1 [get_bd_pins IBUF_3_P] [get_bd_pins delay_input_0/IBUF_3_P]
  connect_bd_net -net adc4_n_1 [get_bd_pins IBUF_4_N] [get_bd_pins delay_input_0/IBUF_4_N]
  connect_bd_net -net adc4_p_1 [get_bd_pins IBUF_4_P] [get_bd_pins delay_input_0/IBUF_4_P]
  connect_bd_net -net delay_input_0_DDELAY_0 [get_bd_pins delay_input_0/DDELAY_0] [get_bd_pins selectio_wiz_0/data_in_from_pins]
  connect_bd_net -net delay_input_0_DDELAY_1 [get_bd_pins delay_input_0/DDELAY_1] [get_bd_pins selectio_wiz_1/data_in_from_pins]
  connect_bd_net -net delay_input_0_DDELAY_2 [get_bd_pins delay_input_0/DDELAY_2] [get_bd_pins selectio_wiz_2/data_in_from_pins]
  connect_bd_net -net delay_input_0_DDELAY_3 [get_bd_pins delay_input_0/DDELAY_3] [get_bd_pins selectio_wiz_3/data_in_from_pins]
  connect_bd_net -net delay_input_0_DDELAY_4 [get_bd_pins delay_input_0/DDELAY_4] [get_bd_pins selectio_wiz_4/data_in_from_pins]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins s_axi_aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins REF_CLOCK] [get_bd_pins delay_input_0/REF_CLOCK]
  connect_bd_net -net rst_processing_system7_0_97M_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn]
  connect_bd_net -net rst_processing_system7_0_97M_peripheral_reset [get_bd_pins io_reset] [get_bd_pins delay_input_0/IO_RESET] [get_bd_pins selectio_wiz_0/io_reset] [get_bd_pins selectio_wiz_1/io_reset] [get_bd_pins selectio_wiz_2/io_reset] [get_bd_pins selectio_wiz_3/io_reset] [get_bd_pins selectio_wiz_4/io_reset]
  connect_bd_net -net selectio_wiz_0_data_in_to_device [get_bd_pins data_in_to_device] [get_bd_pins selectio_wiz_0/data_in_to_device]
  connect_bd_net -net selectio_wiz_1_data_in_to_device [get_bd_pins data_in_to_device1] [get_bd_pins selectio_wiz_1/data_in_to_device]
  connect_bd_net -net selectio_wiz_2_data_in_to_device [get_bd_pins data_in_to_device2] [get_bd_pins selectio_wiz_2/data_in_to_device]
  connect_bd_net -net selectio_wiz_3_data_in_to_device [get_bd_pins data_in_to_device3] [get_bd_pins selectio_wiz_3/data_in_to_device]
  connect_bd_net -net selectio_wiz_4_data_in_to_device [get_bd_pins data_in_to_device4] [get_bd_pins selectio_wiz_4/data_in_to_device]
  connect_bd_net -net util_ds_buf_3_IBUF_OUT [get_bd_pins IBUF_OUT] [get_bd_pins util_ds_buf_3/IBUF_OUT]
  connect_bd_net -net util_ds_buf_4_IBUF_OUT [get_bd_pins IBUF_OUT2] [get_bd_pins util_ds_buf_4/IBUF_OUT]
  connect_bd_net -net util_ds_buf_5_IBUF_OUT [get_bd_pins IBUF_OUT3] [get_bd_pins util_ds_buf_5/IBUF_OUT]
  connect_bd_net -net util_ds_buf_6_IBUF_OUT [get_bd_pins IBUF_OUT4] [get_bd_pins util_ds_buf_6/IBUF_OUT]
  connect_bd_net -net util_ds_buf_7_IBUF_OUT [get_bd_pins IBUF_OUT5] [get_bd_pins util_ds_buf_7/IBUF_OUT]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: WP1_ADC_CONTROL
proc create_hier_cell_WP1_ADC_CONTROL { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_WP1_ADC_CONTROL() - Empty argument(s)!"
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI1
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI2
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI3
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI4
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI5
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI6

  # Create pins
  create_bd_pin -dir O -from 119 -to 0 ADC_data
  create_bd_pin -dir O ASY_TRIG
  create_bd_pin -dir O ENABLE_PPS
  create_bd_pin -dir I EXT_TRIG
  create_bd_pin -dir I FPGA_CK
  create_bd_pin -dir I -from 25 -to 0 adc0
  create_bd_pin -dir I -from 25 -to 0 adc1
  create_bd_pin -dir I -from 25 -to 0 adc2
  create_bd_pin -dir I -from 25 -to 0 adc3
  create_bd_pin -dir I -from 25 -to 0 adc4
  create_bd_pin -dir O -from 31 -to 0 gpio2_io_o
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -from 0 -to 0 -type rst s_axi_aresetn

  # Create instance: WP1_ADC_Control_0, and set properties
  set WP1_ADC_Control_0 [ create_bd_cell -type ip -vlnv elettronica.le.infn.it:user:WP1_ADC_Control:1.1 WP1_ADC_Control_0 ]

  # Create instance: axi_bram_ctrl_1, and set properties
  set axi_bram_ctrl_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_1 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_1

  # Create instance: axi_bram_ctrl_2, and set properties
  set axi_bram_ctrl_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_2 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_2

  # Create instance: axi_bram_ctrl_3, and set properties
  set axi_bram_ctrl_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_3 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_3

  # Create instance: axi_bram_ctrl_4, and set properties
  set axi_bram_ctrl_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_4 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_4

  # Create instance: axi_bram_ctrl_5, and set properties
  set axi_bram_ctrl_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_5 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_5

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS_2 {0} CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_ALL_OUTPUTS_2 {1} CONFIG.C_GPIO2_WIDTH {32} CONFIG.C_GPIO_WIDTH {8} CONFIG.C_IS_DUAL {1}  ] $axi_gpio_0

  # Create instance: axi_gpio_1, and set properties
  set axi_gpio_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_1 ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {1} CONFIG.C_GPIO_WIDTH {16}  ] $axi_gpio_1

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_0 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true}  ] $blk_mem_gen_0

  # Create instance: blk_mem_gen_1, and set properties
  set blk_mem_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_1 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true}  ] $blk_mem_gen_1

  # Create instance: blk_mem_gen_2, and set properties
  set blk_mem_gen_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_2 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true}  ] $blk_mem_gen_2

  # Create instance: blk_mem_gen_3, and set properties
  set blk_mem_gen_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_3 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true}  ] $blk_mem_gen_3

  # Create instance: blk_mem_gen_4, and set properties
  set blk_mem_gen_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_4 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true}  ] $blk_mem_gen_4

  # Create interface connections
  connect_bd_intf_net -intf_net axi_bram_ctrl_1_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_1/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_bram_ctrl_2_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_2/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_1/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_bram_ctrl_3_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_3/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_2/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_bram_ctrl_4_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_4/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_3/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_bram_ctrl_5_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_5/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_4/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_mem_intercon_M03_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_bram_ctrl_1/S_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M04_AXI [get_bd_intf_pins S_AXI1] [get_bd_intf_pins axi_bram_ctrl_2/S_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M05_AXI [get_bd_intf_pins S_AXI2] [get_bd_intf_pins axi_bram_ctrl_3/S_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M06_AXI [get_bd_intf_pins S_AXI3] [get_bd_intf_pins axi_bram_ctrl_4/S_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M07_AXI [get_bd_intf_pins S_AXI4] [get_bd_intf_pins axi_bram_ctrl_5/S_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M08_AXI [get_bd_intf_pins S_AXI5] [get_bd_intf_pins axi_gpio_0/S_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M09_AXI [get_bd_intf_pins S_AXI6] [get_bd_intf_pins axi_gpio_1/S_AXI]

  # Create port connections
  connect_bd_net -net ADC_interface_0_ADDR_mem [get_bd_pins WP1_ADC_Control_0/ADDR_mem] [get_bd_pins blk_mem_gen_0/addra] [get_bd_pins blk_mem_gen_1/addra] [get_bd_pins blk_mem_gen_2/addra] [get_bd_pins blk_mem_gen_3/addra] [get_bd_pins blk_mem_gen_4/addra]
  connect_bd_net -net ADC_interface_0_enable [get_bd_pins WP1_ADC_Control_0/enable] [get_bd_pins blk_mem_gen_0/ena] [get_bd_pins blk_mem_gen_1/ena] [get_bd_pins blk_mem_gen_2/ena] [get_bd_pins blk_mem_gen_3/ena] [get_bd_pins blk_mem_gen_4/ena]
  connect_bd_net -net ADC_interface_0_wea [get_bd_pins WP1_ADC_Control_0/wea] [get_bd_pins blk_mem_gen_0/wea] [get_bd_pins blk_mem_gen_1/wea] [get_bd_pins blk_mem_gen_2/wea] [get_bd_pins blk_mem_gen_3/wea] [get_bd_pins blk_mem_gen_4/wea]
  connect_bd_net -net In_regional_ck_0_IBUF_OUT [get_bd_pins FPGA_CK] [get_bd_pins WP1_ADC_Control_0/FPGA_CK]
  connect_bd_net -net TRIG_IN_1 [get_bd_pins EXT_TRIG] [get_bd_pins WP1_ADC_Control_0/EXT_TRIG]
  connect_bd_net -net WP1_ADC_Control_0_ADC0_mem [get_bd_pins WP1_ADC_Control_0/ADC0_mem] [get_bd_pins blk_mem_gen_0/dina]
  connect_bd_net -net WP1_ADC_Control_0_ADC1_mem [get_bd_pins WP1_ADC_Control_0/ADC1_mem] [get_bd_pins blk_mem_gen_1/dina]
  connect_bd_net -net WP1_ADC_Control_0_ADC2_mem [get_bd_pins WP1_ADC_Control_0/ADC2_mem] [get_bd_pins blk_mem_gen_2/dina]
  connect_bd_net -net WP1_ADC_Control_0_ADC3_mem [get_bd_pins WP1_ADC_Control_0/ADC3_mem] [get_bd_pins blk_mem_gen_3/dina]
  connect_bd_net -net WP1_ADC_Control_0_ADC4_mem [get_bd_pins WP1_ADC_Control_0/ADC4_mem] [get_bd_pins blk_mem_gen_4/dina]
  connect_bd_net -net WP1_ADC_Control_0_ADC_data [get_bd_pins ADC_data] [get_bd_pins WP1_ADC_Control_0/ADC_data]
  connect_bd_net -net WP1_ADC_Control_0_ASY_TRIG [get_bd_pins ASY_TRIG] [get_bd_pins WP1_ADC_Control_0/ASY_TRIG]
  connect_bd_net -net WP1_ADC_Control_0_BRAM_CK [get_bd_pins WP1_ADC_Control_0/BRAM_CK] [get_bd_pins blk_mem_gen_0/clka] [get_bd_pins blk_mem_gen_1/clka] [get_bd_pins blk_mem_gen_2/clka] [get_bd_pins blk_mem_gen_3/clka] [get_bd_pins blk_mem_gen_4/clka]
  connect_bd_net -net WP1_ADC_Control_0_ENABLE_PPS [get_bd_pins ENABLE_PPS] [get_bd_pins WP1_ADC_Control_0/ENABLE_PPS]
  connect_bd_net -net WP1_ADC_Control_0_Stop_Addr [get_bd_pins WP1_ADC_Control_0/Stop_Addr] [get_bd_pins axi_gpio_1/gpio_io_i]
  connect_bd_net -net axi_gpio_0_gpio2_io_o [get_bd_pins gpio2_io_o] [get_bd_pins axi_gpio_0/gpio2_io_o]
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins WP1_ADC_Control_0/Config_Trig] [get_bd_pins axi_gpio_0/gpio_io_o]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins s_axi_aclk] [get_bd_pins axi_bram_ctrl_1/s_axi_aclk] [get_bd_pins axi_bram_ctrl_2/s_axi_aclk] [get_bd_pins axi_bram_ctrl_3/s_axi_aclk] [get_bd_pins axi_bram_ctrl_4/s_axi_aclk] [get_bd_pins axi_bram_ctrl_5/s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_gpio_1/s_axi_aclk]
  connect_bd_net -net rst_processing_system7_0_97M_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins WP1_ADC_Control_0/RSTn] [get_bd_pins axi_bram_ctrl_1/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_2/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_3/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_4/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_5/s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_gpio_1/s_axi_aresetn] [get_bd_pins blk_mem_gen_0/rsta] [get_bd_pins blk_mem_gen_1/rsta] [get_bd_pins blk_mem_gen_2/rsta] [get_bd_pins blk_mem_gen_3/rsta] [get_bd_pins blk_mem_gen_4/rsta]
  connect_bd_net -net selectio_wiz_0_data_in_to_device [get_bd_pins adc0] [get_bd_pins WP1_ADC_Control_0/adc0]
  connect_bd_net -net selectio_wiz_1_data_in_to_device [get_bd_pins adc1] [get_bd_pins WP1_ADC_Control_0/adc1]
  connect_bd_net -net selectio_wiz_2_data_in_to_device [get_bd_pins adc2] [get_bd_pins WP1_ADC_Control_0/adc2]
  connect_bd_net -net selectio_wiz_3_data_in_to_device [get_bd_pins adc3] [get_bd_pins WP1_ADC_Control_0/adc3]
  connect_bd_net -net selectio_wiz_4_data_in_to_device [get_bd_pins adc4] [get_bd_pins WP1_ADC_Control_0/adc4]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}


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
  set LED_ASY [ create_bd_port -dir O -from 0 -to 0 LED_ASY ]
  set LED_FLG [ create_bd_port -dir I LED_FLG ]
  set RADIO_CTS [ create_bd_port -dir I RADIO_CTS ]
  set RADIO_RST_IN [ create_bd_port -dir I RADIO_RST_IN ]
  set RADIO_RST_OUT [ create_bd_port -dir O RADIO_RST_OUT ]
  set RADIO_RTS [ create_bd_port -dir O RADIO_RTS ]
  set TP [ create_bd_port -dir O -from 6 -to 2 TP ]
  set TRIG_IN [ create_bd_port -dir I TRIG_IN ]
  set TRIG_OUT [ create_bd_port -dir O -from 0 -to 0 TRIG_OUT ]
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

  # Create instance: Interface_uub_0, and set properties
  set Interface_uub_0 [ create_bd_cell -type ip -vlnv Lpsc.in2p3.fr:user:Interface_uub:2.00 Interface_uub_0 ]

  # Create instance: WP1_ADC_CONTROL
  create_hier_cell_WP1_ADC_CONTROL [current_bd_instance .] WP1_ADC_CONTROL

  # Create instance: WP1_LED_Control_0, and set properties
  set WP1_LED_Control_0 [ create_bd_cell -type ip -vlnv elettronica.le.infn.it:user:WP1_LED_Control:1.0 WP1_LED_Control_0 ]

  # Create instance: WP5_data_blok
  create_hier_cell_WP5_data_blok [current_bd_instance .] WP5_data_blok

  # Create instance: Wp2_Trigger_block
  create_hier_cell_Wp2_Trigger_block [current_bd_instance .] Wp2_Trigger_block

  # Create instance: ZYNC_block
  create_hier_cell_ZYNC_block [current_bd_instance .] ZYNC_block

  # Create instance: clock_1pps_0, and set properties
  set clock_1pps_0 [ create_bd_cell -type ip -vlnv auger.org:dfnitz:clock_1pps:1.0 clock_1pps_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins Wp2_Trigger_block/S00_AXI2] [get_bd_intf_pins ZYNC_block/M13_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins WP5_data_blok/S_AXI] [get_bd_intf_pins ZYNC_block/M00_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M01_AXI [get_bd_intf_pins Interface_uub_0/S00_AXI] [get_bd_intf_pins ZYNC_block/M01_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M03_AXI [get_bd_intf_pins WP1_ADC_CONTROL/S_AXI] [get_bd_intf_pins ZYNC_block/M03_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M04_AXI [get_bd_intf_pins WP1_ADC_CONTROL/S_AXI1] [get_bd_intf_pins ZYNC_block/M04_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M05_AXI [get_bd_intf_pins WP1_ADC_CONTROL/S_AXI2] [get_bd_intf_pins ZYNC_block/M05_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M06_AXI [get_bd_intf_pins WP1_ADC_CONTROL/S_AXI3] [get_bd_intf_pins ZYNC_block/M06_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M07_AXI [get_bd_intf_pins WP1_ADC_CONTROL/S_AXI4] [get_bd_intf_pins ZYNC_block/M07_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M08_AXI [get_bd_intf_pins WP1_ADC_CONTROL/S_AXI5] [get_bd_intf_pins ZYNC_block/M08_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M09_AXI [get_bd_intf_pins WP1_ADC_CONTROL/S_AXI6] [get_bd_intf_pins ZYNC_block/M09_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M10_AXI [get_bd_intf_pins Wp2_Trigger_block/S00_AXI1] [get_bd_intf_pins ZYNC_block/M10_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M11_AXI [get_bd_intf_pins Wp2_Trigger_block/S00_AXI] [get_bd_intf_pins ZYNC_block/M11_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M12_AXI [get_bd_intf_pins Wp2_Trigger_block/S_AXI_INTR] [get_bd_intf_pins ZYNC_block/M12_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins ZYNC_block/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins ZYNC_block/FIXED_IO]

  # Create port connections
  connect_bd_net -net ADC0_CK_N_1 [get_bd_ports ADC0_CK_N] [get_bd_pins WP5_data_blok/IBUF_DS_N2]
  connect_bd_net -net ADC0_CK_P_1 [get_bd_ports ADC0_CK_P] [get_bd_pins WP5_data_blok/IBUF_DS_P2]
  connect_bd_net -net ADC1_CK_N_1 [get_bd_ports ADC1_CK_N] [get_bd_pins WP5_data_blok/IBUF_DS_N1]
  connect_bd_net -net ADC1_CK_P_1 [get_bd_ports ADC1_CK_P] [get_bd_pins WP5_data_blok/IBUF_DS_P1]
  connect_bd_net -net ADC2_CK_N_1 [get_bd_ports ADC2_CK_N] [get_bd_pins WP5_data_blok/IBUF_DS_N3]
  connect_bd_net -net ADC2_CK_P_1 [get_bd_ports ADC2_CK_P] [get_bd_pins WP5_data_blok/IBUF_DS_P3]
  connect_bd_net -net ADC3_CK_N_1 [get_bd_ports ADC3_CK_N] [get_bd_pins WP5_data_blok/IBUF_DS_N4]
  connect_bd_net -net ADC3_CK_P_1 [get_bd_ports ADC3_CK_P] [get_bd_pins WP5_data_blok/IBUF_DS_P4]
  connect_bd_net -net ADC4_CK_N_1 [get_bd_ports ADC4_CK_N] [get_bd_pins WP5_data_blok/IBUF_DS_N5]
  connect_bd_net -net ADC4_CK_P_1 [get_bd_ports ADC4_CK_P] [get_bd_pins WP5_data_blok/IBUF_DS_P5]
  connect_bd_net -net FPGA_CK_N_1 [get_bd_ports FPGA_CK_N] [get_bd_pins WP5_data_blok/IBUF_DS_N]
  connect_bd_net -net FPGA_CK_P_1 [get_bd_ports FPGA_CK_P] [get_bd_pins WP5_data_blok/IBUF_DS_P]
  connect_bd_net -net GPS_PPS_1 [get_bd_pins Interface_uub_0/GPS_PPS] [get_bd_pins WP1_LED_Control_0/PPS] [get_bd_pins Wp2_Trigger_block/pps] [get_bd_pins clock_1pps_0/CLK1PPS]
  connect_bd_net -net In_regional_ck_0_IBUF_OUT [get_bd_pins Interface_uub_0/FPGA_CK] [get_bd_pins WP1_ADC_CONTROL/FPGA_CK] [get_bd_pins WP1_LED_Control_0/clock] [get_bd_pins WP5_data_blok/IBUF_OUT1] [get_bd_pins Wp2_Trigger_block/clkb] [get_bd_pins clock_1pps_0/CLK120]
  connect_bd_net -net Interface_uub_0_RADIO_RST_OUT [get_bd_ports RADIO_RST_OUT] [get_bd_pins Interface_uub_0/RADIO_RST_OUT]
  connect_bd_net -net Interface_uub_0_ec0_out [get_bd_ports ext0_ctl] [get_bd_pins Interface_uub_0/ext0_ctl]
  connect_bd_net -net Interface_uub_0_ec1_out [get_bd_ports ext1_ctl] [get_bd_pins Interface_uub_0/ext1_ctl]
  connect_bd_net -net Interface_uub_0_tp [get_bd_ports TP] [get_bd_pins Interface_uub_0/tp]
  connect_bd_net -net RADIO_RST_IN_1 [get_bd_ports RADIO_RST_IN] [get_bd_pins Interface_uub_0/RADIO_RST_IN]
  connect_bd_net -net TRIG_IN_1 [get_bd_ports TRIG_IN] [get_bd_pins Interface_uub_0/TRIG_IN] [get_bd_pins WP1_ADC_CONTROL/EXT_TRIG]
  connect_bd_net -net USB_IFAULT_1 [get_bd_ports USB_IFAULT] [get_bd_pins Interface_uub_0/USB_IFAULT]
  connect_bd_net -net WATCHDOG_1 [get_bd_ports WATCHDOG] [get_bd_pins Interface_uub_0/WATCHDOG]
  connect_bd_net -net WP1_ADC_CONTROL_ENABLE_PPS [get_bd_pins WP1_ADC_CONTROL/ENABLE_PPS] [get_bd_pins WP1_LED_Control_0/ENABLE_PPS]
  connect_bd_net -net WP1_ADC_CONTROL_gpio2_io_o [get_bd_pins WP1_ADC_CONTROL/gpio2_io_o] [get_bd_pins WP1_LED_Control_0/data_set]
  connect_bd_net -net WP1_ADC_Control_0_ADC_data [get_bd_pins WP1_ADC_CONTROL/ADC_data] [get_bd_pins Wp2_Trigger_block/ADC]
  connect_bd_net -net WP1_ADC_Control_0_ASY_TRIG [get_bd_pins WP1_ADC_CONTROL/ASY_TRIG] [get_bd_pins WP1_LED_Control_0/ASY_TRIG]
  connect_bd_net -net WP1_LED_Control_0_LED_OUT [get_bd_ports LED_ASY] [get_bd_pins Interface_uub_0/LED_FLG] [get_bd_pins WP1_LED_Control_0/LED_OUT]
  connect_bd_net -net Wp2_Trigger_block_TRIG_OUT [get_bd_ports TRIG_OUT] [get_bd_pins Wp2_Trigger_block/TRIG_OUT]
  connect_bd_net -net adc0_n_1 [get_bd_ports adc0_n] [get_bd_pins WP5_data_blok/IBUF_0_N]
  connect_bd_net -net adc0_p_1 [get_bd_ports adc0_p] [get_bd_pins WP5_data_blok/IBUF_0_P]
  connect_bd_net -net adc1_n_1 [get_bd_ports adc1_n] [get_bd_pins WP5_data_blok/IBUF_1_N]
  connect_bd_net -net adc1_p_1 [get_bd_ports adc1_p] [get_bd_pins WP5_data_blok/IBUF_1_P]
  connect_bd_net -net adc2_n_1 [get_bd_ports adc2_n] [get_bd_pins WP5_data_blok/IBUF_2_N]
  connect_bd_net -net adc2_p_1 [get_bd_ports adc2_p] [get_bd_pins WP5_data_blok/IBUF_2_P]
  connect_bd_net -net adc3_n_1 [get_bd_ports adc3_n] [get_bd_pins WP5_data_blok/IBUF_3_N]
  connect_bd_net -net adc3_p_1 [get_bd_ports adc3_p] [get_bd_pins WP5_data_blok/IBUF_3_P]
  connect_bd_net -net adc4_n_1 [get_bd_ports adc4_n] [get_bd_pins WP5_data_blok/IBUF_4_N]
  connect_bd_net -net adc4_p_1 [get_bd_ports adc4_p] [get_bd_pins WP5_data_blok/IBUF_4_P]
  connect_bd_net -net axi_uartlite_0_tx [get_bd_ports GPS_TX] [get_bd_pins ZYNC_block/tx]
  connect_bd_net -net ec0_in_1 [get_bd_ports ext0_dat] [get_bd_pins Interface_uub_0/ext0_dat]
  connect_bd_net -net ec1_in_1 [get_bd_ports ext1_dat] [get_bd_pins Interface_uub_0/ext1_dat]
  connect_bd_net -net hconf_1 [get_bd_ports hconf] [get_bd_pins Interface_uub_0/hconf]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins Interface_uub_0/s00_axi_aclk] [get_bd_pins WP1_ADC_CONTROL/s_axi_aclk] [get_bd_pins WP5_data_blok/s_axi_aclk] [get_bd_pins Wp2_Trigger_block/s00_axi_aclk] [get_bd_pins ZYNC_block/FCLK_CLK0]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins WP5_data_blok/REF_CLOCK] [get_bd_pins ZYNC_block/FCLK_CLK1]
  connect_bd_net -net rst_processing_system7_0_97M_peripheral_aresetn [get_bd_pins Interface_uub_0/s00_axi_aresetn] [get_bd_pins WP1_ADC_CONTROL/s_axi_aresetn] [get_bd_pins WP1_LED_Control_0/reset] [get_bd_pins WP5_data_blok/s_axi_aresetn] [get_bd_pins Wp2_Trigger_block/s00_axi_aresetn] [get_bd_pins ZYNC_block/s_axi_aresetn]
  connect_bd_net -net rst_processing_system7_0_97M_peripheral_reset [get_bd_pins WP5_data_blok/io_reset] [get_bd_pins Wp2_Trigger_block/rstb] [get_bd_pins ZYNC_block/peripheral_reset]
  connect_bd_net -net rx_1 [get_bd_ports GPS_RX] [get_bd_pins ZYNC_block/rx]
  connect_bd_net -net selectio_wiz_0_data_in_to_device [get_bd_pins Interface_uub_0/adc0] [get_bd_pins WP1_ADC_CONTROL/adc0] [get_bd_pins WP5_data_blok/data_in_to_device]
  connect_bd_net -net selectio_wiz_1_data_in_to_device [get_bd_pins Interface_uub_0/adc1] [get_bd_pins WP1_ADC_CONTROL/adc1] [get_bd_pins WP5_data_blok/data_in_to_device1]
  connect_bd_net -net selectio_wiz_2_data_in_to_device [get_bd_pins Interface_uub_0/adc2] [get_bd_pins WP1_ADC_CONTROL/adc2] [get_bd_pins WP5_data_blok/data_in_to_device2]
  connect_bd_net -net selectio_wiz_3_data_in_to_device [get_bd_pins Interface_uub_0/adc3] [get_bd_pins WP1_ADC_CONTROL/adc3] [get_bd_pins WP5_data_blok/data_in_to_device3]
  connect_bd_net -net selectio_wiz_4_data_in_to_device [get_bd_pins Interface_uub_0/adc4] [get_bd_pins WP1_ADC_CONTROL/adc4] [get_bd_pins WP5_data_blok/data_in_to_device4]
  connect_bd_net -net util_ds_buf_3_IBUF_OUT [get_bd_pins Interface_uub_0/ADC0_CK] [get_bd_pins WP5_data_blok/IBUF_OUT]
  connect_bd_net -net util_ds_buf_4_IBUF_OUT [get_bd_pins Interface_uub_0/ADC1_CK] [get_bd_pins WP5_data_blok/IBUF_OUT2]
  connect_bd_net -net util_ds_buf_5_IBUF_OUT [get_bd_pins Interface_uub_0/ADC2_CK] [get_bd_pins WP5_data_blok/IBUF_OUT3]
  connect_bd_net -net util_ds_buf_6_IBUF_OUT [get_bd_pins Interface_uub_0/ADC3_CK] [get_bd_pins WP5_data_blok/IBUF_OUT4]
  connect_bd_net -net util_ds_buf_7_IBUF_OUT [get_bd_pins Interface_uub_0/ADC4_CK] [get_bd_pins WP5_data_blok/IBUF_OUT5]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins Wp2_Trigger_block/dout] [get_bd_pins ZYNC_block/IRQ_F2P]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs Interface_uub_0/S00_AXI/S00_AXI_reg] SEG_Interface_uub_0_S00_AXI_reg
  create_bd_addr_seg -range 0x2000 -offset 0x40000000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs WP5_data_blok/axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x8000 -offset 0x54000000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs Wp2_Trigger_block/axi_bram_ctrl_10/S_AXI/Mem0] SEG_axi_bram_ctrl_10_Mem0
  create_bd_addr_seg -range 0x4000 -offset 0x42000000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs WP1_ADC_CONTROL/axi_bram_ctrl_1/S_AXI/Mem0] SEG_axi_bram_ctrl_1_Mem0
  create_bd_addr_seg -range 0x4000 -offset 0x44000000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs WP1_ADC_CONTROL/axi_bram_ctrl_2/S_AXI/Mem0] SEG_axi_bram_ctrl_2_Mem0
  create_bd_addr_seg -range 0x4000 -offset 0x46000000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs WP1_ADC_CONTROL/axi_bram_ctrl_3/S_AXI/Mem0] SEG_axi_bram_ctrl_3_Mem0
  create_bd_addr_seg -range 0x4000 -offset 0x48000000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs WP1_ADC_CONTROL/axi_bram_ctrl_4/S_AXI/Mem0] SEG_axi_bram_ctrl_4_Mem0
  create_bd_addr_seg -range 0x4000 -offset 0x4A000000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs WP1_ADC_CONTROL/axi_bram_ctrl_5/S_AXI/Mem0] SEG_axi_bram_ctrl_5_Mem0
  create_bd_addr_seg -range 0x8000 -offset 0x4C000000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs Wp2_Trigger_block/axi_bram_ctrl_6/S_AXI/Mem0] SEG_axi_bram_ctrl_6_Mem0
  create_bd_addr_seg -range 0x8000 -offset 0x4E000000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs Wp2_Trigger_block/axi_bram_ctrl_7/S_AXI/Mem0] SEG_axi_bram_ctrl_7_Mem0
  create_bd_addr_seg -range 0x8000 -offset 0x50000000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs Wp2_Trigger_block/axi_bram_ctrl_8/S_AXI/Mem0] SEG_axi_bram_ctrl_8_Mem0
  create_bd_addr_seg -range 0x8000 -offset 0x52000000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs Wp2_Trigger_block/axi_bram_ctrl_9/S_AXI/Mem0] SEG_axi_bram_ctrl_9_Mem0
  create_bd_addr_seg -range 0x1000 -offset 0x41200000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs WP1_ADC_CONTROL/axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x1000 -offset 0x41210000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs WP1_ADC_CONTROL/axi_gpio_1/S_AXI/Reg] SEG_axi_gpio_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x42C00000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs ZYNC_block/axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C20000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs Wp2_Trigger_block/sde_trigger_0/S00_AXI/S00_AXI_reg] SEG_sde_trigger_0_S00_AXI_reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C30000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs Wp2_Trigger_block/sde_trigger_0/S_AXI_INTR/S_AXI_INTR_reg] SEG_sde_trigger_0_S_AXI_INTR_reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces ZYNC_block/processing_system7_0/Data] [get_bd_addr_segs Wp2_Trigger_block/time_tagging_0/S00_AXI/S00_AXI_reg] SEG_time_tagging_0_S00_AXI_reg
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


