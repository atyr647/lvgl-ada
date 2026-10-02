package body Lv.Table is

   procedure Set_Cell_Value
     (Obj : Lv.Obj.Object; Row, Col : Natural; Text : String)
   is
      use Interfaces.C.Strings;
      C_Text : chars_ptr := New_String (Text);
   begin
      --  lv_table_set_cell_value copies the text internally, so C_Text
      --  does not need to outlive this call.
      Set_Cell_Value_C
        (Obj, Interfaces.C.unsigned (Row), Interfaces.C.unsigned (Col), C_Text);
      Free (C_Text);
   end Set_Cell_Value;

   function Get_Cell_Value (Obj : Lv.Obj.Object; Row, Col : Natural) return String
   is
      use Interfaces.C.Strings;
      Result : constant chars_ptr :=
        Get_Cell_Value_C
          (Obj, Interfaces.C.unsigned (Row), Interfaces.C.unsigned (Col));
   begin
      --  Ownership stays with the table (this is a live pointer into its
      --  internal storage, not a copy handed to the caller), so this
      --  wrapper only reads it -- never frees Result.
      if Result = Null_Ptr then
         return "";
      end if;
      return Value (Result);
   end Get_Cell_Value;

end Lv.Table;
