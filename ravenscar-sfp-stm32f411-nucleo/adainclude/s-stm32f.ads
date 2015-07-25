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
   type Bits_9 is mod 2**9 with Size => 9;
   type Bits_12 is mod 2**12 with Size => 12;
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

   CRC_Base   : constant := AHB1_Peripheral_Base + 16#3000#;

   --  The SPI/I2S registers share the same location, but have different
   --  purposes depending on enabled peripherals.
   SPI5_Base   : constant := APB2_Peripheral_Base + 16#5000#;
   I2S5_Base   : constant := APB2_Peripheral_Base + 16#5000#;
   TIM11_Base  : constant := APB2_Peripheral_Base + 16#4800#;
   TIM10_Base  : constant := APB2_Peripheral_Base + 16#4400#;
   TIM9_Base   : constant := APB2_Peripheral_Base + 16#4000#;
   SPI4_Base   : constant := APB2_Peripheral_Base + 16#3400#;
   I2S4_Base   : constant := APB2_Peripheral_Base + 16#3400#;
   SPI1_Base   : constant := APB2_Peripheral_Base + 16#3000#;
   I2S1_Base   : constant := APB2_Peripheral_Base + 16#3000#;
   SDIO_Base   : constant := APB2_Peripheral_Base + 16#2C00#;
   ADC1_Base   : constant := APB2_Peripheral_Base + 16#2000#;
   TIM1_Base   : constant := APB2_Peripheral_Base + 16#0000#;

   I2C3_Base    : constant := APB1_Peripheral_Base + 16#5C00#;
   I2C2_Base    : constant := APB1_Peripheral_Base + 16#5800#;
   I2C1_Base    : constant := APB1_Peripheral_Base + 16#5400#;
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

end System.STM32F4;
