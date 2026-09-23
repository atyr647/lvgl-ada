with Ada.Unchecked_Conversion;
with Interfaces.C.Strings;

package body Lv.Image is

   function Chars_Ptr_To_Address is new Ada.Unchecked_Conversion
     (Interfaces.C.Strings.chars_ptr, System.Address);

   procedure Set_Src_Path (Obj : Lv.Obj.Object; Path : String) is
      use Interfaces.C.Strings;
      C_Path : constant chars_ptr := New_String (Path);
   begin
      --  lv_image_set_src stores the pointer it is given for a path
      --  string (it does not copy path strings the way lv_label_set_text
      --  copies label text), so C_Path is deliberately never freed here:
      --  it must outlive the image object. This leaks one small
      --  allocation per call, acceptable for a path that is normally set
      --  once per image widget; callers who repeatedly change an image's
      --  source should call Set_Src directly with a path they manage
      --  themselves instead of this convenience wrapper.
      Set_Src (Obj, Chars_Ptr_To_Address (C_Path));
   end Set_Src_Path;

end Lv.Image;
