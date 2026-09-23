with Interfaces.C;

--  Thin Ada binding to LVGL v9.6.0 (github.com/lvgl/lvgl).
--
--  This binds only the surface Sentinel's Phase 8 GUI screens need
--  (see homesec's docs/lvgl-v9-rewrite-scope.md for how that scope was
--  derived): core object/display/input-device/event/timer handling, and
--  the widgets label, button, image, table, list, slider, switch,
--  dropdown, textarea, and tabview. It is not a complete LVGL binding.
--
--  Every opaque LVGL C type (lv_obj_t, lv_display_t, ...) is bound as a
--  distinct type derived from System.Address: LVGL never lets Ada code
--  dereference these, only pass the pointer back and forth, so a derived
--  address type gives the same type-safety a real access type would
--  without the ceremony of a fake private record on the Ada side.
package Lv
is

   subtype Coord is Interfaces.C.int;      --  int32_t
   subtype UCoord is Interfaces.C.unsigned; --  uint32_t, e.g. zoom factors

   --  lv_result_t (lv_types.h): LV_RESULT_INVALID = 0, LV_RESULT_OK = 1.
   type Result is (Invalid, Ok)
     with Convention => C;

   procedure Init
     with Import => True, Convention => C, External_Name => "lv_init";

   procedure Deinit
     with Import => True, Convention => C, External_Name => "lv_deinit";

   function Is_Initialized return Interfaces.C.C_bool
     with Import => True, Convention => C, External_Name => "lv_is_initialized";

   --  Advances LVGL's internal tick count by Period_Ms milliseconds. The
   --  application must call this periodically (or install a tick source
   --  via lv_tick_set_cb, not bound here) for animations/timeouts to work.
   procedure Tick_Inc (Period_Ms : Interfaces.C.unsigned)
     with Import => True, Convention => C, External_Name => "lv_tick_inc";

   --  Runs pending LVGL timers (animations, redraw). Returns the number
   --  of milliseconds until it should be called again. Call this from the
   --  application's main loop.
   function Timer_Handler return Interfaces.C.unsigned
     with Import => True, Convention => C, External_Name => "lv_timer_handler";

end Lv;
