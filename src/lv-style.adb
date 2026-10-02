package body Lv.Style is

   function C_Pressed return Selector
     with Import, Convention => C, External_Name => "lvada_state_pressed";
   function C_Checked return Selector
     with Import, Convention => C, External_Name => "lvada_state_checked";
   function C_Disabled return Selector
     with Import, Convention => C, External_Name => "lvada_state_disabled";
   function C_Focused return Selector
     with Import, Convention => C, External_Name => "lvada_state_focused";
   function C_Indicator return Selector
     with Import, Convention => C, External_Name => "lvada_part_indicator";
   function C_Items return Selector
     with Import, Convention => C, External_Name => "lvada_part_items";
   function C_Scrollbar return Selector
     with Import, Convention => C, External_Name => "lvada_part_scrollbar";
   function C_Knob return Selector
     with Import, Convention => C, External_Name => "lvada_part_knob";
   function C_Cursor return Selector
     with Import, Convention => C, External_Name => "lvada_part_cursor";

   function Pressed return Selector is (C_Pressed);
   function Checked return Selector is (C_Checked);
   function Disabled return Selector is (C_Disabled);
   function Focused return Selector is (C_Focused);
   function Indicator return Selector is (C_Indicator);
   function Items return Selector is (C_Items);
   function Scrollbar return Selector is (C_Scrollbar);
   function Knob return Selector is (C_Knob);
   function Cursor return Selector is (C_Cursor);

   procedure Pad_All (O : Lv.Obj.Object; P : Coord; Sel : Selector := Main) is
   begin
      Pad (O, P, P, P, P, Sel);
   end Pad_All;

   procedure Pad_Hor_Ver (O : Lv.Obj.Object; Hor, Ver : Coord; Sel : Selector := Main) is
   begin
      Pad (O, Ver, Ver, Hor, Hor, Sel);
   end Pad_Hor_Ver;

end Lv.Style;
