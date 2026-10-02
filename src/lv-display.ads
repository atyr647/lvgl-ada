with System;
with Interfaces.C;

--  lv_display_t (display/lv_display.h). Covers the manual-driver path
--  (Create/Set_Buffers/Set_Flush_Cb/Flush_Ready) used when wiring LVGL to
--  a real framebuffer (e.g. via SDLada, per FROZEN.md S47) -- Lv.Sdl
--  covers LVGL's own built-in SDL2 driver, used for bring-up/testing.
package Lv.Display
is

   type Display is new System.Address;

   --  lv_display_render_mode_t: clean 0-based C enum.
   type Render_Mode is (Partial, Direct, Full)
     with Convention => C;

   function Create (Hor_Res, Ver_Res : Coord) return Display
     with Import => True, Convention => C, External_Name => "lv_display_create";

   procedure Set_Default (Disp : Display)
     with Import => True, Convention => C, External_Name => "lv_display_set_default";

   procedure Set_Resolution (Disp : Display; Hor_Res, Ver_Res : Coord)
     with Import => True, Convention => C,
          External_Name => "lv_display_set_resolution";

   function Get_Horizontal_Resolution (Disp : Display) return Coord
     with Import => True, Convention => C,
          External_Name => "lv_display_get_horizontal_resolution";

   function Get_Vertical_Resolution (Disp : Display) return Coord
     with Import => True, Convention => C,
          External_Name => "lv_display_get_vertical_resolution";

   procedure Set_Buffers
     (Disp             : Display;
      Buf1             : System.Address;
      Buf2             : System.Address;
      Buf_Size         : Interfaces.C.unsigned;
      Render_Mode_Kind : Render_Mode)
     with Import => True, Convention => C, External_Name => "lv_display_set_buffers";

   type Flush_Callback is access procedure
     (Disp : Display; Area : System.Address; Px_Map : System.Address)
     with Convention => C;

   procedure Set_Flush_Cb (Disp : Display; Cb : Flush_Callback)
     with Import => True, Convention => C,
          External_Name => "lv_display_set_flush_cb";

   --  Must be called from (or at the end of) the flush callback to tell
   --  LVGL the frame in Px_Map has been sent to the physical display.
   procedure Flush_Ready (Disp : Display)
     with Import => True, Convention => C,
          External_Name => "lv_display_flush_ready";

end Lv.Display;
