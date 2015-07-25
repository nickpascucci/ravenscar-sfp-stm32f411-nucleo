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

pragma Ada_2012; -- To work around pre-commit check?
pragma Restrictions (No_Elaboration_Code);

--  This initialization procedure mainly initializes the PLLs and
--  all derived clocks. For now it also initializes the first USART.
--  To be moved to s-textio, but needs clock info ???

with System.STM32F4;
use System.STM32F4;

with System.STM32F4.GPIO;

with System.STM32F4.Flash_Registers;
use System.STM32F4.Flash_Registers;

with System.STM32F4.Reset_Clock_Control;
use System.STM32F4.Reset_Clock_Control;

with System.STM32F4.Power;
use System.STM32F4.Power;

with System.STM32F4.USART;
use System.STM32F4.USART;

procedure Setup_Pll is

   subtype HSECLK_Range is Integer range   1_000_000 ..  50_000_000;
   subtype PLLIN_Range  is Integer range   1_000_000 ..   2_000_000;
   subtype PLLVC0_Range is Integer range 192_000_000 .. 432_000_000;
   subtype PLLOUT_Range is Integer range  24_000_000 .. 180_000_000;
   subtype SYSCLK_Range is Integer range           1 .. 180_000_000;
   subtype HCLK_Range   is Integer range           1 .. 180_000_000;
   subtype PCLK1_Range  is Integer range           1 ..  45_000_000;
   subtype PCLK2_Range  is Integer range           1 ..  90_000_000;
   subtype SPII2S_Range is Integer range           1 ..  37_500_000; -- ?
   pragma Unreferenced (SPII2S_Range);

   --  These internal low and high speed clocks are fixed. Do not modify.

   HSICLK : constant := 16_000_000;
   LSICLK : constant :=     32_000;
   pragma Unreferenced (LSICLK);

   --  The following external clock could be changed, but note that the PLL
   --  values have been calculated for a 84 MHz system clock from an external
   --  8 MHz HSE clock. The PLL values are used when Activate_PLL is True.

   HSECLK          : constant HSECLK_Range := 8_000_000; -- ext. clock is 8 MHz

   HSE_Enabled     : constant Boolean := True;  -- use high-speed ext. clock
   HSE_Bypass      : constant Boolean := True;  -- bypass ext. resonator
   LSI_Enabled     : constant Boolean := True;  -- use low-speed internal clock
   USART_Enabled   : constant Boolean := False;

   Activate_PLL    : constant Boolean := True;
   Activate_PLLI2S : constant Boolean := False;
   Activate_PLLSAI : constant Boolean := False;

   pragma Assert ((if Activate_PLL then HSE_Enabled),
                  "PLL only supported with external clock");
   pragma Assert (not Activate_PLLI2S, "not yet implemented");
   pragma Assert (not Activate_PLLSAI, "not yet implemented");

   -------------------------------
   -- Compute Clock Frequencies --
   -------------------------------

   PLLM_Value  : constant := 8;     -- divider in range 2 .. 63
   PLLN_Value  : constant := 336;   -- multiplier in range 192 .. 432
   PLLP_Value  : constant := 4;     -- divider may be 2, 4, 6 or 8
--     PLLQ_Value  : constant := 7;     -- multiplier in range 2 .. 15

   PLLCLKIN    : constant PLLIN_Range  := HSECLK / PLLM_Value;   --    1 MHz
   PLLVC0      : constant PLLVC0_Range := PLLCLKIN * PLLN_Value; --  336 MHz
   PLLCLKOUT   : constant PLLOUT_Range := PLLVC0 / PLLP_Value;   --  84 MHz

