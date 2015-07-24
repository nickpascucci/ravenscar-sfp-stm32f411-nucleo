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

package System.STM32F4.External_Interrupts is

   ------------
   --  EXTI  --
   ------------

   --  Constants
   EXTI_Base   : constant := APB2_Peripheral_Base + 16#3C00#;

   --  Registers and types
   --
   type Index is range 0 .. 22;

   type Interrupt_Mask_Register is array (Index) of Boolean
     with Pack;
   type Event_Mask_Register is array (Index) of Boolean
     with Pack;
   type Rising_Trigger_Selection_Register is array (Index) of Boolean
     with Pack;
   type Falling_Trigger_Selection_Register is array (Index) of Boolean
     with Pack;
   type Software_Interrupt_Event_Register is array (Index) of Boolean
     with Pack;
   type Pending_Register is array (Index) of Boolean
     with Pack;

   type EXTI_Registers is
      record
         IMR   : Interrupt_Mask_Register;
         EMR   : Event_Mask_Register;
         RTSR  : Rising_Trigger_Selection_Register;
         FTSR  : Falling_Trigger_Selection_Register;
         SWIER : Software_Interrupt_Event_Register;
         PR    : Pending_Register;
      end record with Size => 6 * 32;
   for EXTI_Registers use
      record
         IMR at 0 range 0 .. 31;
         EMR at Offset_Size range 0 .. 31;
         RTSR at 2 * Offset_Size range 0 .. 31;
         FTSR at 3 * Offset_Size range 0 .. 31;
         SWIER at 4 * Offset_Size range 0 .. 31;
         PR at 5 * Offset_Size range 0 .. 31;
      end record;

   EXTI : EXTI_Registers with Volatile,
     Address => System'To_Address (EXTI_Base);
   pragma Import (Ada, EXTI);

end System.STM32F4.External_Interrupts;
