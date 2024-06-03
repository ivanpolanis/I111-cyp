Program EJ3 is
Task Type Impresora is
  ENTRY Color(c: IN bool);
End Impresora;

Task Server is
  ENTRY Pedido(doc: IN document;c: IN bool; id: IN int);
  ENTRY SiguienteColor(doc: IN document; id: IN int);
  ENTRY SiguienteBN(doc: IN document; id: IN int);
End Server;

Task Type Cliente is
  ENTRY ObtenerId(id: IN int);
  ENTRY ObtenerImpreso(impreso: IN imp);
End Cliente;

Task Body Server is
  color,bn: queue;
Begin
  Loop
    Select
      Accept Pedido(id,c,doc) is
        If (c) Then push(color,(doc,id))
        Else push(bn,(doc,id)); End If;
      End Pedido;
    or
      When(not empty(color) or not empty(bn)) => Accept SiguienteColor(doc,id) is
        If (empty(color)) Then
          {doc, id} = pop(bn);
        Else
          {doc, id} = pop(color);
        End If;
      End SiguienteColor;
    or
      When (not empty(bn)) => Accept SiguienteBN(doc,id) is
        {doc, id} = pop(bn);
      End SiguienteBN;
  End Loop;
End;

Task Body Impresora is
  color: bool;
Begin
  Accept Color(color);

  If (c) Then
    Loop
      Server.SiguienteColor(doc,id);
      impreso = Imprimir(doc);
      arrCliente(id).ObtenerImpreso(impreso);
    End Loop;
  Else
    Loop
      Server.SiguienteBN(doc,id);
      impreso = Imprimir(doc);
      arrCliente(id).ObtenerImpreso(impreso);
    End Loop;
  End If;

End;

Task Body Cliente is
  id: integer;
Begin
  Accept ObtenerId(id);

  Server.Pedido(id,c,doc);

  Accept ObtenerImpreso(impreso);
End;

arrClientes: Array(1..C) of Cliente;
arrImpresora: Array(1..2) of Impresora;

Begin
  arrImpresora(1).Color(True);
  arrImpresora(2).Color(False);
  For i:=1 to C Loop
    arrCliente(i).ObtenerId(i);
  End Loop;


End;
