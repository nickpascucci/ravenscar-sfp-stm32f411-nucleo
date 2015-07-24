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

package System.STM32F4.System_Configuration is
   ------------
   --  SYSCFG  --
   ------------

   --  Constants
   SYSCFG_Base : constant := APB2_Peripheral_Base + 16#3800#;

   --  Registers
   type Memory_Mapping_Mode is (MAIN_FLASH_MEMORY_MAPPED,
                                SYSTEM_FLASH_MEMORY_MAPPED,
                                EMBEDDED_SRAM_MAPPED) with Size => 2;
   for Memory_Mapping_Mode use (MAIN_FLASH_MEMORY_MAPPED => 2#00#,
                                SYSTEM_FLASH_MEMORY_MAPPED => 2#01#,
                                EMBEDDED_SRAM_MAPPED => 2#11#);

   type Memory_Remap_Register is
      record
         MEM_MODE : Memory_Mapping_Mode;
      end record with Size => 32;
   for Memory_Remap_Register use
      record
         MEM_MODE at 0 range 0 .. 1;
      end record;

   type Peripheral_Mode_Configuration_Register is
      record
         ADCxDC2 : Boolean := False;
      end record with Size => 32;
   for Peripheral_Mode_Configuration_Register use
      record
         ADCxDC2 at 0 range 16 .. 16;
      end record;

   type External_Interrupt_Source_Input is (PORT_A,
                                            PORT_B,
                                            PORT_C,
                                            PORT_D,
                                            PORT_E,
                                            PORT_H) with Size => 4;
   for External_Interrupt_Source_Input use (PORT_A => 2#0000#,
                                            PORT_B => 2#0001#,
                                            PORT_C => 2#0010#,
                                            PORT_D => 2#0011#,
                                            PORT_E => 2#0100#,
                                            PORT_H => 2#1111#);

   type Sources_Array is array (0 .. 3) of External_Interrupt_Source_Input
     with Pack;

   type External_Interrupt_Configuration_Register is
      record
           Sources : Sources_Array := (others => PORT_A);
      end record with Size => 32;
   for External_Interrupt_Configuration_Register use
      record
         Sources at 0 range 0 .. 15;
      end record;

   type Compensation_Cell_Control_Register is
      record
         Compensation_Cell_Enable : Boolean := False;
         Compensation_Cell_ready : Boolean := False;
      end record with Size => 32;
   for Compensation_Cell_Control_Register use
      record
         Compensation_Cell_Enable at 0 range 0 .. 0;
         Compensation_Cell_ready at 0 range 8 .. 8;
      end record;

   type EXTI_Cfg_Registers_Index is range 1 .. 4;
   type EXTI_Cfg_Registers is array (EXTI_Cfg_Registers_Index) of
     External_Interrupt_Configuration_Register with Pack;

   type SYSCFG_Registers is
      record
         MEMRMP : Memory_Remap_Register;
         PMC : Peripheral_Mode_Configuration_Register;
         SYSCFG_EXTICR : EXTI_Cfg_Registers;
         CMPCR : Compensation_Cell_Control_Register;
      end record with Size => 7 * 32;
   for SYSCFG_Registers use
      record
         MEMRMP at 0 range 0 .. 31;
         PMC at Offset_Size range 0 .. 31;
         SYSCFG_EXTICR at 2 * Offset_Size range 0 .. 127;
         CMPCR at 6 * Offset_Size range 0 .. 31;
      end record;

   SYSCFG : SYSCFG_Registers with Volatile,
     Address => System'To_Address (SYSCFG_Base);
   pragma Import (Ada, SYSCFG);

end System.STM32F4.System_Configuration;
