package body Lv.Textarea is

   procedure Set_Text (Obj : Lv.Obj.Object; Text : String) is
      use Interfaces.C.Strings;
      C_Text : chars_ptr := New_String (Text);
   begin
      Set_Text_C (Obj, C_Text);
      Free (C_Text);
   end Set_Text;

   procedure Set_Placeholder_Text (Obj : Lv.Obj.Object; Text : String) is
      use Interfaces.C.Strings;
      C_Text : chars_ptr := New_String (Text);
   begin
      Set_Placeholder_Text_C (Obj, C_Text);
      Free (C_Text);
   end Set_Placeholder_Text;

   function Get_Text (Obj : Lv.Obj.Object) return String is
      use Interfaces.C.Strings;
      Result : constant chars_ptr := Get_Text_C (Obj);
   begin
      --  Ownership stays with the text area (a live pointer into its
      --  internal buffer): never freed here.
      if Result = Null_Ptr then
         return "";
      end if;
      return Value (Result);
   end Get_Text;

end Lv.Textarea;
