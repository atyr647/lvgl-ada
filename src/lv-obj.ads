with System;
with Interfaces.C;

--  lv_obj_t: the base widget every LVGL v9 widget (label, button, ...) is
--  built on. Widget-specific packages (Lv.Label, Lv.Button, ...) return
--  and accept this same Obj type, exactly as the C API does.
package Lv.Obj
is

   type Object is new System.Address;
   Null_Object : constant Object := Object (System.Null_Address);

   function Create (Parent : Object) return Object
     with Import => True, Convention => C, External_Name => "lv_obj_create";

   procedure Delete (Obj : Object)
     with Import => True, Convention => C, External_Name => "lv_obj_delete";

   function Get_Parent (Obj : Object) return Object
     with Import => True, Convention => C, External_Name => "lv_obj_get_parent";

   function Get_Child (Obj : Object; Index : Interfaces.C.int) return Object
     with Import => True, Convention => C, External_Name => "lv_obj_get_child";

   --  The active screen of the default display -- the usual root parent
   --  for top-level widgets.
   function Screen_Active return Object
     with Import => True, Convention => C, External_Name => "lv_screen_active";

   ----------------------------------------------------------------
   --  Position and size (lv_obj_pos.h)
   ----------------------------------------------------------------

   procedure Set_Pos (Obj : Object; X, Y : Coord)
     with Import => True, Convention => C, External_Name => "lv_obj_set_pos";

   procedure Set_Size (Obj : Object; W, H : Coord)
     with Import => True, Convention => C, External_Name => "lv_obj_set_size";

   function Get_X (Obj : Object) return Coord
     with Import => True, Convention => C, External_Name => "lv_obj_get_x";

   function Get_Y (Obj : Object) return Coord
     with Import => True, Convention => C, External_Name => "lv_obj_get_y";

   function Get_Width (Obj : Object) return Coord
     with Import => True, Convention => C, External_Name => "lv_obj_get_width";

   function Get_Height (Obj : Object) return Coord
     with Import => True, Convention => C, External_Name => "lv_obj_get_height";

   --  lv_align_t (lv_area.h): a clean, gap-free 0-based C enum, safe to
   --  mirror directly as an Ada enumeration in the same declared order.
   type Align is
     (Default,
      Top_Left, Top_Mid, Top_Right,
      Bottom_Left, Bottom_Mid, Bottom_Right,
      Left_Mid, Right_Mid,
      Center,
      Out_Top_Left, Out_Top_Mid, Out_Top_Right,
      Out_Bottom_Left, Out_Bottom_Mid, Out_Bottom_Right,
      Out_Left_Top, Out_Left_Mid, Out_Left_Bottom,
      Out_Right_Top, Out_Right_Mid, Out_Right_Bottom)
     with Convention => C;

   procedure Set_Align (Obj : Object; A : Align)
     with Import => True, Convention => C, External_Name => "lv_obj_set_align";

   procedure Align_Obj (Obj : Object; A : Align; X_Ofs, Y_Ofs : Coord)
     with Import => True, Convention => C, External_Name => "lv_obj_align";

   procedure Align_To
     (Obj : Object; Base : Object; A : Align; X_Ofs, Y_Ofs : Coord)
     with Import => True, Convention => C, External_Name => "lv_obj_align_to";

   ----------------------------------------------------------------
   --  Flags (lv_obj.h, LV_OBJ_FLAG_*): a bitmask enum (each value is
   --  1 << n), so it is bound as named Unsigned_32 constants rather than
   --  an Ada enumeration -- flags are combined with "or", which a plain
   --  enumeration type cannot express.
   ----------------------------------------------------------------

   subtype Flag is Interfaces.Unsigned_32;

   Flag_Hidden          : constant Flag := 2#0000_0000_0000_0001#;
   Flag_Clickable       : constant Flag := 2#0000_0000_0000_0010#;
   Flag_Click_Focusable : constant Flag := 2#0000_0000_0000_0100#;
   Flag_Checkable       : constant Flag := 2#0000_0000_0000_1000#;
   Flag_Scrollable      : constant Flag := 2#0000_0000_0001_0000#;
   Flag_Event_Bubble    : constant Flag := 2#0100_0000_0000_0000#;

   procedure Add_Flag (Obj : Object; F : Flag)
     with Import => True, Convention => C, External_Name => "lv_obj_add_flag";

   procedure Remove_Flag (Obj : Object; F : Flag)
     with Import => True, Convention => C, External_Name => "lv_obj_remove_flag";

   function Has_Flag (Obj : Object; F : Flag) return Interfaces.C.C_bool
     with Import => True, Convention => C, External_Name => "lv_obj_has_flag";

   ----------------------------------------------------------------
   --  State (lv_obj.h / lv_style_gen.h, LV_STATE_*): also a bitmask.
   ----------------------------------------------------------------

   subtype State is Interfaces.Unsigned_16;

   State_Default  : constant State := 16#0000#;
   State_Checked  : constant State := 16#0004#;
   State_Focused  : constant State := 16#0008#;
   State_Pressed  : constant State := 16#0080#;
   State_Disabled : constant State := 16#0200#;

   procedure Add_State (Obj : Object; S : State)
     with Import => True, Convention => C, External_Name => "lv_obj_add_state";

   procedure Remove_State (Obj : Object; S : State)
     with Import => True, Convention => C, External_Name => "lv_obj_remove_state";

   function Has_State (Obj : Object; S : State) return Interfaces.C.C_bool
     with Import => True, Convention => C, External_Name => "lv_obj_has_state";

   ----------------------------------------------------------------
   --  User data (a generic escape hatch used by the event callbacks in
   --  Lv.Event to recover an Ada-side context from a C callback).
   ----------------------------------------------------------------

   procedure Set_User_Data (Obj : Object; Data : System.Address)
     with Import => True, Convention => C, External_Name => "lv_obj_set_user_data";

   function Get_User_Data (Obj : Object) return System.Address
     with Import => True, Convention => C, External_Name => "lv_obj_get_user_data";

   ----------------------------------------------------------------
   --  Color (draw/lv_color.h): lv_color_t is a 3-byte {blue, green, red}
   --  struct (LVGL's default RGB888 color format), not a scalar -- bound
   --  field-for-field, in the same order, with Convention => C so it is
   --  passed/returned exactly as the C ABI expects for a 3-byte struct.
   ----------------------------------------------------------------

   type Color is record
      Blue  : Interfaces.Unsigned_8;
      Green : Interfaces.Unsigned_8;
      Red   : Interfaces.Unsigned_8;
   end record
     with Convention => C;

   --  Builds a Color from a 0xRRGGBB literal, the same way LVGL's own
   --  lv_color_hex() convenience macro does.
   function Color_Hex (Hex : Interfaces.Unsigned_32) return Color
     with Import => True, Convention => C, External_Name => "lv_color_hex";

   subtype Style_Selector is Interfaces.C.unsigned;

   ----------------------------------------------------------------
   --  A handful of the most common direct style setters
   --  (lv_obj_style_gen.h). Not exhaustive -- see this package's header
   --  comment on scope.
   ----------------------------------------------------------------

   procedure Set_Style_Bg_Color
     (Obj : Object; Value : Color; Selector : Style_Selector)
     with Import => True, Convention => C,
          External_Name => "lv_obj_set_style_bg_color";

   procedure Set_Style_Text_Color
     (Obj : Object; Value : Color; Selector : Style_Selector)
     with Import => True, Convention => C,
          External_Name => "lv_obj_set_style_text_color";

end Lv.Obj;
