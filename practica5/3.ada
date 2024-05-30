Program Ejercicio3 is
Task Central is
  Entry P1(s: IN int);
  Entry P2(s: IN int);
End Central;

Task Proceso1;
Task Proceso2;

Task Body Central is
  s: int;
Begin
  accept P1(s: IN int);
  Loop
    Select
      Accept P1(s) do
        -- Hace algo con s;
      End P1;
    or
      Accept P2(s) do
        -- Se usa s
        Loop
          Select
            Accept P2(s) do
              -- Se usa s
            end P2;
          or
            delay 120.0 do
              exit -- Sale del loop interno
          End Select;
        End Loop;
      End P2;
    End Select;
  End Loop;
End Central;

Task Body Proceso1 is
  s: integer;
Begin
  Loop
    s := GenerarSeñal();
    Select
      Central.P1(s);
    or delay 120.0
      NULL
    End Select;
  End Loop;
End Proceso1;

Task Body Proceso1 is
  s: integer; nueva: bool := true;
Begin
  Loop
    if (nueva) s := GenerarSeñal();
    Select
      Central.P1(s);
      nueva := true;
    or delay 60.0
      nueva := false;
    End Select;
  End Loop;
End Proceso1;

Begin
  NULL;
End Ejercicio3;
