with Interfaces.C;
with Lv.Obj;

--  Sizes, flex layout and scrolling (lv_obj_pos.h, lv_flex.h,
--  lv_obj_scroll.h), including the LV_PCT / LV_SIZE_CONTENT macros.
package Lv.Layout is

   --  Percent of the parent's size (LV_PCT).
   function Pct (V : Coord) return Coord
     with Import, Convention => C, External_Name => "lvada_pct";
   --  As big as the content (LV_SIZE_CONTENT).
   function Content return Coord
     with Import, Convention => C, External_Name => "lvada_size_content";

   procedure Set_Width (O : Lv.Obj.Object; W : Coord)
     with Import, Convention => C, External_Name => "lv_obj_set_width";
   procedure Set_Height (O : Lv.Obj.Object; H : Coord)
     with Import, Convention => C, External_Name => "lv_obj_set_height";

   type Flow is (Row, Column, Row_Wrap, Column_Wrap) with Convention => C;
   type Place is (Start, End_Of, Center, Space_Evenly, Space_Around, Space_Between)
     with Convention => C;

   --  Main: along the flow; Cross: across it; Track: wrapped lines.
   procedure Flex (O : Lv.Obj.Object; F : Flow; Main : Place := Start;
                   Cross : Place := Start; Track : Place := Start)
     with Import, Convention => C, External_Name => "lvada_flex";
   --  Share of the free space along the parent's flow (0 = fixed size).
   procedure Grow (O : Lv.Obj.Object; Weight : Interfaces.C.unsigned_char)
     with Import, Convention => C, External_Name => "lv_obj_set_flex_grow";

   type Scrollbar_Mode is (Off, On, Active, Auto) with Convention => C;
   procedure Scrollbar (O : Lv.Obj.Object; Mode : Scrollbar_Mode)
     with Import, Convention => C, External_Name => "lvada_scrollbar";
   type Scroll_Direction is (None, Vertical, Horizontal, Both) with Convention => C;
   procedure Scroll_Dir (O : Lv.Obj.Object; Dir : Scroll_Direction)
     with Import, Convention => C, External_Name => "lvada_scroll_dir";
   procedure Scroll_To_Y (O : Lv.Obj.Object; Y : Coord; Animated : Interfaces.C.int := 1)
     with Import, Convention => C, External_Name => "lvada_scroll_to_y";

   --  Removes the theme's styles and scrolling: a blank container.
   procedure Plain (O : Lv.Obj.Object)
     with Import, Convention => C, External_Name => "lvada_plain";

   --  Deletes all of O's children.
   procedure Clean (O : Lv.Obj.Object)
     with Import, Convention => C, External_Name => "lv_obj_clean";
   procedure Invalidate (O : Lv.Obj.Object)
     with Import, Convention => C, External_Name => "lv_obj_invalidate";
   procedure Move_Foreground (O : Lv.Obj.Object)
     with Import, Convention => C, External_Name => "lvada_move_foreground";
   --  Extra touch area around a small control, in px.
   procedure Ext_Click_Area (O : Lv.Obj.Object; Size : Coord)
     with Import, Convention => C, External_Name => "lv_obj_set_ext_click_area";
   procedure Fade_In (O : Lv.Obj.Object; Ms : Interfaces.C.unsigned; Delay_Ms : Interfaces.C.unsigned := 0)
     with Import, Convention => C, External_Name => "lvada_fade_in";

   procedure Update_Layout (O : Lv.Obj.Object)
     with Import, Convention => C, External_Name => "lv_obj_update_layout";
   function Content_Width (O : Lv.Obj.Object) return Coord
     with Import, Convention => C, External_Name => "lv_obj_get_content_width";
   function Content_Height (O : Lv.Obj.Object) return Coord
     with Import, Convention => C, External_Name => "lv_obj_get_content_height";

end Lv.Layout;
