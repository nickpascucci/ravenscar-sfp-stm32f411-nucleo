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

package System.STM32F4.USART is

   -----------
   -- USART --
   -----------

   --  Constants
   USART1_Base : constant := APB2_Peripheral_Base + 16#1000#;
   USART2_Base  : constant := APB1_Peripheral_Base + 16#4400#;
   USART6_Base : constant := APB2_Peripheral_Base + 16#1400#;

   type Status_Register is
      record
         Parity_Error : Boolean;
         Framing_Error : Boolean;
         Noise_Detected_Flag : Boolean;
         Overrun_Error : Boolean;
         IDLE_Line_Detected : Boolean;
         Read_Data_Register_Not_Empty : Boolean;
         Transmission_Complete : Boolean;
         Transmit_Data_Register_Empty : Boolean;
         LIN_Break_Detection_Flag : Boolean;
         CTS_Flag : Boolean;
      end record with Size => 32;
   for Status_Register use
      record
         Parity_Error at 0 range 0 .. 0;
         Framing_Error at 0 range 1 .. 1;
         Noise_Detected_Flag at 0 range 2 .. 2;
         Overrun_Error at 0 range 3 .. 3;
         IDLE_Line_Detected at 0 range 4 .. 4;
         Read_Data_Register_Not_Empty at 0 range 5 .. 5;
         Transmission_Complete at 0 range 6 .. 6;
         Transmit_Data_Register_Empty at 0 range 7 .. 7;
         LIN_Break_Detection_Flag at 0 range 8 .. 8;
         CTS_Flag at 0 range 9 .. 9;
      end record;

   type Data_Register is
      record
         Data_Value : Bits_9;
      end record with Size => 32;
   for Data_Register use
      record
         Data_Value at 0 range 0 .. 8;
      end record;

   type Mantissa is range 0 .. 2**12 - 1 with Size => 12;
   type Fraction is range 0 .. 2**4 - 1 with Size => 4;

   type Baud_Rate_Register is
      record
         DIV_Fraction : Fraction;
         DIV_Mantissa : Mantissa;
      end record with Size => 32;
   for Baud_Rate_Register use
      record
         DIV_Fraction at 0 range 0 .. 3;
         DIV_Mantissa at 0 range 4 .. 15;
      end record;

   type Parity is (EVEN, ODD) with Size => 1;
   for Parity use (EVEN => 0,
                   ODD => 1);

   type Wakeup_Methods is (IDLE_LINE,
                          ADDRESS_MARK) with Size => 1;
   for Wakeup_Methods use (IDLE_LINE => 0,
                          ADDRESS_MARK => 1);

   type Word_Length is (EIGHT_BITS, NINE_BITS) with Size => 1;
   for Word_Length use (EIGHT_BITS => 0,
                        NINE_BITS => 1
                       );

   type Oversampling_Modes is (OVERSAMPLING_BY_16,
                               OVERSAMPLING_BY_8);
   for Oversampling_Modes use (OVERSAMPLING_BY_16 => 0,
                               OVERSAMPLING_BY_8 => 1);

   type Control_Register_1 is
      record
         Send_Break : Boolean;
         Receiver_WakeUp : Boolean;
         Receiver_Enable : Boolean;
         Transmitter_Enable : Boolean;
         IDLE_Interrupt_Enable : Boolean;
         RXNE_Interrupt_Enable : Boolean;
         Transmission_Complete_Interrupt : Boolean;
         TXE_Interrupt_Enable : Boolean;
         PE_Interrupt_Enable : Boolean;
         Parity_Selection : Parity;
         Parity_Control_Enable : Boolean;
         WakeUp_Method : Wakeup_Methods;
         Length : Word_Length;
         USART_Enable : Boolean;
         Oversampling_Mode : Oversampling_Modes;
      end record with Size => 32;
   for Control_Register_1 use
      record
         Send_Break at 0 range 0 .. 0;
         Receiver_WakeUp at 0 range 1 .. 1;
         Receiver_Enable at 0 range 2 .. 2;
         Transmitter_Enable at 0 range 3 .. 3;
         IDLE_Interrupt_Enable at 0 range 4 .. 4;
         RXNE_Interrupt_Enable at 0 range 5 .. 5;
         Transmission_Complete_Interrupt at 0 range 6 .. 6;
         TXE_Interrupt_Enable at 0 range 7 .. 7;
         PE_Interrupt_Enable at 0 range 8 .. 8;
         Parity_Selection at 0 range 9 .. 9;
         Parity_Control_Enable at 0 range 10 .. 10;
         WakeUp_Method at 0 range 11 .. 11;
         Length at 0 range 12 .. 12;
         USART_Enable at 0 range 13 .. 13;
         Oversampling_Mode at 0 range 15 .. 15;
      end record;

   type Break_Detection_Length is (TEN_BITS, ELEVEN_BITS) with Size => 1;
   for Break_Detection_Length use (TEN_BITS => 0,
                                   ELEVEN_BITS => 1);

   type Clock_Phases is (FIRST_TRANSITION,
                         SECOND_TRANSITION) with Size => 1;
   for Clock_Phases use (FIRST_TRANSITION => 0,
                         SECOND_TRANSITION => 1);

   type Clock_Polarities is (LOW,
                           HIGH) with Size => 1;
   for Clock_Polarities use (LOW => 0,
                           HIGH => 1);

   type Stop_Bits is (ONE_STOP_BIT,
                      HALF_STOP_BIT,
                      TWO_STOP_BITS,
                      ONE_AND_HALF_BITS) with Size => 2;
   for Stop_Bits use (ONE_STOP_BIT => 2#00#,
                      HALF_STOP_BIT => 2#01#,
                      TWO_STOP_BITS => 2#10#,
                      ONE_AND_HALF_BITS => 2#11#);

   type Control_Register_2 is
      record
         USART_Node_Address : Bits_4;
         Break_Length : Break_Detection_Length;
         Break_Detection_Interrupt_Enable : Boolean;
         Last_Bit_Clock_Pulse : Boolean;
         Clock_Phase : Clock_Phases;
         Clock_Polarity : Clock_Polarities;
         Clock_Enable : Boolean;
         Stop_Bit : Stop_Bits;
         LIN_Mode_Enable : Boolean;
      end record with Size => 32;
   for Control_Register_2 use
      record
         USART_Node_Address at 0 range 0 .. 3;
         Break_Length at 0 range 5 .. 5;
         Break_Detection_Interrupt_Enable at 0 range 6 .. 6;
         Last_Bit_Clock_Pulse at 0 range 8 .. 8;
         Clock_Phase at 0 range 9 .. 9;
         Clock_Polarity at 0 range 10 .. 10;
         Clock_Enable at 0 range 11 .. 11;
         Stop_Bit at 0 range 12 .. 13;
         LIN_Mode_Enable at 0 range 14 .. 14;
      end record;

   type Power_Modes is (NORMAL_MODE,
                        LOW_POWER_MODE) with Size => 1;
   for Power_Modes use (NORMAL_MODE => 0,
                        LOW_POWER_MODE => 1);

   type Sample_Bit_Methods is (THREE_BITS,
                               ONE_BIT) with Size => 1;
   for Sample_Bit_Methods use (THREE_BITS => 0,
                               ONE_BIT => 1);

   type Control_Register_3 is
      record
         Error_Interrupt_Enable : Boolean;
         IrDA_Mode_Enable : Boolean;
         IrDA_Low_Power : Power_Modes;
         Half_Duplex_Selected : Boolean;
         Smartcard_NACK_Enable : Boolean;
         Smartcard_Mode_Enable : Boolean;
         DMA_Receiver_Enable : Boolean;
         DMA_Transmitter_Enable : Boolean;
         RTS_Enable : Boolean;
         CTS_Enable : Boolean;
         CTS_Interrrupt_Enable : Boolean;
         Sample_Bit_Method : Sample_Bit_Methods;
      end record with Size => 32;
   for Control_Register_3 use
      record
         Error_Interrupt_Enable at 0 range 0 .. 0;
         IrDA_Mode_Enable at 0 range 1 .. 1;
         IrDA_Low_Power at 0 range 2 .. 2;
         Half_Duplex_Selected at 0 range 3 .. 3;
         Smartcard_NACK_Enable at 0 range 4 .. 4;
         Smartcard_Mode_Enable at 0 range 5 .. 5;
         DMA_Receiver_Enable at 0 range 6 .. 6;
         DMA_Transmitter_Enable at 0 range 7 .. 7;
         RTS_Enable at 0 range 8 .. 8;
         CTS_Enable at 0 range 9 .. 9;
         CTS_Interrrupt_Enable at 0 range 10 .. 10;
         Sample_Bit_Method at 0 range 11 .. 11;
      end record;

   type Guard_Time_Prescaler_Register is
      record
         Prescaler_Value : Interfaces.Unsigned_8;
         Guard_Time_Value : Interfaces.Unsigned_8;
      end record with Size => 32;
   for Guard_Time_Prescaler_Register use
      record
         Prescaler_Value at 0 range 0 .. 7;
         Guard_Time_Value at 0 range 8 .. 15;
      end record;

   type USART_Registers is
      record
         SR : Status_Register;
         DR : Data_Register;
         BRR : Baud_Rate_Register;
         CR1 : Control_Register_1;
         CR2 : Control_Register_2;
         CR3 : Control_Register_3;
         GTPR : Guard_Time_Prescaler_Register;
      end record with Size => 7 * 32;
   for USART_Registers use
      record
         SR at 0 range 0 .. 31;
         DR at Offset_Size range 0 .. 31;
         BRR at 2 * Offset_Size range 0 .. 31;
         CR1 at 3 * Offset_Size range 0 .. 31;
         CR2 at 4 * Offset_Size range 0 .. 31;
         CR3 at 5 * Offset_Size range 0 .. 31;
         GTPR at 6 * Offset_Size range 0 .. 31;
      end record;

   USART1 : USART_Registers with Volatile,
     Address => System'To_Address (USART1_Base);

   USART2 : USART_Registers with Volatile,
     Address => System'To_Address (USART2_Base);

   USART6 : USART_Registers with Volatile,
     Address => System'To_Address (USART6_Base);

end System.STM32F4.USART;
