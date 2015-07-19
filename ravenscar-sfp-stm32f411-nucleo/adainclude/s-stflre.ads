package System.STM32F4.Flash_Registers is

   ---------------
   -- FLASH_ACR --
   ---------------

   --  Constants for FLASH ACR register
   FLASH_Base : constant := AHB1_Peripheral_Base + 16#3C00#;

   --  Wait states
   type Latency is (LATENCY_0WS,
                    LATENCY_1WS,
                    LATENCY_2WS,
                    LATENCY_3WS,
                    LATENCY_4WS,
                    LATENCY_5WS,
                    LATENCY_6WS,
                    LATENCY_7WS,
                    LATENCY_8WS,
                    LATENCY_9WS,
                    LATENCY_10WS,
                    LATENCY_11WS,
                    LATENCY_12WS,
                    LATENCY_13WS,
                    LATENCY_14WS,
                    LATENCY_15WS)
     with Size => 4;

   for Latency use (
                    LATENCY_0WS => 0,
                    LATENCY_1WS => 1,
                    LATENCY_2WS => 2,
                    LATENCY_3WS => 3,
                    LATENCY_4WS => 4,
                    LATENCY_5WS => 5,
                    LATENCY_6WS => 6,
                    LATENCY_7WS => 7,
                    LATENCY_8WS => 8,
                    LATENCY_9WS => 9,
                    LATENCY_10WS => 10,
                    LATENCY_11WS => 11,
                    LATENCY_12WS => 12,
                    LATENCY_13WS => 13,
                    LATENCY_14WS => 14,
                    LATENCY_15WS => 15
                   );

   type Padding_ACR is mod 2**19 with Size => 19;

   type Flash_ACR is record
      Latencies : Latency;
      RESERVED_4BITS : Bits_4;

      PRFTEN : Boolean; -- Prefetch enable
      ICEN : Boolean; -- Instruction cache enable
      DCEN : Boolean; -- Data cache enable
      ICRST : Boolean; -- Instruction cache reset
      DCRST : Boolean; -- Data cache reset

      RESERVED_PADDING : Padding_ACR;
   end record with Size => 32, Pack;

   type Flash_SR is record
      EOP : Boolean;
      OPERR : Boolean;
      RESERVED_2BITS : Bits_2;
      WRPERR : Boolean;
      PGAERR : Boolean;
      PGPERR : Boolean;
      PGSERR : Boolean;
      RDERR : Boolean;
      RESERVED_7 : Padding_7;
      BSY : Boolean;
      PADDED_15 : Padding_15;
   end record with Size => 32, Pack;

   type Sector_Number is (SECTOR_0, SECTOR_1, SECTOR_2, SECTOR_3, SECTOR_4,
                          SECTOR_5, SECTOR_6, SECTOR_7, USR_SPECIFIC_SECTOR,
                          USR_CONFIG_SECTOR) with Size => 4;
   for Sector_Number use
     (
      SECTOR_0 => 2#0000#,
      SECTOR_1 => 2#0001#,
      SECTOR_2 => 2#0010#,
      SECTOR_3 => 2#0011#,
      SECTOR_4 => 2#0100#,
      SECTOR_5 => 2#0101#,
      SECTOR_6 => 2#0110#,
      SECTOR_7 => 2#0111#,
      USR_SPECIFIC_SECTOR => 2#1100#,
      USR_CONFIG_SECTOR => 2#1101#
     );

   type Program_Size is (x8, x16, x32, x64) with Size => 2;
   for Program_Size use
     (
      x8 => 2#00#,
      x16 => 2#01#,
      x32 => 2#10#,
      x64 => 2#11#
     );

   type Flash_CR is record
      PG : Boolean;
      SER : Boolean;
      MER : Boolean;
      SNB : Sector_Number;
      RESERVED : Boolean;
      PSIZE : Program_Size;
      RESERVED_5_1 : Padding_5;
      STRT : Boolean;
      RESERVED_7 : Padding_7;
      EOPIE : Boolean;
      ERRIE : Boolean;
      RESERVED_5_2 : Padding_5;
      LOCK : Boolean;
   end record with Size => 32, Pack;

   type FLASH_Register is record
      ACR     : Flash_ACR;
      KEYR    : Word;
      OPTKEYR : Word;
      SR      : Flash_SR;
      CR      : Flash_CR;
      OPTCR   : Word;
   end record;

   Flash : FLASH_Register with Volatile,
                                Address => System'To_Address (FLASH_Base);
   pragma Import (Ada, Flash);

end System.STM32F4.Flash_Registers;
