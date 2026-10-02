with Interfaces.C;
with Lv.Obj;

--  lv_bar: a progress/level bar.
package Lv.Bar is
   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import, Convention => C, External_Name => "lv_bar_create";
   procedure Set_Range (Bar : Lv.Obj.Object; Min, Max : Coord)
     with Import, Convention => C, External_Name => "lv_bar_set_range";
   procedure Set_Value (Bar : Lv.Obj.Object; V : Coord; Animated : Interfaces.C.int := 1)
     with Import, Convention => C, External_Name => "lvada_bar_value";
end Lv.Bar;
