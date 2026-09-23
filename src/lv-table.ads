with Interfaces.C;
with Interfaces.C.Strings;
with Lv.Obj;

--  lv_table (widgets/lv_table.h). Curated subset: create, cell
--  value/count/width setters and getters.
package Lv.Table
is

   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_table_create";

   procedure Set_Cell_Value_C
     (Obj : Lv.Obj.Object; Row, Col : Interfaces.C.unsigned;
      Text : Interfaces.C.Strings.chars_ptr)
     with Import => True, Convention => C,
          External_Name => "lv_table_set_cell_value";

   procedure Set_Cell_Value
     (Obj : Lv.Obj.Object; Row, Col : Natural; Text : String);

   procedure Set_Row_Count (Obj : Lv.Obj.Object; Count : Interfaces.C.unsigned)
     with Import => True, Convention => C,
          External_Name => "lv_table_set_row_count";

   procedure Set_Column_Count (Obj : Lv.Obj.Object; Count : Interfaces.C.unsigned)
     with Import => True, Convention => C,
          External_Name => "lv_table_set_column_count";

   procedure Set_Column_Width
     (Obj : Lv.Obj.Object; Col : Interfaces.C.unsigned; Width : Coord)
     with Import => True, Convention => C,
          External_Name => "lv_table_set_column_width";

   function Get_Cell_Value_C
     (Obj : Lv.Obj.Object; Row, Col : Interfaces.C.unsigned)
      return Interfaces.C.Strings.chars_ptr
     with Import => True, Convention => C,
          External_Name => "lv_table_get_cell_value";

   function Get_Cell_Value (Obj : Lv.Obj.Object; Row, Col : Natural) return String;

   function Get_Row_Count (Obj : Lv.Obj.Object) return Interfaces.C.unsigned
     with Import => True, Convention => C,
          External_Name => "lv_table_get_row_count";

   function Get_Column_Count (Obj : Lv.Obj.Object) return Interfaces.C.unsigned
     with Import => True, Convention => C,
          External_Name => "lv_table_get_column_count";

end Lv.Table;
