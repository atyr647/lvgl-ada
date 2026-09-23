package body Smoke_Test_Callbacks is

   procedure On_Click (E : Lv.Event.Event) is
      pragma Unreferenced (E);
   begin
      Clicked := True;
   end On_Click;

end Smoke_Test_Callbacks;
