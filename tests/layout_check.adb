with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;
with Lv.Indev;

--  Verifies Lv.Indev.Indev_Data's field layout against the golden
--  offsets/sizes measured directly from the compiled v9.6.0 C struct
--  (via offsetof/sizeof in a throwaway C probe during development --
--  see docs/lvgl-v9-rewrite-scope.md). Indev_Data is written through a
--  raw pointer from C (a read callback's `data` argument), so a layout
--  mismatch here would silently corrupt adjacent fields at runtime
--  rather than fail to compile: this check is the difference between
--  "the binding compiles" and "the binding is correct."
procedure Layout_Check is

   Failures : Natural := 0;

   procedure Check (Name : String; Actual, Expected : Natural) is
   begin
      if Actual = Expected then
         Put_Line ("  PASS  " & Name & " =" & Actual'Image);
      else
         Failures := Failures + 1;
         Put_Line
           ("  FAIL  " & Name & ": got" & Actual'Image
            & ", expected" & Expected'Image);
      end if;
   end Check;

   use Lv.Indev;

   Data : Indev_Data;

begin
   Check ("Indev_Data'Size (bytes)", Indev_Data'Size / 8, 104);
   Check ("State'Position", Data.State'Position, 72);
   Check ("Point_Value'Position", Data.Point_Value'Position, 76);
   Check ("Key'Position", Data.Key'Position, 84);
   Check ("Btn_Id'Position", Data.Btn_Id'Position, 88);
   Check ("Enc_Diff'Position", Data.Enc_Diff'Position, 92);
   Check ("Timestamp'Position", Data.Timestamp'Position, 96);
   Check ("Continue_Reading'Position", Data.Continue_Reading'Position, 100);

   New_Line;
   Put_Line (Failures'Image & " failures.");
   if Failures > 0 then
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
   end if;
end Layout_Check;
