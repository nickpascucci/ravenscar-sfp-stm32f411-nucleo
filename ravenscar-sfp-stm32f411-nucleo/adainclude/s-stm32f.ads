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

pragma Restrictions (No_Elaboration_Code);

with System.Storage_Elements;
with Interfaces;
package System.STM32F4 is

   subtype Address is System.Address;
   type Word is new Interfaces.Unsigned_32;

   Offset_Size : constant := Word'Size / Storage_Unit;

   type Bits_1 is mod 2**1 with Size => 1;
   type Bits_2 is mod 2**2 with Size => 2;
   type Bits_3 is mod 2**3 with Size => 3;
   type Bits_4 is mod 2**4 with Size => 4;
   type Bits_5 is mod 2**5 with Size => 5;
   type Bits_16 is mod 2**16 with Size => 16;
   type Bits_32 is mod 2**32 with Size => 32;

   type Bits_32x1 is array (0 .. 31) of Bits_1 with Pack, Size => 32;
   type Bits_16x2 is array (0 .. 15) of Bits_2 with Pack, Size => 32;
   type Bits_8x4 is array (0 ..  7) of Bits_4 with Pack, Size => 32;

   type Padding_1 is mod 2**1 with Size => 1;
   type Padding_2 is mod 2**2 with Size => 2;
   type Padding_3 is mod 2**3 with Size => 3;
   type Padding_4 is mod 2**4 with Size => 4;
   type Padding_5 is mod 2**5 with Size => 5;
   type Padding_6 is mod 2**6 with Size => 6;
   type Padding_7 is mod 2**7 with Size => 7;
   type Padding_8 is mod 2**8 with Size => 8;
   type Padding_9 is mod 2**9 with Size => 9;
   type Padding_10 is mod 2**10 with Size => 10;
   type Padding_15 is mod 2**15 with Size => 15;
   type Padding_32 is mod 2**32 with Size => 32;

   --  Define address bases for the various system components

   Peripheral_Base : constant := 16#4000_0000#;

   APB1_Peripheral_Base : constant := Peripheral_Base;
   APB2_Peripheral_Base : constant := Peripheral_Base + 16#0001_0000#;
   AHB1_Peripheral_Base : constant := Peripheral_Base + 16#0002_0000#;
   AHB2_Peripheral_Base : constant := Peripheral_Base + 16#1000_0000#;

   USB_OTG_FS_Base : constant := AHB2_Peripheral_Base + 16#0000#;

   DMA2_Base  : constant := AHB1_Peripheral_Base + 16#6400#;
   DMA1_Base  : constant := AHB1_Peripheral_Base + 16#6000#;

   RCC_Base   : constant := AHB1_Peripheral_Base + 16#3800#;
   CRC_Base   : constant := AHB1_Peripheral_Base + 16#3000#;

   --  The SPI/I2S registers share the same location, but have different
   --  purposes depending on enabled peripherals.
   SPI5_Base   : constant := APB2_Peripheral_Base + 16#5000#;
   I2S5_Base   : constant := APB2_Peripheral_Base + 16#5000#;
   TIM11_Base  : constant := APB2_Peripheral_Base + 16#4800#;
   TIM10_Base  : constant := APB2_Peripheral_Base + 16#4400#;
   TIM9_Base   : constant := APB2_Peripheral_Base + 16#4000#;
   EXTI_Base   : constant := APB2_Peripheral_Base + 16#3C00#;
   SYSCFG_Base : constant := APB2_Peripheral_Base + 16#3800#;
   SPI4_Base   : constant := APB2_Peripheral_Base + 16#3400#;
   I2S4_Base   : constant := APB2_Peripheral_Base + 16#3400#;
   SPI1_Base   : constant := APB2_Peripheral_Base + 16#3000#;
   I2S1_Base   : constant := APB2_Peripheral_Base + 16#3000#;
   SDIO_Base   : constant := APB2_Peripheral_Base + 16#2C00#;
   ADC1_Base   : constant := APB2_Peripheral_Base + 16#2000#;
   USART6_Base : constant := APB2_Peripheral_Base + 16#1400#;
   USART1_Base : constant := APB2_Peripheral_Base + 16#1000#;
   TIM1_Base   : constant := APB2_Peripheral_Base + 16#0000#;

   PWR_Base     : constant := APB1_Peripheral_Base + 16#7000#;
   I2C3_Base    : constant := APB1_Peripheral_Base + 16#5C00#;
   I2C2_Base    : constant := APB1_Peripheral_Base + 16#5800#;
   I2C1_Base    : constant := APB1_Peripheral_Base + 16#5400#;
   USART2_Base  : constant := APB1_Peripheral_Base + 16#4400#;
   I2S3ext_Base : constant := APB1_Peripheral_Base + 16#4000#;
   SPI3_Base    : constant := APB1_Peripheral_Base + 16#3C00#;
   I2S3_Base    : constant := APB1_Peripheral_Base + 16#3C00#;
   SPI2_Base    : constant := APB1_Peripheral_Base + 16#3800#;
   I2S2_Base    : constant := APB1_Peripheral_Base + 16#3800#;
   I2S2ext_Base : constant := APB1_Peripheral_Base + 16#3400#;
   IWDG_Base    : constant := APB1_Peripheral_Base + 16#3000#;
   WWDG_Base    : constant := APB1_Peripheral_Base + 16#2C00#;
   RTC_Base     : constant := APB1_Peripheral_Base + 16#2800#;
   TIM5_Base    : constant := APB1_Peripheral_Base + 16#0C00#;
   TIM4_Base    : constant := APB1_Peripheral_Base + 16#0800#;
   TIM3_Base    : constant := APB1_Peripheral_Base + 16#0400#;
   TIM2_Base    : constant := APB1_Peripheral_Base + 16#0000#;

   ---------------------------------
   -- RCC Reset and Clock Control --
   ---------------------------------

   type RCC_Registers is record
      CR             : Word;  --  RCC clock control register at 16#00#
      PLLCFGR        : Word;  --  RCC PLL configuration register at 16#04#
      CFGR           : Word;  --  RCC clock configuration register at 16#08#
      CIR            : Word;  --  RCC clock interrupt register at 16#0C#
      AHB1RSTR       : Word;  --  RCC AHB1 peripheral reset register at 16#10#
      AHB2RSTR       : Word;  --  RCC AHB2 peripheral reset register at 16#14#
      AHB3RSTR       : Word;  --  RCC AHB3 peripheral reset register at 16#18#
      Reserved_0     : Word;  --  Reserved at 16#1C#
      APB1RSTR       : Word;  --  RCC APB1 peripheral reset register at 16#20#
      APB2RSTR       : Word;  --  RCC APB2 peripheral reset register at 16#24#
      Reserved_1     : Word;  --  Reserved at 16#28#
      Reserved_2     : Word;  --  Reserved at 16#2c#
      AHB1ENR        : Word;  --  RCC AHB1 peripheral clock register at 16#30#
      AHB2ENR        : Word;  --  RCC AHB2 peripheral clock register at 16#34#
      AHB3ENR        : Word;  --  RCC AHB3 peripheral clock register at 16#38#
      Reserved_3     : Word;  --  Reserved at 16#0C#
      APB1ENR        : Word;  --  RCC APB1 peripheral clock enable at 16#40#
      APB2ENR        : Word;  --  RCC APB2 peripheral clock enable at 16#44#
      Reserved_4     : Word;  --  Reserved at 16#48#
      Reserved_5     : Word;  --  Reserved at 16#4c#
      AHB1LPENR      : Word;  --  RCC AHB1 periph. low power clk en. at 16#50#
      AHB2LPENR      : Word;  --  RCC AHB2 periph. low power clk en. at 16#54#
      AHB3LPENR      : Word;  --  RCC AHB3 periph. low power clk en. at 16#58#
      Reserved_6     : Word;  --  Reserved, 16#5C#
      APB1LPENR      : Word;  --  RCC APB1 periph. low power clk en. at 16#60#
      APB2LPENR      : Word;  --  RCC APB2 periph. low power clk en. at 16#64#
      Reserved_7     : Word;  --  Reserved at 16#68#
      Reserved_8     : Word;  --  Reserved at 16#6C#
      BDCR           : Word;  --  RCC Backup domain control register at 16#70#
      CSR            : Word;  --  RCC clock control/status register at 16#74#
      Reserved_9     : Word;  --  Reserved at 16#78#
      Reserved_10    : Word;  --  Reserved at 16#7C#
      SSCGR          : Word;  --  RCC spread spectrum clk gen. reg. at 16#80#
      PLLI2SCFGR     : Word;  --  RCC PLLI2S configuration register at 16#84#
      PLLSAICFGR     : Word;  --  RCC PLL configuration register at 16#88#
      DCKCFGR        : Word;  --  RCC Dedicated clock config. reg. at 16#8C#
   end record;

   RCC : RCC_Registers with Volatile, Address => System'To_Address (RCC_Base);

   package RCC_CR is
      --  Constants for RCC CR register
      HSION      : constant Word := 2**0;  -- Internal high-speed clock enable
      HSIRDY     : constant Word := 2**1;  -- Internal high-speed clock ready
      HSEON      : constant Word := 2**16; -- External high-speed clock enable
      HSERDY     : constant Word := 2**17; -- External high-speed clock ready
      HSEBYP     : constant Word := 2**18; -- External HS clk. resonator bypass
      CSSON      : constant Word := 2**19; -- Clock security system enable
      PLLON      : constant Word := 2**24; -- Main PLL enable
      PLLRDY     : constant Word := 2**25; -- Main PLL ready
      PLLI2SON   : constant Word := 2**26; -- Main PLL enable
      PLLI2SRDY  : constant Word := 2**27; -- Main PLL ready
   end RCC_CR;

   PLLSRC_HSE      : constant := 2**22; -- PLL source clock is HSE

   package RCC_CFGR is
      --  Constants for RCC CFGR register

      --  AHB prescaler
      HPRE_DIV1      : constant Word := 16#00#; -- AHB is SYSCLK
      HPRE_DIV2      : constant Word := 16#80#; -- AHB is SYSCLK / 2
      HPRE_DIV4      : constant Word := 16#90#; -- AHB is SYSCLK / 4
      HPRE_DIV8      : constant Word := 16#A0#; -- AHB is SYSCLK / 8
      HPRE_DIV16     : constant Word := 16#B0#; -- AHB is SYSCLK / 16
      HPRE_DIV64     : constant Word := 16#C0#; -- AHB is SYSCLK / 64
      HPRE_DIV128    : constant Word := 16#D0#; -- AHB is SYSCLK / 128
      HPRE_DIV256    : constant Word := 16#E0#; -- AHB is SYSCLK / 256
      HPRE_DIV512    : constant Word := 16#F0#; -- AHB is SYSCLK / 512

      --  APB1 prescaler
      PPRE1_DIV1     : constant Word := 16#0000#; -- APB1 is HCLK / 1
      PPRE1_DIV2     : constant Word := 16#1000#; -- APB1 is HCLK / 2
      PPRE1_DIV4     : constant Word := 16#1400#; -- APB1 is HCLK / 4
      PPRE1_DIV8     : constant Word := 16#1800#; -- APB1 is HCLK / 8
      PPRE1_DIV16    : constant Word := 16#1C00#; -- APB1 is HCLK / 16

      --  APB2 prescaler
      PPRE2_DIV1     : constant Word := 16#0000#; -- APB2 is HCLK / 1
      PPRE2_DIV2     : constant Word := 16#8000#; -- APB2 is HCLK / 2
      PPRE2_DIV4     : constant Word := 16#A000#; -- APB2 is HCLK / 4
      PPRE2_DIV8     : constant Word := 16#C000#; -- APB2 is HCLK / 8
      PPRE2_DIV16    : constant Word := 16#E000#; -- APB2 is HCLK / 16

      --  MCO1 clock selector
      MCO1SEL_HSI    : constant Word := 0 * 2**21; -- HSI clock on MC01 pin
      MCO1SEL_LSE    : constant Word := 1 * 2**21; -- LSE clock on MC01 pin
      MCO1SEL_HSE    : constant Word := 2 * 2**21; -- HSE clock on MC01 pin
      MCO1SEL_PLL    : constant Word := 3 * 2**21; -- PLL clock on MC01 pin

      --  MCO1 prescaler
      MCO1PRE_DIV1   : constant Word := 0 * 2**24; -- MC01 divides by 1
      MCO1PRE_DIV2   : constant Word := 4 * 2**24; -- MC01 divides by 2
      MCO1PRE_DIV3   : constant Word := 5 * 2**24; -- MC01 divides by 3
      MCO1PRE_DIV4   : constant Word := 6 * 2**24; -- MC01 divides by 4
      MCO1PRE_DIV5   : constant Word := 7 * 2**24; -- MC01 divides by 5

      --  MCO2 clock selector
      MCO2SEL_SYSCLK : constant Word := 0 * 2**30; -- SYSCLK clock on MCO2 pin
      MCO2SEL_PLLI2S : constant Word := 1 * 2**30; -- SYSCLK clock on MCO2 pin
      MCO2SEL_HSE    : constant Word := 2 * 2**30; -- SYSCLK clock on MCO2 pin
      MCO2SEL_PLL    : constant Word := 3 * 2**30; -- SYSCLK clock on MCO2 pin

      --  MCO2 prescaler
      MCO2PRE_DIV1   : constant Word := 0 * 2**27; -- MCO2 divides by 1
      MCO2PRE_DIV2   : constant Word := 4 * 2**27; -- MCO2 divides by 2
      MCO2PRE_DIV3   : constant Word := 5 * 2**27; -- MCO2 divides by 3
      MCO2PRE_DIV4   : constant Word := 6 * 2**27; -- MCO2 divides by 4
      MCO2PRE_DIV5   : constant Word := 7 * 2**27; -- MCO2 divides by 5

      --  I2S clock source
      I2SSRC_PLLI2S : constant Word := 0 * 2**23; -- I2SSRC is PLLI2S
      I2SSRC_PCKIN  : constant Word := 1 * 2**23; -- I2SSRC is I2S_CKIN

      --  System clock switch
      SW_HSI        : constant Word := 16#0#; -- HSI selected as system clock
      SW_HSE        : constant Word := 16#1#; -- HSI selected as system clock
      SW_PLL        : constant Word := 16#2#; -- PLL selected as system clock

      --  System clock switch status
      SWS_HSI       : constant Word := 16#0#; -- HSI used as system clock
      SWS_HSE       : constant Word := 16#4#; -- HSI used as system clock
      SWS_PLL       : constant Word := 16#8#; -- PLL used as system clock

   end RCC_CFGR;

   package RCC_CSR is
      --  Constants for RCC CR register
      LSION     : constant Word := 2**0; -- Int. low-speed clock enable
      LSIRDY    : constant Word := 2**1; -- Int. low-speed clock enable
   end RCC_CSR;

   --  Bit definitions for RCC APB1ENR register
   RCC_APB1ENR_USART2   : constant Word := 16#0002_0000#;
   RCC_APB1ENR_PWR      : constant Word := 16#1000_0000#;

   --  Bit definitions for RCC APB2ENR register
   RCC_APB2ENR_USART1   : constant Word := 16#10#;
   RCC_APB2ENR_USART6   : constant Word := 16#20#;

   --  Bit definitions for RCC AHB1ENR register
   RCC_AHB1ENR_GPIOA    : constant Word := 16#01#;

   ---------
   -- PWR --
   ---------

   type PWR_Registers is record
      CR    : Word; --  PWR power control register at 16#00#
      CSR   : Word; --  PWR power control/status register at 16#04#
   end record;

   PWR : PWR_Registers with Volatile, Import,
                            Address => System'To_Address (PWR_Base);

   PWR_CR_VOS_SCALE_3 : constant Word := 1 * 2**14;
   PWR_CR_VOS_SCALE_2 : constant Word := 2 * 2**14;
   PWR_CR_VOS_SCALE_1 : constant Word := 3 * 2**14;

   PWR_CSR_VOSRDY   : constant Word := 1 * 2**14; -- Regulator output ready

   ------------
   --  EXTI  --
   ------------

   type EXTI_Registers is record
      IMR   : Bits_32x1;
      EMR   : Bits_32x1;
      RTSR  : Bits_32x1;
      FTSR  : Bits_32x1;
      SWIER : Bits_32x1;
      PR    : Bits_32x1;
   end record;

   EXTI : EXTI_Registers with Volatile,
     Address => System'To_Address (EXTI_Base);
   pragma Import (Ada, EXTI);

   ------------
   --  SYSCFG  --
   ------------

   package SYSCFG_Constants is
      PORTA : constant Bits_4 := 0;
      PORTB : constant Bits_4 := 1;
      PORTC : constant Bits_4 := 2;
      PORTD : constant Bits_4 := 3;
      PORTE : constant Bits_4 := 4;
      PORTH : constant Bits_4 := 7;
   end SYSCFG_Constants;

   type SYSCFG_Registers is record
      MEMRMP    : Bits_16x2; -- 00
      PMC       : Bits_32x1; -- 04
      EXTICR1   : Bits_8x4;  -- 08
      EXTICR2   : Bits_8x4;  -- 0C
      EXTICR3   : Bits_8x4;  -- 10
      EXTICR4   : Bits_8x4;  -- 14
      RESERVED1 : Bits_32x1; -- 18
      RESERVED2 : Bits_32x1; -- 1C
      CMPCR     : Bits_32x1; -- 20
   end record;

   SYSCFG : SYSCFG_Registers with Volatile,
     Address => System'To_Address (SYSCFG_Base);
   pragma Import (Ada, SYSCFG);

   -----------
   -- USART --
   -----------

   package USART is
      --  Bit definitions for USART CR1 register
      CR1_SBK     : constant Bits_16 := 16#0001#;   -- Send Break
      CR1_RWU     : constant Bits_16 := 16#0002#;   -- Receiver Wakeup
      CR1_RE      : constant Bits_16 := 16#0004#;   -- Receiver Enable
      CR1_TE      : constant Bits_16 := 16#0008#;   -- Transmitter Enable
      CR1_IDLEIE  : constant Bits_16 := 16#0010#;   -- IDLE Interrupt Enable
      CR1_RXNEIE  : constant Bits_16 := 16#0020#;   -- RXNE Interrupt Enable
      CR1_TCIE    : constant Bits_16 := 16#0040#;   -- Xfer Complete Int. Ena.
      CR1_TXEIE   : constant Bits_16 := 16#0080#;   -- PE Interrupt Enable
      CR1_PEIE    : constant Bits_16 := 16#0100#;   -- PE Interrupt Enable
      CR1_PS      : constant Bits_16 := 16#0200#;   -- Parity Selection
      CR1_PCE     : constant Bits_16 := 16#0400#;   -- Parity Control Enable
      CR1_WAKE    : constant Bits_16 := 16#0800#;   -- Wakeup Method
      CR1_M       : constant Bits_16 := 16#1000#;   -- Word Length
      CR1_UE      : constant Bits_16 := 16#2000#;   -- USART Enable
      CR1_OVER8   : constant Bits_16 := 16#8000#;   -- Oversampling by 8 Enable

      --  Bit definitions for USART CR2 register
      CR2_ADD     : constant Bits_16 := 16#000F#;   -- Address of USART Node
      CR2_LBDL    : constant Bits_16 := 16#0020#;   -- LIN Brk Detection Length
      CR2_LBDIE   : constant Bits_16 := 16#0040#;   -- LIN Brk Det. Int. Enable
      CR2_LBCL    : constant Bits_16 := 16#0100#;   -- Last Bit Clock pulse
      CR2_CPHA    : constant Bits_16 := 16#0200#;   -- Clock Phase
      CR2_CPOL    : constant Bits_16 := 16#0400#;   -- Clock Polarity
      CR2_CLKEN   : constant Bits_16 := 16#0800#;   -- Clock Enable

      CR2_STOP    : constant Bits_16 := 16#3000#;   -- STOP bits
      CR2_STOP_0  : constant Bits_16 := 16#1000#;   -- Bit 0
      CR2_STOP_1  : constant Bits_16 := 16#2000#;   -- Bit 1

      CR2_LINEN   : constant Bits_16 := 16#4000#;   -- LIN mode enable

      --  Bit definitions for USART CR3 register
      CR3_EIE     : constant Bits_16 := 16#0001#;   -- Error Interrupt Enable
      CR3_IREN    : constant Bits_16 := 16#0002#;   -- IrDA mode Enable
      CR3_IRLP    : constant Bits_16 := 16#0004#;   -- IrDA Low-Power
      CR3_HDSEL   : constant Bits_16 := 16#0008#;   -- Half-Duplex Selection
      CR3_NACK    : constant Bits_16 := 16#0010#;   -- Smartcard NACK enable
      CR3_SCEN    : constant Bits_16 := 16#0020#;   -- Smartcard mode enable
      CR3_DMAR    : constant Bits_16 := 16#0040#;   -- DMA Enable Receiver
      CR3_DMAT    : constant Bits_16 := 16#0080#;   -- DMA Enable Transmitter
      CR3_RTSE    : constant Bits_16 := 16#0100#;   -- RTS Enable
      CR3_CTSE    : constant Bits_16 := 16#0200#;   -- CTS Enable
      CR3_CTSIE   : constant Bits_16 := 16#0400#;   -- CTS Interrupt Enable
      CR3_ONEBIT  : constant Bits_16 := 16#0800#;   -- One bit method enable

      --  Bit definitions for USART SR register
      SR_PE   : constant Bits_16 := 16#0001#; -- Parity error
      SR_FE   : constant Bits_16 := 16#0002#; -- Framing error
      SR_NF   : constant Bits_16 := 16#0004#; -- Noise detected flag
      SR_ORE  : constant Bits_16 := 16#0008#; -- Overrun error
      SR_IDLE : constant Bits_16 := 16#0010#; -- IDLE line detected
      SR_RXNE : constant Bits_16 := 16#0020#; -- Read data register not empty
      SR_TC   : constant Bits_16 := 16#0040#; -- Transmission complete
      SR_TXE  : constant Bits_16 := 16#0080#; -- Transmit data register empty
      SR_LBD  : constant Bits_16 := 16#0100#; -- LIN Break detection flag
      SR_CTS  : constant Bits_16 := 16#0200#; -- CTS Flag
   end USART;

   type USART_Registers is record
      SR         : Bits_16; -- USART Status register
      Reserved_0 : Bits_16;
      DR         : Bits_16; -- USART Data register
      Reserved_1 : Bits_16;
      BRR        : Bits_16; -- USART Baud rate register
      Reserved_2 : Bits_16;
      CR1        : Bits_16; -- USART Control register 1
      Reserved_3 : Bits_16;
      CR2        : Bits_16; -- USART Control register 2
      Reserved_4 : Bits_16;
      CR3        : Bits_16; -- USART Control register 3
      Reserved_5 : Bits_16;
      GTPR       : Bits_16; -- USART Guard time and prescaler register
      Reserved_6 : Bits_16;
   end record;

   USART1 : USART_Registers with Volatile,
                                 Address => System'To_Address (USART1_Base);

   USART2 : USART_Registers with Volatile,
                                 Address => System'To_Address (USART2_Base);

   USART6 : USART_Registers with Volatile,
                                 Address => System'To_Address (USART6_Base);

end System.STM32F4;
