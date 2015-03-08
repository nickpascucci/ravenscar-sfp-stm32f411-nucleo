gnat-stm32f411-nucleo
=====================

Port of the Ada Ravenscar runtime library from STM32F429IDISCOVERY to
STM32F411 Nucleo boards.

This port was adapted from the STM32F429I port here, which adapted the
original Adacore Ravenscar code to the Discovery board:
https://github.com/gnlnops/gnat-stm32f429i-disco

Porting to the F411 was made much easier by gnlnops' work because
the STM32F429I and STM32F411 are quite similar.

Abstract
--------

The GNAT Ada GPL 2014 is provided with an ARM cross compiler. The
toolchain is delivered with an Ada runtime library and examples for
"STM32F4 Discovery" kit. This project handles the port of the provided
Ada runtime library for the STM32F411 Nucleo board - an Arduino
compatible prototyping board. It contains the modified Ada runtime
library. An adaptation of the standard blink demo can be found at
https://github.com/nickpascucci/stm32f411-gnat-blink/

Description
-----------

The repository contains the modified version of AdaCore's Ada runtime
profile (ravenscar-sfp-stm32f4). The original version of the runtime
is usually located in "GNATPATH/lib/gnat/arm-eabi/" and
"GNATPATH/share/examples/gnat-cross/" of GNAT Ada GPL 2014 for ARM
ELF.

To use the runtime, You have to build the provided Ada runtime
library:
- Enter the Ada runtime library directory.
- Start the build process by launching the command
  ```gprbuild -p -P runtime_build.gpr```.

The GNAT Ada GPL 2014 for ARM ELF format is available at http://libre.adacore.com.
