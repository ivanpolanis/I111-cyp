Program EJ3 is

Task Empleado is
  ENTRY PedidoDirector(pedido);
  ENTRY PedidoNormal(pedido);
  ENTRY NoAtendido();
End Empleado;

Task Director;

Task Type Cliente;

Task Body Empleado is
Begin
  For i in 1..C+1 Loop
    Select
      Accept PedidoDirector(pedido) is
        Atender();
      End PedidoDirector;
    or
      When (PedidoDirector'count = 0) => Accept PedidoNormal(pedido) is Atender();
      End PedidoNormal;
    or
      When (PedidoDirector'count = 0) => Accept NoAtendido(pedido);
    End Select;
  End Loop;
End Empleado;

Task Body Director is
  sigo: bool; pedido: string;
Begin
  sigo := true;
  While (sigo) Loop
    Select
      Empleado.PedidoDirector(pedido);
      sigo := false;
    Else
      Delay 600;
    End Select;
  End Loop;
End Director;

Task Body Cliente is
  pedido: string;
Begin
  Select
    Empleado.PedidoDirector(pedido);
  or Delay 1200
    NULL;
  End Select;
End Cliente;

arrClientes: Array(1..C) of Cliente;

Begin
  NULL;
End EJ3;
