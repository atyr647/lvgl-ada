with System;
with Interfaces.C;

--  lv_timer (misc/lv_timer.h): callbacks run by Lv.Timer_Handler on the
--  LVGL thread -- the one safe place to touch widgets from.
package Lv.Timer is

   type Timer is new System.Address;

   type Callback is access procedure (T : Timer) with Convention => C;

   function Create (Cb : Callback; Period_Ms : Interfaces.C.unsigned;
                    User_Data : System.Address := System.Null_Address) return Timer
     with Import, Convention => C, External_Name => "lv_timer_create";
   procedure Delete (T : Timer)
     with Import, Convention => C, External_Name => "lv_timer_delete";
   procedure Set_Period (T : Timer; Period_Ms : Interfaces.C.unsigned)
     with Import, Convention => C, External_Name => "lv_timer_set_period";
   --  Run it on the next Timer_Handler call.
   procedure Ready (T : Timer)
     with Import, Convention => C, External_Name => "lv_timer_ready";
   function User_Data (T : Timer) return System.Address
     with Import, Convention => C, External_Name => "lv_timer_get_user_data";

end Lv.Timer;
