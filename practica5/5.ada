Program Ejercicio5 is
Task Servidor is
  Entry EnviarDocumento(doc: IN/OUT String; ok: OUT bool);
End Servidor;

Task Type Cliente;

arrCliente: Array(1..N) of Cliente;

Task Body Servidor is
  doc: string; ok:bool;
Begin
  Loop
    Accept EnviarDocumento(doc,ok) is
      { doc, ok } := AnalizarDoc(doc);
    End EnviarDocumento;
  End Loop;
End Servidor;

Task Body Cliente is
  doc: string; ok: bool := False;
Begin
  doc := GenerarDocumento();
  While (ok) do
    Select
      Servidor.EnviarDocumento(doc,ok);
    or
      Delay 120.0
        NULL;
    End Select;
    Delay 60.0;
  End While;
End;

Begin
  NULL;
End Ejercicio5;
