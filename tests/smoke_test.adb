with Ada.Text_IO; use Ada.Text_IO;
with System; use System;
with Interfaces.C;
with Interfaces.C.Strings;
with Lv;
with Lv.Obj;
with Lv.Event;
with Lv.Display;
with Lv.Sdl;
with Lv.Indev;
with Lv.Label;
with Lv.Button;
with Lv.Slider;
with Lv.Switch;
with Lv.Dropdown;
with Lv.Table;
with Lv.Textarea;
with Lv.Tabview;
with Lv.List;
with Lv.Image;
with Smoke_Test_Callbacks;

--  End-to-end smoke test: builds one instance of every widget this
--  binding covers on a real (headless, SDL_VIDEODRIVER=dummy) LVGL
--  display and runs it through LVGL's own render loop. This is the
--  closest thing to proof the binding actually works, short of a real
--  display -- a struct-layout or calling-convention mistake anywhere
--  in the core (Lv.Obj/Lv.Event/Lv.Display/Lv.Indev) is the kind of
--  bug that segfaults here rather than merely failing to compile.
procedure Smoke_Test is

   Disp : Lv.Display.Display;
   Root : Lv.Obj.Object;

begin
   Lv.Init;
   Put_Line ("Lv.Init: ok");

   Disp := Lv.Sdl.Window_Create (320, 240);
   if System.Address (Disp) = System.Null_Address then
      raise Program_Error with
        "Lv.Sdl.Window_Create returned no display -- under " &
        "SDL_VIDEODRIVER=dummy this means lv_conf.h's LV_SDL_ACCELERATED " &
        "is on and no accelerated SDL render driver is available";
   end if;
   Lv.Sdl.Set_Title (Disp, Interfaces.C.Strings.New_String ("Sentinel smoke test"));
   Put_Line ("Lv.Sdl.Window_Create: ok");

   declare
      Mouse : constant Lv.Indev.Indev := Lv.Sdl.Mouse_Create;
      Kbd   : constant Lv.Indev.Indev := Lv.Sdl.Keyboard_Create;
   begin
      Lv.Indev.Set_Display (Mouse, Disp);
      Lv.Indev.Set_Display (Kbd, Disp);
   end;
   Put_Line ("Lv.Sdl.Mouse_Create / Keyboard_Create: ok");

   Root := Lv.Obj.Screen_Active;

   declare
      L : constant Lv.Obj.Object := Lv.Label.Create (Root);
   begin
      Lv.Label.Set_Text (L, "Sentinel");
      Lv.Obj.Set_Pos (L, 8, 8);
   end;

   declare
      B  : constant Lv.Obj.Object := Lv.Button.Create (Root);
      BL : Lv.Obj.Object;
   begin
      Lv.Obj.Set_Pos (B, 8, 32);
      Lv.Obj.Set_Size (B, 80, 30);
      BL := Lv.Label.Create (B);
      Lv.Label.Set_Text (BL, "Arm");
      Lv.Obj.Set_Align (BL, Lv.Obj.Center);
      declare
         Dsc : System.Address;
         pragma Unreferenced (Dsc);
      begin
         Dsc := Lv.Event.Add_Cb
           (B, Smoke_Test_Callbacks.On_Click'Access, Lv.Event.Event_Clicked,
            System.Null_Address);
      end;
   end;

   declare
      S : constant Lv.Obj.Object := Lv.Slider.Create (Root);
   begin
      Lv.Obj.Set_Pos (S, 8, 72);
      Lv.Obj.Set_Size (S, 150, 10);
      Lv.Slider.Set_Range (S, 0, 100);
      Lv.Slider.Set_Value (S, 50, Interfaces.C.C_bool (False));
   end;

   declare
      Sw : constant Lv.Obj.Object := Lv.Switch.Create (Root);
   begin
      Lv.Obj.Set_Pos (Sw, 8, 96);
   end;

   declare
      D : constant Lv.Obj.Object := Lv.Dropdown.Create (Root);
   begin
      Lv.Obj.Set_Pos (D, 8, 128);
      Lv.Dropdown.Set_Options (D, "Preset 1" & ASCII.LF & "Preset 2" & ASCII.LF & "Preset 3");
      Lv.Dropdown.Set_Selected (D, 1);
   end;

   declare
      Tv   : constant Lv.Obj.Object := Lv.Tabview.Create (Root);
      Tab1 : Lv.Obj.Object;
      Tab2 : Lv.Obj.Object;
   begin
      Lv.Obj.Set_Pos (Tv, 170, 8);
      Lv.Obj.Set_Size (Tv, 140, 200);
      Tab1 := Lv.Tabview.Add_Tab (Tv, "Cameras");
      Tab2 := Lv.Tabview.Add_Tab (Tv, "Events");
      declare
         T : constant Lv.Obj.Object := Lv.Table.Create (Tab1);
      begin
         Lv.Table.Set_Row_Count (T, 2);
         Lv.Table.Set_Column_Count (T, 2);
         Lv.Table.Set_Cell_Value (T, 0, 0, "Cam");
         Lv.Table.Set_Cell_Value (T, 0, 1, "State");
         Lv.Table.Set_Cell_Value (T, 1, 0, "Front");
         Lv.Table.Set_Cell_Value (T, 1, 1, "OK");
         if Lv.Table.Get_Cell_Value (T, 1, 1) /= "OK" then
            raise Program_Error with "table round-trip mismatch";
         end if;
      end;
      declare
         Lst : constant Lv.Obj.Object := Lv.List.Create (Tab2);
         Btn : Lv.Obj.Object;
         pragma Unreferenced (Btn);
      begin
         Btn := Lv.List.Add_Button (Lst, "Motion detected");
      end;
   end;

   declare
      Ta : constant Lv.Obj.Object := Lv.Textarea.Create (Root);
   begin
      Lv.Obj.Set_Pos (Ta, 8, 160);
      Lv.Obj.Set_Size (Ta, 150, 40);
      Lv.Textarea.Set_Placeholder_Text (Ta, "Notes");
      Lv.Textarea.Set_Text (Ta, "Ada + LVGL v9");
      if Lv.Textarea.Get_Text (Ta) /= "Ada + LVGL v9" then
         raise Program_Error with "textarea round-trip mismatch";
      end if;
   end;

   declare
      Img : constant Lv.Obj.Object := Lv.Image.Create (Root);
      pragma Unreferenced (Img);
   begin
      null;  --  no image source in this headless smoke test; creation
             --  and destruction alone exercise the widget class.
   end;

   Put_Line ("All widgets created: ok");

   for Frame in 1 .. 60 loop
      Lv.Tick_Inc (16);
      declare
         Next_Ms : constant Interfaces.C.unsigned := Lv.Timer_Handler;
         pragma Unreferenced (Next_Ms);
      begin
         null;
      end;
   end loop;
   Put_Line ("60 render frames: ok");

   Lv.Sdl.Quit;
   Put_Line ("PASS");
end Smoke_Test;
