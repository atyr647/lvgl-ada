with Interfaces.C;
with Lv.Obj;
with Lv.Font;

--  Local style properties (lv_obj_style_gen.h), set on one object at a
--  time. Colors are 0xRRGGBB, opacity 0 (transparent) .. 255 (opaque),
--  and Sel picks the part/state the value applies to (Main by default;
--  "or" a part with a state, e.g. Main or Pressed). Implemented by the
--  C helpers in lv_ada_helpers.c, which take colors as integers, so no
--  lv_color_t struct ever crosses the Ada/C boundary by value.
package Lv.Style is

   subtype RGB is Interfaces.C.unsigned;
   subtype Opacity is Interfaces.C.unsigned range 0 .. 255;
   subtype Selector is Interfaces.C.unsigned;

   Opaque      : constant Opacity := 255;
   Transparent : constant Opacity := 0;

   Main : constant Selector := 0;
   function Pressed return Selector;
   function Checked return Selector;
   function Disabled return Selector;
   function Focused return Selector;
   function Indicator return Selector;   --  bar fill, spinner arc, switch on-part
   function Items return Selector;       --  keyboard/list items
   function Scrollbar return Selector;
   function Knob return Selector;
   function Cursor return Selector;


   procedure Bg (O : Lv.Obj.Object; Color : RGB; Opa : Opacity := Opaque; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_bg";

   type Direction is (Vertical, Horizontal) with Convention => C;
   --  Gradient from the Bg color to Color.
   procedure Bg_Gradient (O : Lv.Obj.Object; Color : RGB; Dir : Direction := Vertical;
                          Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_bg_grad";

   procedure Text (O : Lv.Obj.Object; Color : RGB; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_text";
   procedure Text_Opa (O : Lv.Obj.Object; Opa : Opacity; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_text_opa";
   procedure Font (O : Lv.Obj.Object; F : Lv.Font.Font; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_font";

   type Text_Alignment is (Left, Center, Right) with Convention => C;
   procedure Text_Align (O : Lv.Obj.Object; A : Text_Alignment; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_text_align";
   procedure Letter_Space (O : Lv.Obj.Object; Px : Coord; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_letter_space";
   procedure Line_Space (O : Lv.Obj.Object; Px : Coord; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_line_space";

   procedure Radius (O : Lv.Obj.Object; R : Coord; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_radius";
   function Circle return Coord
     with Import, Convention => C, External_Name => "lvada_radius_circle";
   --  Clip children (e.g. an image) to the rounded corners.
   procedure Clip_Corner (O : Lv.Obj.Object; On : Interfaces.C.int := 1; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_clip_corner";

   --  Sides: 1 bottom, 2 top, 4 left, 8 right; add them up (15 = all).
   Bottom_Side : constant := 1;
   Top_Side    : constant := 2;
   Left_Side   : constant := 4;
   Right_Side  : constant := 8;
   All_Sides   : constant := 15;
   procedure Border (O : Lv.Obj.Object; Width : Coord; Color : RGB;
                     Opa : Opacity := Opaque; Sides : Interfaces.C.int := All_Sides;
                     Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_border";
   procedure Outline (O : Lv.Obj.Object; Width : Coord; Color : RGB;
                      Opa : Opacity := Opaque; Pad : Coord := 0; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_outline";

   procedure Pad (O : Lv.Obj.Object; Top, Bottom, Left, Right : Coord; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_pad";
   procedure Pad_All (O : Lv.Obj.Object; P : Coord; Sel : Selector := Main);
   procedure Pad_Hor_Ver (O : Lv.Obj.Object; Hor, Ver : Coord; Sel : Selector := Main);
   --  Space between children in a flex layout.
   procedure Gap (O : Lv.Obj.Object; Row, Column : Coord; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_gap";

   procedure Shadow (O : Lv.Obj.Object; Width : Coord; Color : RGB; Opa : Opacity;
                     Offset_Y : Coord := 0; Spread : Coord := 0; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_shadow";

   procedure Opa (O : Lv.Obj.Object; Value : Opacity; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_opa";
   --  Tints an image (e.g. a white icon to any color).
   procedure Image_Recolor (O : Lv.Obj.Object; Color : RGB; Opa : Opacity := Opaque;
                            Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_image_recolor";
   procedure Arc (O : Lv.Obj.Object; Width : Coord; Color : RGB; Opa : Opacity := Opaque;
                  Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_arc";
   procedure Min_Height (O : Lv.Obj.Object; H : Coord; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_min_height";
   procedure Max_Width (O : Lv.Obj.Object; W : Coord; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_max_width";

   --  Animate property changes between states over Ms milliseconds.
   procedure Transition (O : Lv.Obj.Object; Ms : Interfaces.C.unsigned; Sel : Selector := Main)
     with Import, Convention => C, External_Name => "lvada_transition_ms";
   --  Shrink by Px while pressed (tactile feedback).
   procedure Press_Shrink (O : Lv.Obj.Object; Px : Coord)
     with Import, Convention => C, External_Name => "lvada_press_shrink";

end Lv.Style;
