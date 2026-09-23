package body Lv.Dropdown is

   procedure Set_Options (Obj : Lv.Obj.Object; Options : String) is
      use Interfaces.C.Strings;
      C_Options : chars_ptr := New_String (Options);
   begin
      --  lv_dropdown_set_options copies the string internally, so
      --  C_Options does not need to outlive this call.
      Set_Options_C (Obj, C_Options);
      Free (C_Options);
   end Set_Options;

end Lv.Dropdown;
