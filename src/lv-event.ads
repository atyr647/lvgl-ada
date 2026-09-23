with System;
with Interfaces.C;
with Lv.Obj;

--  lv_event_t (core/lv_event.h) and the lv_obj_add_event_cb subscription
--  API (core/lv_obj_event.h).
package Lv.Event
is

   type Event is new System.Address;

   --  lv_event_code_t (LV_EVENT_*): not a clean 0-based C enum -- it has
   --  gaps for LV_EVENT_LAST_CUSTOM (0x7FFF), LV_EVENT_PREPROCESS
   --  (0x8000), and LV_EVENT_MARKED_DELETING (0x10000), and one entry is
   --  conditional on LV_USE_TRANSLATION. Bound as named constants (values
   --  confirmed against the compiled v9.6.0 headers, not hand-counted)
   --  rather than an Ada enumeration, which would require every literal
   --  including ones this binding never uses.
   subtype Code is Interfaces.C.unsigned;

   Event_All            : constant Code := 0;
   Event_Pressed        : constant Code := 1;
   Event_Short_Clicked  : constant Code := 4;
   Event_Long_Pressed   : constant Code := 8;
   Event_Clicked        : constant Code := 10;
   Event_Released       : constant Code := 11;
   Event_Scroll_End     : constant Code := 14;
   Event_Key            : constant Code := 21;
   Event_Focused        : constant Code := 23;
   Event_Defocused      : constant Code := 24;
   Event_Value_Changed  : constant Code := 39;
   Event_Ready          : constant Code := 42;
   Event_Cancel         : constant Code := 43;
   Event_Checked        : constant Code := 45;
   Event_Unchecked      : constant Code := 46;

   function Get_Code (E : Event) return Code
     with Import => True, Convention => C, External_Name => "lv_event_get_code";

   function Get_Target (E : Event) return Lv.Obj.Object
     with Import => True, Convention => C, External_Name => "lv_event_get_target";

   function Get_Current_Target (E : Event) return Lv.Obj.Object
     with Import => True, Convention => C,
          External_Name => "lv_event_get_current_target";

   function Get_User_Data (E : Event) return System.Address
     with Import => True, Convention => C,
          External_Name => "lv_event_get_user_data";

   type Callback is access procedure (E : Event)
     with Convention => C;

   --  Registers Cb on Obj for events matching Filter (Event_All to match
   --  every code). User_Data is recoverable inside the callback via
   --  Get_User_Data -- the usual way to pass an Ada-side context pointer
   --  through the C callback boundary.
   function Add_Cb
     (Obj : Lv.Obj.Object; Cb : Callback; Filter : Code; User_Data : System.Address)
      return System.Address
     with Import => True, Convention => C, External_Name => "lv_obj_add_event_cb";

end Lv.Event;
