with Lv.Obj;

--  lv_keyboard: an on-screen keyboard that types into a text area.
package Lv.Keyboard is
   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import, Convention => C, External_Name => "lv_keyboard_create";
   procedure Set_Textarea (Kb, Ta : Lv.Obj.Object)
     with Import, Convention => C, External_Name => "lv_keyboard_set_textarea";
   type Mode is (Text, Number) with Convention => C;
   procedure Set_Mode (Kb : Lv.Obj.Object; M : Mode)
     with Import, Convention => C, External_Name => "lvada_keyboard_mode";
end Lv.Keyboard;
