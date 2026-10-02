package body Lv.Label is

   procedure Set_Text (Obj : Lv.Obj.Object; Text : String) is
      use Interfaces.C.Strings;
      C_Text : chars_ptr := New_String (Text);
   begin
      --  lv_label_set_text copies the text internally, so C_Text does
      --  not need to outlive this call.
      Set_Text_C (Obj, C_Text);
      Free (C_Text);
   end Set_Text;

end Lv.Label;