--     PLLM     : constant Word := PLLM_Value;
--     PLLN     : constant Word := PLLN_Value * 2**6;
--     PLLP     : constant Word := (PLLP_Value / 2 - 1) * 2**16;
--     PLLQ     : constant Word := PLLQ_Value * 2**24;

   HPRE     : constant AHB_Clock_Division_Factor
     := RCC.RCC_CFGR.AHB_Prescaler_Factor;
   PPRE1    : constant APB_Clock_Division_Factor
     := RCC.RCC_CFGR.APB_Low_Speed_Prescaler_Factor;
   PPRE2    : constant APB_Clock_Division_Factor
     := RCC.RCC_CFGR.APB_High_Speed_Prescaler_Factor;

   SW       : constant System_Clock :=
                (if Activate_PLL then PLL else HSI);

   SYSCLOCK   : constant SYSCLK_Range :=
                (if Activate_PLL then PLLCLKOUT else HSICLK);

   HCLK     : constant HCLK_Range :=
     (case HPRE is
         when NOT_DIVIDED   => SYSCLOCK / 1,
         when DIVIDED_BY_2   => SYSCLOCK / 2,
         when DIVIDED_BY_4   => SYSCLOCK / 4,
         when DIVIDED_BY_8   => SYSCLOCK / 8,
         when DIVIDED_BY_16  => SYSCLOCK / 16,
         when DIVIDED_BY_64  => SYSCLOCK / 64,
         when DIVIDED_BY_128 => SYSCLOCK / 128,
         when DIVIDED_BY_256 => SYSCLOCK / 256,
         when DIVIDED_BY_512 => SYSCLOCK / 512
     );

   PCLK1    : constant PCLK1_Range :=
                (case PPRE1 is
                 when NOT_DIVIDED  => HCLK / 1,
                 when DIVIDED_BY_2  => HCLK / 2,
                 when DIVIDED_BY_4  => HCLK / 4,
                 when DIVIDED_BY_8  => HCLK / 8,
                 when DIVIDED_BY_16 => HCLK / 16);
   pragma Unreferenced (PCLK1);

   PCLK2    : constant PCLK2_Range :=
     (case PPRE2 is
         when NOT_DIVIDED  => HCLK / 1,
         when DIVIDED_BY_2  => HCLK / 2,
         when DIVIDED_BY_4  => HCLK / 4,
         when DIVIDED_BY_8  => HCLK / 8,
         when DIVIDED_BY_16 => HCLK / 16
     );

   --  Local Subprograms
   procedure Initialize_USART1 (Baudrate : Positive);
   procedure Initialize_Clocks;
   procedure Reset_Clocks;

   -----------------------
   -- Initialize_Clocks --
   -----------------------

   procedure Initialize_Clocks is
   begin
      --  PWR clock enable
      --  Reset the power interface

      RCC.RCC_APB1ENR.Power_Interface_Clock_Enable := True;

      --  PWR initialization
      --
      --  Select the SCALE_1 voltage scaling (max) to be compliant with
      --  the 168 MHz SYSCLK of the configuration.
      --  See: Datasheet of STM32F42x (DocID024030 Rev 4 - p93).
      --
      --  Notice that on STM32F42x, power scaling is effective only after
      --  PLL is ON. If PLL is not used, the voltage scaling can not be
      --  modified.
      --  See RM (DocID 018909 Rev 7 - p120).

      if Activate_PLL then
         PWR.CR.Regulator_Voltage_Scale := SCALE_1;
      end if;

      --  Wait until voltage supply scaling has completed after PLL is on in
      --  case of PLL use.

      if not Activate_PLL then
         loop
            exit when PWR.CSR.Regulator_Voltage_Scaling_Ready;
         end loop;
      end if;

      --  Setup internal clock and wait for HSI stabilisation.
      --  The internal high speed clock is always enabled, because it is the
      --  fallback clock when the PLL fails.

      RCC.RCC_CR.HSI_Enable := True;

      loop
         exit when RCC.RCC_CR.HSI_Ready_Flag;
      end loop;

      --  Configure high-speed external clock, if enabled

      if HSE_Enabled then
         RCC.RCC_CR.HSE_Enable := True;
         if HSE_Bypass then
            RCC.RCC_CR.HSE_Bypass := True;
         end if;

