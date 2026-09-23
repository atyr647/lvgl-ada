with Interfaces.C;
with Interfaces.C.Strings;
with Lv.Obj;

--  lv_tabview (widgets/lv_tabview.h). Curated subset: create, add a
--  tab (returns its content container Obj), switch the active tab.
package Lv.Tabview
is

   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_tabview_create";

   function Add_Tab_C
     (Obj : Lv.Obj.Object; Name : Interfaces.C.Strings.chars_ptr) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_tabview_add_tab";

   --  Returns the new tab's content container -- add widgets to it as
   --  its children, the same way the C API does.
   function Add_Tab (Obj : Lv.Obj.Object; Name : String) return Lv.Obj.Object;

   --  lv_anim_enable_t is `typedef bool` in LVGL: True animates the
   --  switch, False jumps immediately.
   procedure Set_Active
     (Obj : Lv.Obj.Object; Index : Interfaces.C.unsigned; Animate : Interfaces.C.C_bool)
     with Import => True, Convention => C, External_Name => "lv_tabview_set_active";

   function Get_Tab_Count (Obj : Lv.Obj.Object) return Interfaces.C.unsigned
     with Import => True, Convention => C,
          External_Name => "lv_tabview_get_tab_count";

   function Get_Tab_Active (Obj : Lv.Obj.Object) return Interfaces.C.unsigned
     with Import => True, Convention => C,
          External_Name => "lv_tabview_get_tab_active";

end Lv.Tabview;
