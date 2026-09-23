with Lv.Obj;

--  lv_switch (widgets/lv_switch.h). A switch is a checkable Obj: read/
--  write its on/off value with Lv.Obj.Add_State/Remove_State/Has_State
--  and Lv.Obj.State_Checked, and watch Lv.Event.Event_Value_Changed --
--  there is no separate lv_switch_set_value in the C API.
package Lv.Switch
is

   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_switch_create";

end Lv.Switch;
