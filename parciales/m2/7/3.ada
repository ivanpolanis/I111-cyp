Procedure EJ3 is

Task Central is
  ENTRY EnviarDato(temp: IN float; dormir: OUT bool);
End Central;

Task Type Controlador;

Task Body Central is
Begin
  Loop
    Accept EnviarDato(temp,dormir) is
      If (temp > 40.0) Then dormir := true
      Else dormir:= false End If;
  End Loop;
End Central;

Task Body Controlador is
Begin
  Loop
    temp := Medir();
    Central.EnviarDato(temp,dormir);

    If Dormir then Delay(60*60)
    Else Delay(60*10) End If;
  End Loop;
End Controlador;

Begin
End EJ3;
