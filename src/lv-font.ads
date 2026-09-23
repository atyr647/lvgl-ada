with System;
with Interfaces.C;

--  Fonts: LVGL's built-in Montserrat sizes, and TrueType fonts rendered
--  at any pixel size by TinyTTF (LV_USE_TINY_TTF) -- what keeps text
--  sharp on phone screens of every density.
package Lv.Font is

   type Font is new System.Address;
   No_Font : constant Font := Font (System.Null_Address);

   --  Data must stay allocated for as long as the font is used (TinyTTF
   --  reads glyph outlines from it on demand).
   function TTF (Data : System.Address; Length : Interfaces.C.size_t; Px : Coord) return Font
     with Import, Convention => C, External_Name => "lvada_ttf";
   procedure Destroy_TTF (F : Font)
     with Import, Convention => C, External_Name => "lvada_ttf_destroy";

   --  Characters F lacks (e.g. icons) are drawn from Fallback instead.
   procedure Set_Fallback (F : Font; Fallback : Font)
     with Import, Convention => C, External_Name => "lvada_font_fallback";

   function Line_Height (F : Font) return Coord
     with Import, Convention => C, External_Name => "lvada_font_line_height";

   --  Montserrat at 14, 16, 20, 24 or 28 px (others give 14).
   function Builtin (Px : Interfaces.C.int) return Font
     with Import, Convention => C, External_Name => "lvada_builtin_font";

end Lv.Font;