--  Can also be initialized as following
--           RCC.RCC_CR :=
--             Clock_Control_Register'
--               (PLLI2S_Ready_Flag      => RCC.RCC_CR.PLLI2S_Ready_Flag,
--                PLLI2S_Enable          => RCC.RCC_CR.PLLI2S_Enable,
--                PLL_Ready_Flag         => RCC.RCC_CR.PLL_Ready_Flag,
--                PLL_Enable             => RCC.RCC_CR.PLL_Enable,
--                Security_System_Enable => RCC.RCC_CR.Security_System_Enable,
--                HSE_Ready_Flag         => RCC.RCC_CR.HSE_Ready_Flag,
--                HSI_Calibration        => RCC.RCC_CR.HSI_Calibration,
--                HSI_Trim               => RCC.RCC_CR.HSI_Trim,
--                HSI_Ready_Flag         => RCC.RCC_CR.HSI_Ready_Flag,
--                HSI_Enable             => RCC.RCC_CR.HSI_Enable,
--                HSE_Enable => True,
--                HSE_Bypass => (if HSE_Bypass then
--                                      True
--                               else False));
--           RCC.CR := RCC.CR or RCC_CR.HSEON
--             or (if HSE_Bypass then RCC_CR.HSEBYP else 0);

         loop
            exit when RCC.RCC_CR.HSE_Ready_Flag;
         end loop;
      end if;

      --  Configure low-speed internal clock if enabled
      if LSI_Enabled then
         RCC.RCC_CSR.Internal_Low_Speed_Enable := True;

         loop
            exit when RCC.RCC_CSR.Internal_Low_Speed_Ready;
         end loop;
      end if;

      --  Activate PLL if enabled

      if Activate_PLL then
         RCC.RCC_PLLCFGR :=
           PLL_Configuration_Register'
             (Division_Factor_For_Input      => 8,
              Multiplication_Factor_For_Main => 336,
              Division_Factor_For_Main       => PLLP_4,
              Clock_Source                   => HSE,
              Division_Factor_For_USB        => 7);

         RCC.RCC_CR.PLL_Enable := True;

         loop
            exit when RCC.RCC_CR.PLL_Ready_Flag;
         end loop;
      end if;

      --  Wait until voltage supply scaling has completed after PLL is on in
      --  case of PLL use.
      if Activate_PLL then
         loop
            exit when PWR.CSR.Regulator_Voltage_Scaling_Ready;
         end loop;
      end if;

      --  Configure flash
      --  Must be done before increasing the frequency, otherwise the CPU
      --  won't be able to fetch new instructions.
      --  FIXME: RM suggests a procedure to ensure that flash is correctly set.
      --
      --  With a 165 MHz SYSCLK, 5 wait states must be configured.
      --  See Table 11 in RM (DocID 018909 Rev 7 - p81).

      Flash.ACR.Latency := LATENCY_5WS;
      Flash.ACR.ICEN := True;
      Flash.ACR.DCEN := True;
      Flash.ACR.PRFTEN := True;

      --  Configure derived clocks
      --  AHB prescaler is 1, APB1 uses 4 and APB2 prescaler is 2
      --  Configure MC01 pin to have the HSI (high speed internal clock)
      --  Configure MCO2 pin to have SYSCLK / 5
      --  Select system clock source
      --  SW;

      RCC.RCC_CFGR :=
        Clock_Configuration_Register'
          (System_Clock_Switch             => SW,
           System_Clock_Status             => RCC.RCC_CFGR.System_Clock_Status,
           AHB_Prescaler_Factor            => NOT_DIVIDED,
           APB_Low_Speed_Prescaler_Factor  => DIVIDED_BY_4,
           APB_High_Speed_Prescaler_Factor => DIVIDED_BY_2,
           HSE_Division_Factor             => 0,
           Microcontroller_Clock_Output_1  => HSI,
           I2S_Clock                       => RCC.RCC_CFGR.I2S_Clock,
           MCO1_Prescaler                  => NOT_DIVIDED,
           MCO2_Prescaler                  => DIVIDED_BY_5,
           Microcontroller_Clock_Output_2  => SYSCLK);

      if Activate_PLL then
         loop
            exit when
              RCC.RCC_CFGR.System_Clock_Status
                = RCC.RCC_CFGR.System_Clock_Switch;
         end loop;
      end if;

   end Initialize_Clocks;

   ------------------
   -- Reset_Clocks --
   ------------------

   procedure Reset_Clocks is
   begin
      --  Switch on high speed internal clock
      RCC.RCC_CR.HSI_Enable := True;

      --  Reset CFGR regiser
      RCC.RCC_CFGR :=
        Clock_Configuration_Register'
          (System_Clock_Switch             => HSI,
           System_Clock_Status             => HSI,
           AHB_Prescaler_Factor            => NOT_DIVIDED,
           APB_Low_Speed_Prescaler_Factor  => NOT_DIVIDED,
           APB_High_Speed_Prescaler_Factor => NOT_DIVIDED,
           HSE_Division_Factor             => 0,
           Microcontroller_Clock_Output_1  => HSI,
           I2S_Clock                       => PLLI2S,
           MCO1_Prescaler                  => NOT_DIVIDED,
           MCO2_Prescaler                  => NOT_DIVIDED,
           Microcontroller_Clock_Output_2  => Reset_Clock_Control.SYSCLK);

      --  Reset HSEON, CSSON and PLLON bits
      --  Reset HSE bypass bit
      RCC.RCC_CR.HSE_Enable := False;
      RCC.RCC_CR.Security_System_Enable := False;
      RCC.RCC_CR.PLL_Enable := False;
      RCC.RCC_CR.HSE_Bypass := False;

