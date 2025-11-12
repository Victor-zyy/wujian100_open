#Copyright (c) 2019 Alibaba Group Holding Limited
#
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#===========================================================
# MicroPhase A7_Lite Board
# Xilinx Artix-7 XC7A200T-FGG484-1
# Pin assignment constraint file
#===========================================================

#===========================================
# set io standard
#===========================================
set_property IOSTANDARD LVCMOS33 [get_ports]


#===========================================
# Create clock (Use PLL-50MHz 20Mhz)
#===========================================
#create_clock  -period 50.00 -name MAIN_CLK [get_ports PIN_EHS]

#===========================================
# Global clock and reset source
#===========================================
create_clock  -name {EHS} [get_ports PIN_EHS] -period 20 -waveform {0 10}
create_clock  -name {JTAG_CLK} [get_ports PAD_JTAG_TCLK] -period 1000 -waveform {0 500}

set_clock_groups -asynchronous -name {clkgroup_1} -group [get_clocks {EHS JTAG_CLK}]

#set_false_path -through [get_ports PIN_EHS]

set_property ASYNC_REG TRUE [get_cells {x_aou_top/x_rtc0_sec_top/x_rtc_pdu_top/x_rtc_clr_sync/pclk_load_sync2_reg}]
set_property ASYNC_REG TRUE [get_cells {x_aou_top/x_rtc0_sec_top/x_rtc_pdu_top/x_rtc_clr_sync/rtc_load_sync2_reg}]
set_property ASYNC_REG TRUE [get_cells {x_aou_top/x_rtc0_sec_top/x_rtc_pdu_top/x_rtc_clr_sync/pclk_load_sync1_reg}]
set_property ASYNC_REG TRUE [get_cells {x_aou_top/x_rtc0_sec_top/x_rtc_pdu_top/x_rtc_clr_sync/rtc_load_sync1_reg}]
set_property ASYNC_REG TRUE [get_cells {x_cpu_top/CPU/x_cr_had_top/A15d/A74/A10b_reg}]
set_property ASYNC_REG TRUE [get_cells {x_cpu_top/CPU/x_cr_had_top/A15d/A74/A18597_reg}]
set_property ASYNC_REG TRUE [get_cells {x_cpu_top/CPU/x_cr_had_top/A15d/A1862d/A10b_reg}]
set_property ASYNC_REG TRUE [get_cells {x_cpu_top/CPU/x_cr_had_top/A15d/A1862d/A18597_reg}]
set_property ASYNC_REG TRUE [get_cells {x_cpu_top/CPU/x_cr_had_top/A15d/A75/A10b_reg}]
set_property ASYNC_REG TRUE [get_cells {x_cpu_top/CPU/x_cr_had_top/A15d/A75/A18597_reg}]

set_property PACKAGE_PIN J19 [get_ports PIN_EHS]

# Constrain PLL Option

set_false_path -from [get_pins x_e902_pll/inst/mmcm_adv_inst/CLKOUT0] -to [get_pins x_cpu_top/CPU/x_cr_tcipif_top/x_cr_coretim_top/refclk_ff1_reg/D]
set_property PACKAGE_PIN L18 [get_ports PAD_MCURST]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets PAD_JTAG_TCLK]

#===========================================
# C-SKY  JTAG interface: J8
#===========================================
set_property PACKAGE_PIN W21 [get_ports PAD_JTAG_TCLK]
set_property PACKAGE_PIN W22 [get_ports PAD_JTAG_TMS]
#set_property PULLTYPE KEEPER [get_ports PAD_JTAG_TMS]
#set_property PACKAGE_PIN V13  [get_ports JTAG_TDI]
#set_property PACKAGE_PIN V14  [get_ports JTAG_TDO]
#set_property PACKAGE_PIN W15  [get_ports i_pad_jtg_trst_b]
#set_property PACKAGE_PIN AB15  [get_ports JTAG_NRST]

#===========================================
# From GPIO2
#===========================================

