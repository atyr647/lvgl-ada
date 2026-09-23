with Lv.Event;

--  On_Click must be a library-level subprogram, not nested inside
--  Smoke_Test's procedure body: Ada forbids taking 'Access of a nested
--  subprogram and converting it to an access-to-subprogram type
--  declared at a shallower accessibility level (Lv.Event.Callback is
--  declared at library level in Lv.Event), since the resulting access
--  value could otherwise outlive the nested subprogram's scope.
package Smoke_Test_Callbacks is

   Clicked : Boolean := False;

   procedure On_Click (E : Lv.Event.Event)
     with Convention => C;

end Smoke_Test_Callbacks;
