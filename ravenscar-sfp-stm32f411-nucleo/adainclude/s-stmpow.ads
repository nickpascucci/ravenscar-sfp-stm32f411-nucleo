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

package System.STM32F4.Power is

   ---------
   -- PWR --
   ---------

   --  Constants for Power management
   PWR_Base     : constant := APB1_Peripheral_Base + 16#7000#;

   type Voltage_Threshold is (V2_2,
                              V2_3,
                              V2_4,
                              V2_5,
                              V2_6,
                              V2_7,
                              V2_8,
                              V2_9);
   for Voltage_Threshold use (V2_2 => 2#000#,
                              V2_3 => 2#001#,
                              V2_4 => 2#010#,
                              V2_5 => 2#011#,
                              V2_6 => 2#100#,
                              V2_7 => 2#101#,
                              V2_8 => 2#110#,
                              V2_9 => 2#111#);

   type Voltage_Scaling_Selection is (SCALE_3,
                                      SCALE_2,
                                      SCALE_1);
   for Voltage_Scaling_Selection use (SCALE_3 => 2#01#,
                                      SCALE_2 => 2#10#,
                                      SCALE_1 => 2#11#);

   type Control_Register is
      record
         Low_Power_Deepsleep : Boolean;
         Power_Down_Deesleep : Boolean;
         Clear_Wakeup_Flag : Boolean;
         Clear_StandBy_Flag : Boolean;
         Power_Voltage_Detector_Enable : Boolean;
         Voltage_Threshold_Detection : Voltage_Threshold;
         Disable_Backup_Domain_Write_Protection : Boolean;
         Flash_Power_Down_In_Stop_Mode : Boolean;
         Low_Power_Regulator_Deepsleep : Boolean;
         Main_Regulator_Deepsleep : Boolean;
         ADCDC1 : Boolean;
         Regulator_Voltage_Scale : Voltage_Scaling_Selection;
         Flash_Memory_Sleep_System_Run : Boolean;
         Flash_Interface_Stop_System_Run : Boolean;
      end record with Size => 32;
   for Control_Register use
      record
         Low_Power_Deepsleep at 0 range 0 .. 0;
         Power_Down_Deesleep at 0 range 1 .. 1;
         Clear_Wakeup_Flag at 0 range 2 .. 2;
         Clear_StandBy_Flag at 0 range 3 .. 3;
         Power_Voltage_Detector_Enable at 0 range 4 .. 4;
         Voltage_Threshold_Detection at 0 range 5 .. 7;
         Disable_Backup_Domain_Write_Protection at 0 range 8 .. 8;
         Flash_Power_Down_In_Stop_Mode at 0 range 9 .. 9;
         Low_Power_Regulator_Deepsleep at 0 range 10 .. 10;
         Main_Regulator_Deepsleep at 0 range 11 .. 11;
         ADCDC1 at 0 range 13 .. 13;
         Regulator_Voltage_Scale at 0 range 14 .. 15;
         Flash_Memory_Sleep_System_Run at 0 range 20 .. 20;
         Flash_Interface_Stop_System_Run at 0 range 21 .. 21;
      end record;

   type Control_Status_Register is
      record
         WakeUp_Flag : Boolean;
         StandBy_Flag : Boolean;
         PVD_Output : Boolean;
         Backup_Regulator_Ready : Boolean;
         Enable_WakeUp_Pin : Boolean;
         Backup_Regulator_Enable : Boolean;
         Regulator_Voltage_Scaling_Ready : Boolean;
      end record with Size => 32;
   for Control_Status_Register use
      record
         WakeUp_Flag at 0 range 0 .. 0;
         StandBy_Flag at 0 range 1 .. 1;
         PVD_Output at 0 range 2 .. 2;
         Backup_Regulator_Ready at 0 range 3 .. 3;
         Enable_WakeUp_Pin at 0 range 8 .. 8;
         Backup_Regulator_Enable at 0 range 9 .. 9;
         Regulator_Voltage_Scaling_Ready at 0 range 14 .. 14;
      end record;

   type PWR_Registers is record
      --  PWR power control register at 16#00#
      CR    : Control_Register;

      --  PWR power control/status register at 16#04#
      CSR   : Control_Status_Register;
   end record with Size => 64;
   for PWR_Registers use
      record
         CR at 0 range 0 .. 31;
         CSR at Offset_Size range 0 .. 31;
      end record;

   PWR : PWR_Registers with Volatile, Import,
     Address => System'To_Address (PWR_Base);

end System.STM32F4.Power;
