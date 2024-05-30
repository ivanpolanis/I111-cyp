Program Ejercicio4 is
Task Medico is
  Entry PedidoPaciente;
  Entry PedidoEnfermera(s: IN string);
  Entry PedidoNota(s: IN string);
End Medico;

Task Consultorio is
  Entry DejarNota(s: IN String);
  Entry SiguienteNota;
End Consultorio;

Task Type Enfermera;
Task Type Paciente;

arrEnfermeras: Array(1..E-1) of Enfermera;
arrPacientes: Array(1..P-1) of Pacientes;

Task Body Medico is
Begin
  Loop
    Select
      Accept PedidoPaciente do
        -- Atiende al paciente.
      End PedidoPaciente;
      or
      When (PedidoPaciente'count = 0) =>  Accept PedidoEnfermera(s) Do
        -- Procesa el pedido de la enfermera.
      End PedidoEnfermera;
      Else
        Select
          Consultorio.SiguienteNota() Do
            Accept PedidoNota(s) do
            End PedidoNota;
          Else
            Null;
      End Select
    End Select;
  End Loop;
End Medico;

Task Body Consultorio is
  q: queue;s: string;
Begin
  Loop
    Select
      Accept DejarNota(s) do
        push(q,s);
      End DejarNota;
      or
      When (not empty(q)) => Accept SiguienteNota() Do
        Medico.PedidoNota(pop(notas));
      End SiguienteNota;
    End Select;
  End Loop;
End Consultorio;

Task Body Enfermera is
  s: string;
Begin
  Loop
    s:= Pedido();
    Select
      Medico.PedidoEnfermera(s);
    else
      Consultorio.DejarNota(s);
    End Select;
  End Loop;
End Enfermera;

Task Body Paciente is
  intentos: integer := 0;
Begin
  While (intentos < 3) do
    Select
      Medico.PedidoPaciente() Do break;
    or Delay 300.0
      intentos := intentos + 1;
    End Select;

    Delay 600.0;
  End While;
End Paciente;

Begin
  NULL;
End Ejercicio4;
