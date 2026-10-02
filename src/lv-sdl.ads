with Interfaces.C;
with Interfaces.C.Strings;
with Lv.Display;
with Lv.Indev;

--  LVGL's own built-in SDL2 display/input driver
--  (drivers/sdl/lv_sdl_window.h, lv_sdl_mouse.h, lv_sdl_keyboard.h),
--  requires LV_USE_SDL 1 in lv_conf.h.
--
--  This is a bring-up/testing convenience, not the production display
--  path: FROZEN.md S47 names SDLada as Sentinel's platform backend, and
--  the production path is Lv.Display's manual driver (Set_Buffers /
--  Set_Flush_Cb) fed from a real SDLada window/renderer, not this
--  package. Lv.Sdl exists so the binding can be exercised end to end
--  (window, widgets, mouse/keyboard) without writing that glue first.
package Lv.Sdl
is

   function Window_Create (Hor_Res, Ver_Res : Coord) return Lv.Display.Display
     with Import => True, Convention => C, External_Name => "lv_sdl_window_create";

   procedure Set_Title (Disp : Lv.Display.Display; Title : Interfaces.C.Strings.chars_ptr)
     with Import => True, Convention => C, External_Name => "lv_sdl_window_set_title";

   procedure Set_Size (Disp : Lv.Display.Display; Hor_Res, Ver_Res : Coord)
     with Import => True, Convention => C, External_Name => "lv_sdl_window_set_size";

   procedure Set_Resizeable (Disp : Lv.Display.Display; Value : Interfaces.C.C_bool)
     with Import => True, Convention => C,
          External_Name => "lv_sdl_window_set_resizeable";

   function Mouse_Create return Lv.Indev.Indev
     with Import => True, Convention => C, External_Name => "lv_sdl_mouse_create";

   function Keyboard_Create return Lv.Indev.Indev
     with Import => True, Convention => C, External_Name => "lv_sdl_keyboard_create";

   procedure Quit
     with Import => True, Convention => C, External_Name => "lv_sdl_quit";

end Lv.Sdl;
