with Lv.Obj;

--  lv_button (widgets/lv_button.h). A button is a plain clickable
--  container in v9 -- give it a label as a child for text, the same way
--  the C API does (there is no lv_button_set_text).
package Lv.Button
is

   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_button_create";

end Lv.Button;
