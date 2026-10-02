with System;
with Interfaces.C;
with Lv.Display;

--  lv_indev_t (indev/lv_indev.h). Covers the manual-driver path; Lv.Sdl
--  covers LVGL's own SDL2 mouse/keyboard drivers for bring-up/testing.
package Lv.Indev
is

   type Indev is new System.Address;

   --  lv_indev_type_t: clean 0-based C enum.
   type Indev_Type is (None, Pointer, Keypad, Button, Encoder)
     with Convention => C;

   --  lv_indev_state_t.
   type Indev_State is (Released, Pressed)
     with Convention => C;

   type Point is record
      X, Y : Coord;
   end record
     with Convention => C;

   Gesture_Count : constant := 6;  --  LV_INDEV_GESTURE_CNT, confirmed
                                    --  against the compiled v9.6.0 headers

   type Gesture_Type_Array is array (0 .. Gesture_Count - 1) of Interfaces.C.int
     with Convention => C;
   type Gesture_Data_Array is array (0 .. Gesture_Count - 1) of System.Address
     with Convention => C;

   --  lv_indev_data_t, the struct a read callback fills in. Field order,
   --  types, and total size are checked against the real v9.6.0 struct's
   --  sizeof/offsetof values (24/48/72/76/84/88/92/96/100/104 bytes) by
   --  this crate's test suite, not just transcribed from the header --
   --  every field is written through a raw pointer from C, so a layout
   --  mismatch here would silently corrupt adjacent fields rather than
   --  fail to compile.
   type Indev_Data is record
      Gesture_Type     : Gesture_Type_Array;
      Gesture_Data     : Gesture_Data_Array;
      State            : Indev_State;
      Point_Value      : Point;
      Key              : Interfaces.C.unsigned;
      Btn_Id           : Interfaces.C.unsigned;
      Enc_Diff         : Interfaces.C.short;
      Timestamp        : Interfaces.C.unsigned;
      Continue_Reading : Interfaces.C.C_bool;
   end record
     with Convention => C, Size => 104 * 8;
   --  The explicit Size (bits) is required: Convention => C alone does
   --  not make GNAT pad this record's tail out to a multiple of its
   --  8-byte (Gesture_Data's System.Address elements) alignment the way
   --  the real C struct's compiler does -- without it, Indev_Data'Size
   --  comes out 3 bytes short (101, not 104), confirmed against the
   --  compiled v9.6.0 struct's sizeof and this crate's layout_check
   --  test.

   type Indev_Data_Access is access all Indev_Data
     with Convention => C;

   type Read_Callback is access procedure (Dev : Indev; Data : Indev_Data_Access)
     with Convention => C;

   function Create return Indev
     with Import => True, Convention => C, External_Name => "lv_indev_create";

   procedure Set_Type (Dev : Indev; Kind : Indev_Type)
     with Import => True, Convention => C, External_Name => "lv_indev_set_type";

   procedure Set_Read_Cb (Dev : Indev; Cb : Read_Callback)
     with Import => True, Convention => C, External_Name => "lv_indev_set_read_cb";

   procedure Set_Display (Dev : Indev; Disp : Lv.Display.Display)
     with Import => True, Convention => C, External_Name => "lv_indev_set_display";

   procedure Set_Group (Dev : Indev; Group : System.Address)
     with Import => True, Convention => C, External_Name => "lv_indev_set_group";

end Lv.Indev;
