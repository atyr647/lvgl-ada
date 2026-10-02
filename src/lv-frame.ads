with System;
with Interfaces.C;
with Lv.Obj;

--  In-memory images for camera video and snapshots: an lv_image_dsc_t
--  owning a W x H XRGB8888 pixel buffer (bytes B, G, R, X per pixel),
--  shown by pointing an Lv.Image widget at it.
package Lv.Frame is

   type Frame is new System.Address;
   No_Frame : constant Frame := Frame (System.Null_Address);

   function Create (W, H : Coord) return Frame
     with Import, Convention => C, External_Name => "lvada_frame_new";
   procedure Free (F : Frame)
     with Import, Convention => C, External_Name => "lvada_frame_free";
   function Pixels (F : Frame) return System.Address
     with Import, Convention => C, External_Name => "lvada_frame_pixels";
   function Width (F : Frame) return Coord
     with Import, Convention => C, External_Name => "lvada_frame_width";
   function Height (F : Frame) return Coord
     with Import, Convention => C, External_Name => "lvada_frame_height";

   --  Show F in the image widget Img (Lv.Image.Create).
   procedure Show (Img : Lv.Obj.Object; F : Frame);
   --  Call after changing F's pixels in place.
   procedure Changed (Img : Lv.Obj.Object; F : Frame)
     with Import, Convention => C, External_Name => "lvada_frame_changed";

   type Fit_Mode is (As_Is, Contain, Cover, Stretch) with Convention => C;
   procedure Fit (Img : Lv.Obj.Object; Mode : Fit_Mode)
     with Import, Convention => C, External_Name => "lvada_image_fit";

   --  Decodes a baseline JPEG, shrunk by a whole factor to fit within
   --  Max_W x Max_H (0 = no limit). No_Frame if it can't be decoded.
   function Decode_JPEG (Data : System.Address; Length : Interfaces.C.size_t;
                         Max_W, Max_H : Coord) return Frame
     with Import, Convention => C, External_Name => "lvada_jpeg_decode";

end Lv.Frame;
