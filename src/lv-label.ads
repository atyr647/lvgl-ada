with Interfaces.C;
with Interfaces.C.Strings;
with Lv.Obj;

--  lv_label (widgets/lv_label.h). Curated subset: create + the
--  text/long-mode setters Sentinel's screens need. See this crate's
--  top-level scope note (Lv's header comment) for what "curated" means.
package Lv.Label
is

   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_label_create";

   --  lv_label_long_mode_t: clean 0-based C enum.
   type Long_Mode is (Wrap, Dots, Scroll, Scroll_Circular, Clip)
     with Convention => C;

   procedure Set_Long_Mode (Obj : Lv.Obj.Object; Mode : Long_Mode)
     with Import => True, Convention => C,
          External_Name => "lv_label_set_long_mode";

   procedure Set_Recolor (Obj : Lv.Obj.Object; Enable : Interfaces.C.C_bool)
     with Import => True, Convention => C, External_Name => "lv_label_set_recolor";

   --  Raw C entry point: Text must outlive the call (LVGL copies it
   --  internally by default, but see lv_label_set_text_static for the
   --  no-copy variant this binding does not cover). Prefer Set_Text
   --  below for normal Ada String values.
   procedure Set_Text_C (Obj : Lv.Obj.Object; Text : Interfaces.C.Strings.chars_ptr)
     with Import => True, Convention => C, External_Name => "lv_label_set_text";

   procedure Set_Text (Obj : Lv.Obj.Object; Text : String);

end Lv.Label;