set_property PACKAGE_PIN T21 [get_ports PAD_GPIO_4]
set_property PACKAGE_PIN U21 [get_ports PAD_GPIO_5]
set_property PACKAGE_PIN U22 [get_ports PAD_GPIO_6]
set_property PACKAGE_PIN V22 [get_ports PAD_GPIO_7]
set_property PACKAGE_PIN Y21 [get_ports PAD_GPIO_8]
set_property PACKAGE_PIN Y22 [get_ports PAD_GPIO_9]
set_property PACKAGE_PIN AA20 [get_ports PAD_GPIO_10]
set_property PACKAGE_PIN AA21 [get_ports PAD_GPIO_11]
set_property PACKAGE_PIN AB21 [get_ports PAD_GPIO_12]
set_property PACKAGE_PIN AB22 [get_ports PAD_GPIO_13]
set_property PACKAGE_PIN AA19 [get_ports PAD_GPIO_14]
set_property PACKAGE_PIN AB20 [get_ports PAD_GPIO_15]
set_property PACKAGE_PIN U20 [get_ports PAD_GPIO_16]
set_property PACKAGE_PIN V20 [get_ports PAD_GPIO_17]
set_property PACKAGE_PIN Y18 [get_ports PAD_GPIO_18]
set_property PACKAGE_PIN Y19 [get_ports PAD_GPIO_19]
set_property PACKAGE_PIN W19 [get_ports PAD_GPIO_20]
set_property PACKAGE_PIN W20 [get_ports PAD_GPIO_21]
set_property PACKAGE_PIN AA18 [get_ports PAD_GPIO_22]
set_property PACKAGE_PIN AB18 [get_ports PAD_GPIO_23]

set_property PACKAGE_PIN V18 [get_ports PAD_GPIO_24]
set_property PACKAGE_PIN V19 [get_ports PAD_GPIO_25]
set_property PACKAGE_PIN V17 [get_ports PAD_GPIO_26]
set_property PACKAGE_PIN W17 [get_ports PAD_GPIO_27]
set_property PACKAGE_PIN U17 [get_ports PAD_GPIO_28]
set_property PACKAGE_PIN U18 [get_ports PAD_GPIO_29]
set_property PACKAGE_PIN P14 [get_ports PAD_GPIO_30]
set_property PACKAGE_PIN R14 [get_ports PAD_GPIO_31]

# Until GPIO2_17P

#===========================================
# YOC GPIO1 Start
#===========================================
set_property PACKAGE_PIN F13 [get_ports PAD_PWM_CH0]
set_property PACKAGE_PIN F14 [get_ports PAD_PWM_CH1]
set_property PACKAGE_PIN E13 [get_ports PAD_PWM_CH2]
set_property PACKAGE_PIN E14 [get_ports PAD_PWM_CH3]
set_property PACKAGE_PIN D14 [get_ports PAD_PWM_CH4]
set_property PACKAGE_PIN D15 [get_ports PAD_PWM_CH5]
set_property PACKAGE_PIN E16 [get_ports PAD_PWM_CH6]
set_property PACKAGE_PIN D16 [get_ports PAD_PWM_CH7]
set_property PACKAGE_PIN D17 [get_ports PAD_PWM_CH8]
set_property PACKAGE_PIN C13 [get_ports PAD_PWM_CH9]
set_property PACKAGE_PIN B13 [get_ports PAD_PWM_CH10]
set_property PACKAGE_PIN A13 [get_ports PAD_PWM_CH11]
set_property PACKAGE_PIN A14 [get_ports PAD_PWM_FAULT]
# Until GPIO6_N



# USI0 -- UART0

set_property PACKAGE_PIN C14 [get_ports PAD_USI0_NSS]
set_property PACKAGE_PIN U2 [get_ports PAD_USI0_SCLK]
set_property PACKAGE_PIN V2 [get_ports PAD_USI0_SD0]
set_property PACKAGE_PIN C15 [get_ports PAD_USI0_SD1]

set_property PACKAGE_PIN A15 [get_ports PAD_USI1_NSS]
set_property PACKAGE_PIN A16 [get_ports PAD_USI1_SCLK]
set_property PACKAGE_PIN B15 [get_ports PAD_USI1_SD0]
set_property PACKAGE_PIN B16 [get_ports PAD_USI1_SD1]
set_property PACKAGE_PIN F16 [get_ports PAD_USI2_NSS]
set_property PACKAGE_PIN E17 [get_ports PAD_USI2_SCLK]
set_property PACKAGE_PIN A18 [get_ports PAD_USI2_SD0]
set_property PACKAGE_PIN A19 [get_ports PAD_USI2_SD1]


#===========================================
# RGB LED and SWITCH
#===========================================
set_property PACKAGE_PIN M18 [get_ports PAD_GPIO_0]
set_property PACKAGE_PIN N18 [get_ports PAD_GPIO_1]
set_property PACKAGE_PIN AA1 [get_ports PAD_GPIO_2]
set_property PACKAGE_PIN W1 [get_ports PAD_GPIO_3]

#===========================================
# FPGA configuration properties
#===========================================
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

#set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN  DIV-2  [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

