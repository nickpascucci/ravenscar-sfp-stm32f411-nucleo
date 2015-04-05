------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--                     A D A . N U M E R I C S . A U X                      --
--                                                                          --
--                                 S p e c                                  --
--                        (Machine Version for x86)                         --
--                                                                          --
--          Copyright (C) 1992-2013, Free Software Foundation, Inc.         --
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

--  This package provides the basic computational interface for the generic
--  elementary functions. This implementation is based on the glibc assembly
--  sources for the x86 glibc math library.

--  Note: there are two versions of this package. One using the 80-bit x86
--  long double format (which is this version), and one using 64-bit IEEE
--  double (see file a-numaux.ads). The latter version imports the C
--  routines directly.

package Ada.Numerics.Aux is
   pragma Pure;

   type Double is new Long_Long_Float;

   function Sin (X : Double) return Double;
   pragma Import (C, Sin, "sin");

   function Cos (X : Double) return Double;
   pragma Import (C, Cos, "cos");

   function Tan (X : Double) return Double;
   pragma Import (C, Tan, "tan");

   function Exp (X : Double) return Double;
   pragma Import (C, Exp, "exp");

   function Sqrt (X : Double) return Double;
   pragma Import (C, Sqrt, "sqrt");

   function Log (X : Double) return Double;
   pragma Import (C, Log, "log");

   function Atan (X : Double) return Double;
   pragma Import (C, Atan, "atan");

   function Acos (X : Double) return Double;
   pragma Import (C, Acos, "acos");

   function Asin (X : Double) return Double;
   pragma Import (C, Asin, "asin");

   function Sinh (X : Double) return Double;
   pragma Import (C, Sinh, "sinh");

   function Cosh (X : Double) return Double;
   pragma Import (C, Cosh, "cosh");

   function Tanh (X : Double) return Double;
   pragma Import (C, Tanh, "tan");

   function Pow (X, Y : Double) return Double;
   pragma Import (C, Pow, "pow");

private
   pragma Inline (Atan);
   pragma Inline (Cos);
   pragma Inline (Tan);
   pragma Inline (Exp);
   pragma Inline (Log);
   pragma Inline (Sin);
   pragma Inline (Sqrt);

end Ada.Numerics.Aux;
