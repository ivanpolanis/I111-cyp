Procedure EJ2 is

Task Empleado is
  ENTRY SolicitarAtencion(sol: IN string);
  ENTRY NoAtendido();
End Empleado;

Task Type Persona;

Task Body Empleado is
Begin
  for i in 1..P Loop
    Select
      Accept SolicitarAtencion(sol) is
        Atender(sol);
    Or
      Accept NoAtendido();
    End Select;
  End Loop;
End Empleado;

Task Body Persona is
Begin
  Select
    Empleado.SolicitarAtencion(sol);
  Or Delay 1200
    Empleado.NoAtendido();
  End Select;
End Persona;

arrPersona: Array(1..P) of Persona;
empleado: Empleado;

Begin
  NULL;
End EJ2;
