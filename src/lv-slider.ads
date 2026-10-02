with Interfaces.C;
with Lv.Obj;

--  lv_slider (widgets/lv_slider.h). Curated subset: create, value,
--  range. Used for Sentinel's PTZ pan/tilt/zoom controls.
package Lv.Slider
is

   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_slider_create";

   procedure Set_Value (Obj : Lv.Obj.Object; Value : Coord; Animate : Interfaces.C.C_bool)
     with Import => True, Convention => C, External_Name => "lv_slider_set_value";

   procedure Set_Range (Obj : Lv.Obj.Object; Min, Max : Coord)
     with Import => True, Convention => C, External_Name => "lv_slider_set_range";

   function Get_Value (Obj : Lv.Obj.Object) return Coord
     with Import => True, Convention => C, External_Name => "lv_slider_get_value";

end Lv.Slider;
