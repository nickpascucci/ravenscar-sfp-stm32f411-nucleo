package System.STM32F4.Flash_Registers is

   ---------------
   -- FLASH_ACR --
   ---------------

   --  Constants for FLASH ACR register
   FLASH_Base : constant := AHB1_Peripheral_Base + 16#3C00#;

   --  Wait states
   type Latencies is (LATENCY_0WS,
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

   for Latencies use (
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

   type Flash_ACR is record
      Latency : Latencies;
      PRFTEN : Boolean; -- Prefetch enable
      ICEN : Boolean; -- Instruction cache enable
      DCEN : Boolean; -- Data cache enable
      ICRST : Boolean; -- Instruction cache reset
      DCRST : Boolean; -- Data cache reset
   end record with Size => Bits_32'Size;
   for Flash_ACR use
      record
         Latency at 0 range 0 .. 3;
         PRFTEN at 0 range 8 .. 8;
         ICEN at 0 range 9 .. 9;
         DCEN at 0 range 10 .. 10;
         ICRST at 0 range 11 .. 11;
         DCRST at 0 range 12 .. 12;
      end record;

   type Flash_SR is record
      EOP : Boolean;
      OPERR : Boolean;
      WRPERR : Boolean;
      PGAERR : Boolean;
      PGPERR : Boolean;
      PGSERR : Boolean;
      RDERR : Boolean;
      BSY : Boolean;
   end record with Size => Bits_32'Size;
   for Flash_SR use
      record
         EOP at 0 range 0 .. 0;
         OPERR at 0 range 1 .. 1;
         WRPERR at 0 range 4 .. 4;
         PGAERR at 0 range 5 .. 5;
         PGPERR at 0 range 6 .. 6;
         PGSERR at 0 range 7 .. 7;
         RDERR at 0 range 8 .. 8;
         BSY at 0 range 16 .. 16;
      end record;

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
      PSIZE : Program_Size;
      STRT : Boolean;
      EOPIE : Boolean;
      ERRIE : Boolean;
      LOCK : Boolean;
   end record with Size => 32;
   for Flash_CR use
      record
         PG at 0 range 0 .. 0;
         SER at 0 range 1 .. 1;
         MER at 0 range 2 .. 2;
         SNB at 0 range 3 .. 6;
         PSIZE at 0 range 8 .. 9;
         STRT at 0 range 16 .. 16;
         EOPIE at 0 range 24 .. 24;
         ERRIE at 0 range 25 .. 25;
         LOCK at 0 range 31 .. 31;
      end record;

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
