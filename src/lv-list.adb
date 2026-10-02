package body Lv.List is

   function Add_Text (List : Lv.Obj.Object; Text : String) return Lv.Obj.Object is
      use Interfaces.C.Strings;
      C_Text : chars_ptr := New_String (Text);
      Result : Lv.Obj.Object;
   begin
      --  lv_list_add_text copies the text internally (it forwards to
      --  lv_label_set_text), so C_Text does not need to outlive this
      --  call.
      Result := Add_Text_C (List, C_Text);
      Free (C_Text);
      return Result;
   end Add_Text;

   function Add_Button (List : Lv.Obj.Object; Text : String) return Lv.Obj.Object is
      use Interfaces.C.Strings;
      C_Text : chars_ptr := New_String (Text);
      Result : Lv.Obj.Object;
   begin
      Result := Add_Button_C (List, System.Null_Address, C_Text);
      Free (C_Text);
      return Result;
   end Add_Button;

end Lv.List;
