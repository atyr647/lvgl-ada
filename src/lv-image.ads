with System;
with Interfaces.C;
with Lv.Obj;

--  lv_image (widgets/lv_image.h). Curated subset: create, source
--  (either a path string via a filesystem driver, or a raw
--  lv_image_dsc_t/lv_image_header_t pointer for an in-memory image),
--  scale/zoom, and rotation.
package Lv.Image
is

   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_image_create";

   --  Raw C entry point (const void * src): pass either a null-terminated
   --  path chars_ptr or the address of an lv_image_dsc_t. Prefer
   --  Set_Src_Path below for a filesystem-driver path.
   procedure Set_Src (Obj : Lv.Obj.Object; Src : System.Address)
     with Import => True, Convention => C, External_Name => "lv_image_set_src";

   procedure Set_Src_Path (Obj : Lv.Obj.Object; Path : String);

   --  1024 == 1x (no zoom), matching LV_SCALE_NONE.
   Scale_None : constant UCoord := 256;

   procedure Set_Scale (Obj : Lv.Obj.Object; Zoom : UCoord)
     with Import => True, Convention => C, External_Name => "lv_image_set_scale";

   procedure Set_Rotation (Obj : Lv.Obj.Object; Angle : Coord)
     with Import => True, Convention => C, External_Name => "lv_image_set_rotation";

   procedure Set_Antialias (Obj : Lv.Obj.Object; Enable : Interfaces.C.C_bool)
     with Import => True, Convention => C, External_Name => "lv_image_set_antialias";

end Lv.Image;
