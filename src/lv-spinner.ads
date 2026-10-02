with Lv.Obj;

--  lv_spinner: an endlessly rotating arc for "working on it".
package Lv.Spinner is
   function Create (Parent : Lv.Obj.Object) return Lv.Obj.Object
     with Import, Convention => C, External_Name => "lv_spinner_create";
end Lv.Spinner;
