package body Lv.Tabview is

   function Add_Tab (Obj : Lv.Obj.Object; Name : String) return Lv.Obj.Object is
      use Interfaces.C.Strings;
      C_Name : chars_ptr := New_String (Name);
      Result : Lv.Obj.Object;
   begin
      --  lv_tabview_add_tab sets the tab button's label text from Name,
      --  which (like every other *_set_text in this binding) copies
      --  internally, so C_Name does not need to outlive this call.
      Result := Add_Tab_C (Obj, C_Name);
      Free (C_Name);
      return Result;
   end Add_Tab;

end Lv.Tabview;
