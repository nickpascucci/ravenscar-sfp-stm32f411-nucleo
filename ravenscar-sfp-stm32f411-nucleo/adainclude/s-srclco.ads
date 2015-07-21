------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--          Copyright (C) 2012-2013, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  This file provides register definitions for the STM32F4 (ARM Cortex M4F)
--  microcontrollers from ST Microelectronics.
with Interfaces;

package System.STM32F4.Reset_Clock_Control is

   --  Constants
   RCC_Base   : constant := AHB1_Peripheral_Base + 16#3800#;

   --  Definition for clock control register
   type Clock_Control_Register is
      record
         PLLI2S_Ready_Flag : Boolean;
         PLLI2S_Enable : Boolean;
         PLL_Ready_Flag : Boolean;
         PLL_Enable : Boolean;
         Security_System_Enable : Boolean;
         HSE_Bypass : Boolean;
         HSE_Ready_Flag : Boolean;
         HSE_Enable : Boolean;
         HSI_Calibration : Interfaces.Unsigned_8;
         HSI_Trim : Bits_5;
         HSI_Ready_Flag : Boolean;
         HSI_Enable : Boolean;
      end record with Size => Bits_32'Size;
   for Clock_Control_Register use
      record
         HSI_Enable at 0 range 0 .. 0;
         HSI_Ready_Flag at 0 range 1 .. 1;
         HSI_Trim at 0 range 3 .. 7;
         HSI_Calibration at 0 range 8 .. 15;
         HSE_Enable at 0 range 16 .. 16;
         HSE_Ready_Flag at 0 range 17 .. 17;
         HSE_Bypass at 0 range 18 .. 18;
         Security_System_Enable at 0 range 19 .. 19;
         PLL_Enable at 0 range 24 .. 24;
         PLL_Ready_Flag at 0 range 25 .. 25;
         PLLI2S_Enable at 0 range 26 .. 26;
         PLLI2S_Ready_Flag at 0 range 27 .. 27;
      end record;

   --  Definitions for PLL configuration register
   type Division_Factor_For_Input_Clock is range 2 .. 63 with Size => 6;
   type Multiplication_Factor is range 2 .. 432 with Size => 9;

   type Division_Factor_For_Main_Clock is (PLLP_2, PLLP_4, PLLP_6, PLLP_8)
   with Size => 2;
   for Division_Factor_For_Main_Clock use (PLLP_2 => 2#00#,
                                           PLLP_4 => 2#01#,
                                           PLLP_6 => 2#10#,
                                           PLLP_8 => 2#11#);

   type Entry_Clock_Source is (HSI, HSE) with Size => 1;
   for Entry_Clock_Source use (HSI => 0,
                               HSE => 1);

   type Division_Factor_For_USB_Clock is range 2 .. 15 with Size => 4;

   type PLL_Configuration_Register is
      record
         Division_Factor_For_Input : Division_Factor_For_Input_Clock;
         Multiplication_Factor_For_Main : Multiplication_Factor;
         Division_Factor_For_Main : Division_Factor_For_Main_Clock;
         Clock_Source : Entry_Clock_Source;
         Division_Factor_For_USB : Division_Factor_For_USB_Clock;
      end record with Size => Bits_32'Size;
   for PLL_Configuration_Register use
      record
         Division_Factor_For_Input at 0 range 0 .. 5;
         Multiplication_Factor_For_Main at 0 range 6 .. 14;
         Division_Factor_For_Main at 0 range 16 .. 17;
         Clock_Source at 0 range 22 .. 22;
         Division_Factor_For_USB at 0 range 24 .. 27;
      end record;

   --  Definitions for the clock configuration register
   type MCO1_Clock is (HSI, LSE, HSE, PLL) with Size => 2;
   for MCO1_Clock use (HSI => 2#00#,
                  LSE => 2#01#,
                  HSE => 2#10#,
                  PLL => 2#11#);

   type System_Clock is (HSI,
                         HSE,
                         PLL) with Size => 2;
   for System_Clock use (HSI => 2#00#,
                         HSE => 2#01#,
                         PLL => 2#10#);

   type MCO2_Clock is (SYSCLK,
                       PLLI2S,
                       HSE,
                       PLL) with Size => 2;
   for MCO2_Clock use (SYSCLK => 2#00#,
                       PLLI2S => 2#01#,
                       HSE => 2#10#,
                       PLL => 2#11#);

   type AHB_Clock_Division_Factor is (NOT_DIVIDED,
                                      DIVIDED_BY_2,
                                      DIVIDED_BY_4,
                                      DIVIDED_BY_8,
                                      DIVIDED_BY_16,
                                      DIVIDED_BY_64,
                                      DIVIDED_BY_128,
                                      DIVIDED_BY_256,
                                      DIVIDED_BY_512) with Size => 4;
   for AHB_Clock_Division_Factor use (NOT_DIVIDED => 2#0000#,
                                      DIVIDED_BY_2 => 2#1000#,
                                      DIVIDED_BY_4 => 2#1001#,
                                      DIVIDED_BY_8 => 2#1010#,
                                      DIVIDED_BY_16 => 2#1011#,
                                      DIVIDED_BY_64 => 2#1100#,
                                      DIVIDED_BY_128 => 2#1101#,
                                      DIVIDED_BY_256 => 2#1110#,
                                      DIVIDED_BY_512 => 2#1111#);

   type APB_Clock_Division_Factor is (NOT_DIVIDED,
                                      DIVIDED_BY_2,
                                      DIVIDED_BY_4,
                                      DIVIDED_BY_8,
                                      DIVIDED_BY_16) with Size => 3;
   for APB_Clock_Division_Factor use (NOT_DIVIDED => 2#000#,
                                      DIVIDED_BY_2 => 2#100#,
                                      DIVIDED_BY_4 => 2#101#,
                                      DIVIDED_BY_8 => 2#110#,
                                      DIVIDED_BY_16 => 2#111#);

   type RTC_Division_Factor is range 0 .. 31 with Size => 5;

   type I2S_Clock_Selection is (PLLI2S, EXTERNAL_CLOCK) with Size => 1;
   for I2S_Clock_Selection use (PLLI2S => 0,
                                EXTERNAL_CLOCK => 1);

   type MCO_Prescaler is (NOT_DIVIDED,
                          DIVIDED_BY_2,
                          DIVIDED_BY_3,
                          DIVIDED_BY_4,
                          DIVIDED_BY_5) with Size => 3;
   for MCO_Prescaler use (NOT_DIVIDED => 2#000#,
                           DIVIDED_BY_2 => 2#100#,
                           DIVIDED_BY_3 => 2#101#,
                           DIVIDED_BY_4 => 2#110#,
                           DIVIDED_BY_5 => 2#111#);

   type Clock_Configuration_Register is
      record
         System_Clock_Switch : System_Clock;
         System_Clock_Status : System_Clock;
         AHB_Prescaler_Factor : AHB_Clock_Division_Factor;
         APB_Low_Speed_Prescaler_Factor : APB_Clock_Division_Factor;
         APB_High_Speed_Prescaler_Factor : APB_Clock_Division_Factor;
         HSE_Division_Factor : RTC_Division_Factor;
         Microcontroller_Clock_Output_1 : MCO1_Clock;
         I2S_Clock : I2S_Clock_Selection;
         MCO1_Prescaler : MCO_Prescaler;
         MCO2_Prescaler : MCO_Prescaler;
         Microcontroller_Clock_Output_2 : MCO2_Clock;
      end record with Size => 32;
   for Clock_Configuration_Register use
      record
         System_Clock_Switch at 0 range 0 .. 1;
         System_Clock_Status at 0 range 2 .. 3;
         AHB_Prescaler_Factor at 0 range 4 .. 7;
         APB_Low_Speed_Prescaler_Factor at 0 range 10 .. 12;
         APB_High_Speed_Prescaler_Factor at 0 range 13 .. 15;
         HSE_Division_Factor at 0 range 16 .. 20;
         Microcontroller_Clock_Output_1 at 0 range 21 .. 22;
         I2S_Clock at 0 range 23 .. 23;
         MCO1_Prescaler at 0 range 24 .. 26;
         MCO2_Prescaler at 0 range 27 .. 29;
         Microcontroller_Clock_Output_2 at 0 range 30 .. 31;
      end record;

   type Clock_Interrupt_Register is
      record
         LSI_Ready_Flag : Boolean;
         LSE_Ready_Flag : Boolean;
         HSI_Ready_Flag : Boolean;
         HSE_Ready_Flag : Boolean;
         PLL_Ready_Flag : Boolean;
         PLLI2S_Ready_Flag : Boolean;
         Security_Interrupt_Flag : Boolean;
         LSI_Interrupt_Enable : Boolean;
         LSE_Interrupt_Enable : Boolean;
         HSI_Interrupt_Enable : Boolean;
         HSE_Interrupt_Enable : Boolean;
         PLL_Interrupt_Enable : Boolean;
         PLLI2S_Interrupt_Enable : Boolean;
         LSI_Interrupt_Clear : Boolean;
         LSE_Interrupt_Clear : Boolean;
         HSI_Interrupt_Clear : Boolean;
         HSE_Interrupt_Clear : Boolean;
         PLL_Interrupt_Clear : Boolean;
         PLLI2S_Interrupt_Clear : Boolean;
         Security_Interrupt_Clear : Boolean;
      end record with Size => 32;
   for Clock_Interrupt_Register use
      record
         LSI_Ready_Flag at 0 range 0 .. 0;
         LSE_Ready_Flag at 0 range 1 .. 1;
         HSI_Ready_Flag at 0 range 2 .. 2;
         HSE_Ready_Flag at 0 range 3 .. 3;
         PLL_Ready_Flag at 0 range 4 .. 4;
         PLLI2S_Ready_Flag at 0 range 5 .. 5;
         Security_Interrupt_Flag at 0 range 7 .. 7;
         LSI_Interrupt_Enable at 0 range 8 .. 8;
         LSE_Interrupt_Enable at 0 range 9 .. 9;
         HSI_Interrupt_Enable at 0 range 10 .. 10;
         HSE_Interrupt_Enable at 0 range 11 .. 11;
         PLL_Interrupt_Enable at 0 range 12 .. 12;
         PLLI2S_Interrupt_Enable at 0 range 13 .. 13;
         LSI_Interrupt_Clear at 0 range 16 .. 16;
         LSE_Interrupt_Clear at 0 range 17 .. 17;
         HSI_Interrupt_Clear at 0 range 18 .. 18;
         HSE_Interrupt_Clear at 0 range 19 .. 19;
         PLL_Interrupt_Clear at 0 range 20 .. 20;
         PLLI2S_Interrupt_Clear at 0 range 21 .. 21;
         Security_Interrupt_Clear at 0 range 23 .. 23;
      end record;

   type AHB1_Reset_Register is
      record
         GPIOA_Reset : Boolean;
         GPIOB_Reset : Boolean;
         GPIOC_Reset : Boolean;
         GPIOD_Reset : Boolean;
         GPIOE_Reset : Boolean;
         GPIOH_Reset : Boolean;
         CRC_Reset : Boolean;
         DMA1_Reset : Boolean;
         DMA2_Reset : Boolean;
      end record with Size => 32;
   for AHB1_Reset_Register use
      record
         GPIOA_Reset at 0 range 0 .. 0;
         GPIOB_Reset at 0 range 1 .. 1;
         GPIOC_Reset at 0 range 2 .. 2;
         GPIOD_Reset at 0 range 3 .. 3;
         GPIOE_Reset at 0 range 4 .. 4;
         GPIOH_Reset at 0 range 7 .. 7;
         CRC_Reset at 0 range 12 .. 12;
         DMA1_Reset at 0 range 21 .. 21;
         DMA2_Reset at 0 range 22 .. 22;
      end record;

   type AHB2_Reset_Register is
      record
         OTGFS_Reset : Boolean;
      end record with Size => 32;
   for AHB2_Reset_Register use
      record
         OTGFS_Reset at 0 range 7 .. 7;
      end record;

   type APB1_Reset_Register is
      record
         TIM2_Reset : Boolean;
         TIM3_Reset : Boolean;
         TIM4_Reset : Boolean;
         TIM5_Reset : Boolean;
         Window_Watchdog_Reset : Boolean;
         SPI2_Reset : Boolean;
         SPI3_Reset : Boolean;
         USART2_Reset : Boolean;
         I2C1_Reset : Boolean;
         I2C2_Reset : Boolean;
         I2C3_Reset : Boolean;
         Power_Interface_Reset : Boolean;
      end record with Size => 32;
   for APB1_Reset_Register use
      record
         TIM2_Reset at 0 range 0 .. 0;
         TIM3_Reset at 0 range 1 .. 1;
         TIM4_Reset at 0 range 2 .. 2;
         TIM5_Reset at 0 range 3 .. 3;
         Window_Watchdog_Reset at 0 range 11 .. 11;
         SPI2_Reset at 0 range 14 .. 14;
         SPI3_Reset at 0 range 15 .. 15;
         USART2_Reset at 0 range 17 .. 17;
         I2C1_Reset at 0 range 21 .. 21;
         I2C2_Reset at 0 range 22 .. 22;
         I2C3_Reset at 0 range 23 .. 23;
         Power_Interface_Reset at 0 range 28 .. 28;
      end record;

   type APB2_Reset_Register is
      record
         TIM1_Reset : Boolean;
         USART1_Reset : Boolean;
         USART6_Reset : Boolean;
         ADC1_Reset : Boolean;
         SDIO_Reset : Boolean;
         SPI1_Reset : Boolean;
         SPI4_Reset : Boolean;
         Sys_Config_Reset : Boolean;
         TIM9_Reset : Boolean;
         TIM10_Reset : Boolean;
         TIM11_Reset : Boolean;
         SPI5_Reset : Boolean;
      end record with Size => 32;
   for APB2_Reset_Register use
      record
         TIM1_Reset at 0 range 0 .. 0;
         USART1_Reset at 0 range 4 .. 4;
         USART6_Reset at 0 range 5 .. 5;
         ADC1_Reset at 0 range 8 .. 8;
         SDIO_Reset at 0 range 11 .. 11;
         SPI1_Reset at 0 range 12 .. 12;
         SPI4_Reset at 0 range 13 .. 13;
         Sys_Config_Reset at 0 range 14 .. 14;
         TIM9_Reset at 0 range 16 .. 16;
         TIM10_Reset at 0 range 17 .. 17;
         TIM11_Reset at 0 range 18 .. 18;
         SPI5_Reset at 0 range 20 .. 20;
      end record;

   type AHB1_Clock_Enable_Register is
      record
         GPIOA_clock_Enable : Boolean;
         GPIOB_clock_Enable : Boolean;
         GPIOC_clock_Enable : Boolean;
         GPIOD_clock_Enable : Boolean;
         GPIOE_clock_Enable : Boolean;
         GPIOH_clock_Enable : Boolean;
         CRC_Clock_Enable : Boolean;
         DMA1_Clock_Enable : Boolean;
         DMA2_Clock_Enable : Boolean;
      end record with Size => 32;
   for AHB1_Clock_Enable_Register use
      record
         GPIOA_clock_Enable at 0 range 0 .. 0;
         GPIOB_clock_Enable at 0 range 1 .. 1;
         GPIOC_clock_Enable at 0 range 2 .. 2;
         GPIOD_clock_Enable at 0 range 3 .. 3;
         GPIOE_clock_Enable at 0 range 4 .. 4;
         GPIOH_clock_Enable at 0 range 7 .. 7;
         CRC_Clock_Enable at 0 range 12 .. 12;
         DMA1_Clock_Enable at 0 range 21 .. 21;
         DMA2_Clock_Enable at 0 range 22 .. 22;
      end record;

   type AHB2_Clock_Enable_Register is
      record
         OTGFS_Clock_Enable : Boolean;
      end record with size => 32;
   for AHB2_Clock_Enable_Register use
      record
         OTGFS_Clock_Enable at 0 range 7 .. 7;
      end record;

   type APB1_Clock_Enable_Register is
      record
         TIM2_Clock_Enable : Boolean;
         TIM3_Clock_Enable : Boolean;
         TIM4_Clock_Enable : Boolean;
         TIM5_Clock_Enable : Boolean;
         Window_Watchdog_Clock_Enable : Boolean;
         SPI2_Clock_Enable : Boolean;
         SPI3_Clock_Enable : Boolean;
         USART2_Clock_Enable : Boolean;
         I2C1_Clock_Enable : Boolean;
         I2C2_Clock_Enable : Boolean;
         I2C3_Clock_Enable : Boolean;
         Power_Interface_Clock_Enable : Boolean;
      end record with Size => 32;
   for APB1_Clock_Enable_Register use
      record
         TIM2_Clock_Enable at 0 range 0 .. 0;
         TIM3_Clock_Enable at 0 range 1 .. 1;
         TIM4_Clock_Enable at 0 range 2 .. 2;
         TIM5_Clock_Enable at 0 range 3 .. 3;
         Window_Watchdog_Clock_Enable at 0 range 11 .. 11;
         SPI2_Clock_Enable at 0 range 14 .. 14;
         SPI3_Clock_Enable at 0 range 15 .. 15;
         USART2_Clock_Enable at 0 range 17 .. 17;
         I2C1_Clock_Enable at 0 range 21 .. 21;
         I2C2_Clock_Enable at 0 range 22 .. 22;
         I2C3_Clock_Enable at 0 range 23 .. 23;
         Power_Interface_Clock_Enable at 0 range 28 .. 28;
      end record;

   type APB2_Clock_Enable_Register is
      record
         TIM1_Clock_Enable : Boolean;
         USART1_Clock_Enable : Boolean;
         USART6_Clock_Enable : Boolean;
         ADC1_Clock_Enable : Boolean;
         SDIO_Clock_Enable : Boolean;
         SPI1_Clock_Enable : Boolean;
         SPI4_Clock_Enable : Boolean;
         Sys_Config_Clock_Enable : Boolean;
         TIM9_Clock_Enable : Boolean;
         TIM10_Clock_Enable : Boolean;
         TIM11_Clock_Enable : Boolean;
         SPI5_Clock_Enable : Boolean;
      end record with Size => 32;
   for APB2_Clock_Enable_Register use
      record
         TIM1_Clock_Enable at 0 range 0 .. 0;
         USART1_Clock_Enable at 0 range 4 .. 4;
         USART6_Clock_Enable at 0 range 5 .. 5;
         ADC1_Clock_Enable at 0 range 8 .. 8;
         SDIO_Clock_Enable at 0 range 11 .. 11;
         SPI1_Clock_Enable at 0 range 12 .. 12;
         SPI4_Clock_Enable at 0 range 13 .. 13;
         Sys_Config_Clock_Enable at 0 range 14 .. 14;
         TIM9_Clock_Enable at 0 range 16 .. 16;
         TIM10_Clock_Enable at 0 range 17 .. 17;
         TIM11_Clock_Enable at 0 range 18 .. 18;
         SPI5_Clock_Enable at 0 range 20 .. 20;
      end record;

   type AHB1_Clock_Enable_Low_Power_Register is
      record
         GPIOA_Clock_Enable : Boolean;
         GPIOB_Clock_Enable : Boolean;
         GPIOC_Clock_Enable : Boolean;
         GPIOD_Clock_Enable : Boolean;
         GPIOE_Clock_Enable : Boolean;
         GPIOH_Clock_Enable : Boolean;
         CRC_Clock_Enable : Boolean;
         Flash_Interface_Clock_Enable : Boolean;
         SRAM1_Clock_Enable : Boolean;
         DMA1_Clock_Enable : Boolean;
         DMA2_Clock_Enable : Boolean;
      end record with Size => 32;
   for AHB1_Clock_Enable_Low_Power_Register use
      record
         GPIOA_Clock_Enable at 0 range 0 .. 0;
         GPIOB_Clock_Enable at 0 range 1 .. 1;
         GPIOC_Clock_Enable at 0 range 2 .. 2;
         GPIOD_Clock_Enable at 0 range 3 .. 3;
         GPIOE_Clock_Enable at 0 range 4 .. 4;
         GPIOH_Clock_Enable at 0 range 7 .. 7;
         CRC_Clock_Enable at 0 range 12 .. 12;
         Flash_Interface_Clock_Enable at 0 range 15 .. 15;
         SRAM1_Clock_Enable at 0 range 16 .. 16;
         DMA1_Clock_Enable at 0 range 21 .. 21;
         DMA2_Clock_Enable at 0 range 22 .. 22;
      end record;

   type AHB2_Clock_Enable_Low_Power_Register is new AHB2_Clock_Enable_Register;

   type APB1_Clock_Enable_Low_Power_Register is new APB1_Clock_Enable_Register;

   type APB2_Clock_Enable_Low_Power_Register is new APB2_Clock_Enable_Register;

   type LSE_Power_Mode is (LOW_POWER, HIGH_DRIVE) with Size => 1;
   for LSE_Power_Mode use (LOW_POWER => 0,
                           HIGH_DRIVE => 1);

   type RTC_Clock_Source is (NO_CLOCK,
                                       LSE,
                                       LSI,
                                       HSE) with Size => 2;
   for RTC_Clock_Source use (NO_CLOCK => 2#00#,
                                       LSE => 2#01#,
                                       LSI => 2#10#,
                                       HSE => 2#11#);

   type Backup_Domain_Control_Register is
      record
         LSE_Enable : Boolean;
         LSE_Ready : Boolean;
         LSE_Bypass : Boolean;
         LSE_Mode : LSE_Power_Mode;
         RTC_Clock : RTC_Clock_Source;
         RTC_Clock_Enable : Boolean;
         Backup_Domain_Software_Reset : Boolean;
      end record with Size => 32;
   for Backup_Domain_Control_Register use
      record
         LSE_Enable at 0 range 0 .. 0;
         LSE_Ready at 0 range 1 .. 1;
         LSE_Bypass at 0 range 2 .. 2;
         LSE_Mode at 0 range 3 .. 3;
         RTC_Clock at 0 range 8 .. 9;
         RTC_Clock_Enable at 0 range 15 .. 15;
         Backup_Domain_Software_Reset at 0 range 16 .. 16;
      end record;

   type Clock_Control_Status_Register is
      record
         Internal_Low_Speed_Enable : Boolean;
         Internal_Low_Speed_Ready : Boolean;
         Remove_Reset_Flags : Boolean;
         BOR_Reset : Boolean;
         PIN_Reset : Boolean;
         POR_Reset : Boolean;
         Software_Reset : Boolean;
         Independant_Watchdog_Reset : Boolean;
         Window_Watchdog_Reset : Boolean;
         Low_Power_Reset : Boolean;
      end record with Size => 32;
   for Clock_Control_Status_Register use
      record
         Internal_Low_Speed_Enable at 0 range 0 .. 0;
         Internal_Low_Speed_Ready at 0 range 1 .. 1;
         Remove_Reset_Flags at 0 range 24 .. 24;
         BOR_Reset at 0 range 25 .. 25;
         PIN_Reset at 0 range 26 .. 26;
         POR_Reset at 0 range 27 .. 27;
         Software_Reset at 0 range 28 .. 28;
         Independant_Watchdog_Reset at 0 range 29 .. 29;
         Window_Watchdog_Reset at 0 range 30 .. 30;
         Low_Power_Reset at 0 range 31 .. 31;
      end record;

   type Modulation_Period is mod 2**13 with Size => 13;

   type Incrementation_Step is mod 2**15 with Size => 15;

   type Spread_Type is (CENTER_SPREAD, DOWN_SPREAD) with Size => 1;
   for Spread_Type use (CENTER_SPREAD => 0,
                        DOWN_SPREAD => 1);

   type Spread_Spectrum_Clock_Generation_Register is
      record
         MODPER : Modulation_Period;
         INCSTEP : Incrementation_Step;
         SPREADSEL : Spread_Type;
         SSCGEN : Boolean;
      end record with Size => 32;
   for Spread_Spectrum_Clock_Generation_Register use
      record
         MODPER at 0 range 0 .. 12;
         INCSTEP at 0 range 13 .. 27;
         SPREADSEL at 0 range 30 .. 30;
         SSCGEN at 0 range 31 .. 31;
      end record;

   type PLLI2S_Division_Factor is range 2 .. 63 with Size => 6;

   type PLLI2S_Multiplication_Factor is range 50 .. 432 with Size => 9;

   type PLLI2S_Division_Clocks_Factor is range 2 .. 7 with Size => 3;

   type PLLI2S_Configuration_Register is
      record
         PLLI2SM : PLLI2S_Division_Factor;
         PLLI2SN : PLLI2S_Multiplication_Factor;
         PLLI2SR : PLLI2S_Division_Clocks_Factor;
      end record with Size => 32;
   for PLLI2S_Configuration_Register use
      record
         PLLI2SM at 0 range 0 .. 5;
         PLLI2SN at 0 range 6 .. 14;
         PLLI2SR at 0 range 28 .. 30;
      end record;

   type Dedicated_Clocks_Configuration_Register is
      record
         TIMPRE : Boolean;
      end record with Size => 32;
   for Dedicated_Clocks_Configuration_Register use
      record
         TIMPRE at 0 range 24 .. 24;
      end record;

   type RCC_Registers is
      record
         RCC_CR : Clock_Control_Register;
         RCC_PLLCFGR : PLL_Configuration_Register;
         RCC_CFGR : Clock_Configuration_Register;
         RCC_CIR : Clock_Interrupt_Register;
         RCC_AHB1RSTR : AHB1_Reset_Register;
         RCC_AHB2RSTR : AHB2_Reset_Register;
         RCC_APB1RSTR : APB1_Reset_Register;
         RCC_APB2RSTR : APB2_Reset_Register;
         RCC_AHB1ENR : AHB1_Clock_Enable_Register;
         RCC_AHB2ENR : AHB2_Clock_Enable_Register;
         RCC_APB1ENR : APB1_Clock_Enable_Register;
         RCC_APB2ENR : APB2_Clock_Enable_Register;
         RCC_AHB1LPENR : AHB1_Clock_Enable_Low_Power_Register;
         RCC_AHB2LPENR : AHB2_Clock_Enable_Low_Power_Register;
         RCC_APB1LPENR : APB1_Clock_Enable_Low_Power_Register;
         RCC_APB2LPENR : APB2_Clock_Enable_Low_Power_Register;
         RCC_BDCR : Backup_Domain_Control_Register;
         RCC_CSR : Clock_Control_Status_Register;
         RCC_SSCGR : Spread_Spectrum_Clock_Generation_Register;
         RCC_PLLI2SCFGR : PLLI2S_Configuration_Register;
         RCC_DCKCFGR : Dedicated_Clocks_Configuration_Register;
      end record with Size => 35 * Bits_32'Size;
   for RCC_Registers use
      record
         RCC_CR at 0 range 0 .. 31;
         RCC_PLLCFGR at 1 * Offset_Size range 0 .. 31;
         RCC_CFGR at 2 * Offset_Size range 0 .. 31;
         RCC_CIR at 3 * Offset_Size range 0 .. 31;
         RCC_AHB1RSTR at 4 * Offset_Size range 0 .. 31;
         RCC_AHB2RSTR at 5 * Offset_Size range 0 .. 31;
         RCC_APB1RSTR at 8 * Offset_Size range 0 .. 31;
         RCC_APB2RSTR at 9 * Offset_Size range 0 .. 31;
         RCC_AHB1ENR at 12 * Offset_Size range 0 .. 31;
         RCC_AHB2ENR at 13 * Offset_Size range 0 .. 31;
         RCC_APB1ENR at 16 * Offset_Size range 0 .. 31;
         RCC_APB2ENR at 17 * Offset_Size range 0 .. 31;
         RCC_AHB1LPENR at 20 * Offset_Size range 0 .. 31;
         RCC_AHB2LPENR at 21 * Offset_Size range 0 .. 31;
         RCC_APB1LPENR at 24 * Offset_Size range 0 .. 31;
         RCC_APB2LPENR at 25 * Offset_Size range 0 .. 31;
         RCC_BDCR at 28 * Offset_Size range 0 .. 31;
         RCC_CSR at 29 * Offset_Size range 0 .. 31;
         RCC_SSCGR at 32 * Offset_Size range 0 .. 31;
         RCC_PLLI2SCFGR at 33 * Offset_Size range 0 .. 31;
         RCC_DCKCFGR at 34 * Offset_Size range 0 .. 31;
      end record;

   RCC : RCC_Registers with Volatile, Address => System'To_Address (RCC_Base);

end System.STM32F4.Reset_Clock_Control;
