Program EJ3 is

Task Medico is
  ENTRY Atencion();
End Medico;

Task Type Paciente;

Task Body Medico is
  atendidos: integer;
Begin
  atendidos:=0;
  While (atendidos < P) Loop
    Select
      Accept Atencion() is
        AtenderPaciente();
      End Atencion;
      atendidos := atendidos + 1;
    else
      Delay 600.0;
    End Select;
  End Loop;
End;


Task Body Paciente is
Begin
  Medico.Atencion();
End Paciente;

arrPacientes: Array(1..P) of Paciente;

Begin
  NULL;
End EJ3;
