with Interfaces.C;
with Interfaces.C.Strings;
with Lv.Obj;

--  lv_dropdown (widgets/lv_dropdown.h). Curated subset: create, options
--  (a single "\n"-separated string, per the C API's own convention),
--  selected index.
package Lv.Dropdown
is

   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_dropdown_create";

   procedure Set_Options_C
     (Obj : Lv.Obj.Object; Options : Interfaces.C.Strings.chars_ptr)
     with Import => True, Convention => C,
          External_Name => "lv_dropdown_set_options";

   --  Options is "\n"-separated, e.g. "Preset 1\nPreset 2\nPreset 3".
   procedure Set_Options (Obj : Lv.Obj.Object; Options : String);

   procedure Set_Selected (Obj : Lv.Obj.Object; Selected : Interfaces.C.unsigned)
     with Import => True, Convention => C,
          External_Name => "lv_dropdown_set_selected";

   function Get_Selected (Obj : Lv.Obj.Object) return Interfaces.C.unsigned
     with Import => True, Convention => C,
          External_Name => "lv_dropdown_get_selected";

end Lv.Dropdown;