--       RCC.RCC_CR := Clock_Control_Register'(PLLI2S_Ready_Flag      => False,
--                                             PLLI2S_Enable          => False,
--                                             PLL_Ready_Flag         => False,
--                                             PLL_Enable             => False,
--                                             Security_System_Enable => False,
--                                             HSE_Bypass             => False,
--                                             HSE_Ready_Flag         => False,
--                                             HSE_Enable             => False,
--                                             HSI_Calibration        => 0,
--                                             HSI_Trim               => 0,
--                                             HSI_Ready_Flag         => False,
--                                             HSI_Enable             => True);

      --  Reset PLL configuration register
      --  RCC.PLLCFGR := 16#2400_3010#;
      RCC.RCC_PLLCFGR :=
        PLL_Configuration_Register'(Division_Factor_For_Input      => 16,
                                    Multiplication_Factor_For_Main => 64,
                                    Division_Factor_For_Main       => PLLP_6,
                                    Clock_Source                   => HSI,
                                    Division_Factor_For_USB        => 4);

      --  Disable all interrupts
      RCC.RCC_CIR := (others => False);
   end Reset_Clocks;

   -----------------------
   -- Initialize_USART1 --
   -----------------------

   procedure Initialize_USART1 (Baudrate : Positive) is
      use System.STM32F4.GPIO;
--        APB_Clock    : constant Positive := PCLK2;
      Int_Divider  : constant Mantissa
        := Mantissa (PCLK2 / (8 * 2 * Baudrate));
      Frac_Divider : constant Fraction
        := Fraction (PCLK2 rem (8 * 2 * Baudrate));
   begin
      RCC.RCC_APB2ENR.USART1_Clock_Enable := True;
      RCC.RCC_AHB1ENR.GPIOA_clock_Enable := True;

      GPIOA.MODER   (9 .. 10) := (Mode_AF,     Mode_AF);
      GPIOA.OSPEEDR (9 .. 10) := (Speed_50MHz, Speed_50MHz);
      GPIOA.OTYPER  (9 .. 10) := (Type_PP,     Type_PP);
      GPIOA.PUPDR   (9 .. 10) := (Pull_Up,     Pull_Up);
      GPIOA.AFRH    (1 ..  2) := (AF_USART1,   AF_USART1);

      USART1.BRR := Baud_Rate_Register'(DIV_Fraction => Frac_Divider,
                                       DIV_Mantissa => Int_Divider);
      --  Must be done in one time, bit to bit does not seem to work
      USART1.CR1 := Control_Register_1'(Send_Break                      => False,
                                        Receiver_WakeUp                 => False,
                                        Receiver_Enable                 => True,
                                        Transmitter_Enable              => True,
                                        IDLE_Interrupt_Enable           => False,
                                        RXNE_Interrupt_Enable           => True,
                                        Transmission_Complete_Interrupt => False,
                                        TXE_Interrupt_Enable            => False,
                                        PE_Interrupt_Enable             => False,
                                        Parity_Selection                => ODD,
                                        Parity_Control_Enable           => False,
                                        WakeUp_Method                   => IDLE_LINE,
                                        Length                          => EIGHT_BITS,
                                        USART_Enable                    => True,
                                        Oversampling_Mode               => OVERSAMPLING_BY_8);

   end Initialize_USART1;

begin
   Reset_Clocks;
   Initialize_Clocks;
   if USART_Enabled then
      Initialize_USART1 (115_200);
   end if;
end Setup_Pll;
