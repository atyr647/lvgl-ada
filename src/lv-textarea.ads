with Interfaces.C;
with Interfaces.C.Strings;
with Lv.Obj;

--  lv_textarea (widgets/lv_textarea.h). Curated subset: create, text,
--  placeholder, one-line mode, password mode.
package Lv.Textarea
is

   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_textarea_create";

   procedure Set_Text_C (Obj : Lv.Obj.Object; Text : Interfaces.C.Strings.chars_ptr)
     with Import => True, Convention => C, External_Name => "lv_textarea_set_text";

   procedure Set_Text (Obj : Lv.Obj.Object; Text : String);

   procedure Set_Placeholder_Text_C
     (Obj : Lv.Obj.Object; Text : Interfaces.C.Strings.chars_ptr)
     with Import => True, Convention => C,
          External_Name => "lv_textarea_set_placeholder_text";

   procedure Set_Placeholder_Text (Obj : Lv.Obj.Object; Text : String);

   procedure Set_One_Line (Obj : Lv.Obj.Object; Enable : Interfaces.C.C_bool)
     with Import => True, Convention => C,
          External_Name => "lv_textarea_set_one_line";

   procedure Set_Password_Mode (Obj : Lv.Obj.Object; Enable : Interfaces.C.C_bool)
     with Import => True, Convention => C,
          External_Name => "lv_textarea_set_password_mode";

   function Get_Text_C (Obj : Lv.Obj.Object) return Interfaces.C.Strings.chars_ptr
     with Import => True, Convention => C, External_Name => "lv_textarea_get_text";

   function Get_Text (Obj : Lv.Obj.Object) return String;

end Lv.Textarea;
