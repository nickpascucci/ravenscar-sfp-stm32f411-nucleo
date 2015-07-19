package System.STM32F4.GPIO is

   ----------
   -- GPIO --
   ----------

   --------------
   -- Adresses --
   --------------
   GPIOH_Base : constant := AHB1_Peripheral_Base + 16#1C00#;
   GPIOE_Base : constant := AHB1_Peripheral_Base + 16#1000#;
   GPIOD_Base : constant := AHB1_Peripheral_Base + 16#0C00#;
   GPIOC_Base : constant := AHB1_Peripheral_Base + 16#0800#;
   GPIOB_Base : constant := AHB1_Peripheral_Base + 16#0400#;
   GPIOA_Base : constant := AHB1_Peripheral_Base + 16#0000#;

   -----------
   -- Types --
   -----------

   type IO_Index is range 0 .. 15;

   --  MODER enum
   type MODER is (Mode_IN, Mode_OUT, Mode_AF, Mode_AN)
     with Size => Bits_2'Size;
   for MODER use (Mode_IN => 0,
                  Mode_OUT => 1,
                  Mode_AF => 2,
                  Mode_AN => 3);

   type MODER_IOs is array (IO_Index) of MODER
     with Pack;

   --  OTYPER enum
   type OTYPER is (Type_PP, Type_OD) with Size => 1;
   for OTYPER use (Type_PP => 0,
                   Type_OD => 1);

   type OTYPER_IOs is array (IO_Index) of OTYPER
     with Pack;

   --  OSPEEDR enum
   type OSPEEDR is (Speed_4MHz, -- Low speed
                    Speed_25MHz, -- Medium speed
                    Speed_50MHz, -- Fast speed
                    Speed_100MHz -- High speed on 30pF, 80MHz on 15
                   )
     with Size => Bits_2'Size;

   for OSPEEDR use (Speed_4MHz => 0,
                    Speed_25MHz => 1,
                    Speed_50MHz => 2,
                    Speed_100MHz => 3);

   type OSPEEDR_IOs is array (IO_Index) of OSPEEDR
     with Pack;

   --  PUPDR enum
   type PUPDR is (No_Pull, Pull_Up, Pull_Down)
     with Size => Bits_2'Size;
   for PUPDR use (No_Pull => 0,
                  Pull_Up => 1,
                  Pull_Down => 2);

   type PUPDR_IOs is array (IO_Index) of PUPDR with Pack;

   type Inputs is array (IO_Index) of Boolean with Pack;
   type Outputs is array (IO_Index) of Boolean with Pack;

   type LCKn is array (IO_Index) of Boolean with Pack;

   --  AFL constants
   AF_USART1    : constant Bits_4 := 7;
   AF_USART2    : constant Bits_4 := 7;

   --  Register definition
   type GPIO_Register is record
      MODER   : MODER_IOs := (others => GPIO.Mode_AN);
      OTYPER  : OTYPER_IOs := (others => GPIO.Type_PP);

      OSPEEDR : OSPEEDR_IOs := (others => GPIO.Speed_4MHz);
      PUPDR   : PUPDR_IOs := (others => GPIO.No_Pull);

      IDR     : Inputs := (others => False);

      ODR     : Outputs := (others => False);

      BSRR    : Word := 16#0000#;

      LCKR    : LCKn := (others => False);
      LCKK    : Boolean := False;

      AFRL    : Bits_8x4 := (others => GPIO.AF_USART1);
      AFRH    : Bits_8x4 := (others => GPIO.AF_USART1);
   end record;

   for GPIO_Register use
      record
         MODER at 0 range 0 .. 31;
         OTYPER at 1 * Word'Size range 0 .. 15;
         OSPEEDR at 2 * Word'Size range 0 .. 31;
         PUPDR at 3 * Word'Size range 0 .. 31;
         IDR at 4 * Word'Size range 0 .. 15;
         ODR at 5 * Word'Size range 0 .. 15;
         BSRR at 6 * Word'Size range 0 .. 31;
         LCKR at 7 * Word'Size range 0 .. 15;
         LCKK at 7 * Word'Size range 16 .. 16;
         AFRL at 8 * Word'Size range 0 .. 31;
         AFRH at 9 * Word'Size range 0 .. 31;
      end record;

   GPIOA : GPIO_Register
     with Volatile, Address => System'To_Address (GPIOA_Base);

   pragma Import (Ada, GPIOA);

   GPIOB : GPIO_Register with Volatile,
                               Address => System'To_Address (GPIOB_Base);
   pragma Import (Ada, GPIOB);

   GPIOC : GPIO_Register with Volatile,
                               Address => System'To_Address (GPIOC_Base);
   pragma Import (Ada, GPIOC);

   GPIOD : GPIO_Register with Volatile,
                               Address => System'To_Address (GPIOD_Base);
   pragma Import (Ada, GPIOD);

   GPIOE : GPIO_Register with Volatile,
                               Address => System'To_Address (GPIOE_Base);
   pragma Import (Ada, GPIOE);

   GPIOH : GPIO_Register with Volatile,
                               Address => System'To_Address (GPIOH_Base);
   pragma Import (Ada, GPIOH);

end System.STM32F4.GPIO;
