with System;
with Interfaces.C.Strings;
with Lv.Obj;

--  lv_list (widgets/lv_list.h). Curated subset: create, add a text
--  section header, add a button row (with an optional icon).
--
--  Note: lv_list itself is marked LV_DEPRECATED in v9.6.0's header --
--  it still works, but upstream's own recommendation is a flex
--  container of Lv.Label/Lv.Button widgets instead (see
--  lv_example_flex_list in the LVGL examples). Bound as-is because it
--  is simpler for Phase 8's Cameras/Events/Sensors screens today; a
--  future revision of this binding should migrate off it before it is
--  removed upstream.
package Lv.List
is

   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_list_create";

   function Add_Text_C
     (List : Lv.Obj.Object; Text : Interfaces.C.Strings.chars_ptr) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_list_add_text";

   function Add_Text (List : Lv.Obj.Object; Text : String) return Lv.Obj.Object;

   function Add_Button_C
     (List : Lv.Obj.Object; Icon : System.Address; Text : Interfaces.C.Strings.chars_ptr)
      return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_list_add_button";

   --  Icon is the raw C entry point's `const void * icon` (a symbol
   --  string such as LV_SYMBOL_OK, or NULL for no icon); this
   --  convenience wrapper only covers the no-icon case.
   function Add_Button (List : Lv.Obj.Object; Text : String) return Lv.Obj.Object;

end Lv.List;
