with Lv.Image;

package body Lv.Frame is

   procedure Show (Img : Lv.Obj.Object; F : Frame) is
   begin
      Lv.Image.Set_Src (Img, System.Address (F));
   end Show;

end Lv.Frame;
