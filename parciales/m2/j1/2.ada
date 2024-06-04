-- {En un negocio de cobros digitales hay P personas que deben pasar por la única caja de cobros para realizar el pago de sus boletas. Las personas son atendidas de acuerdo con el orden de llegada, teniendo prioridad aquellos que deben pagar menos de 5 boletas de los que pagan más. Adicionalmente, las personas embarazadas y los ancianos tienen prioridad sobre los dos casos anteriores. Las personas entregan sus boletas al cajero y el dinero de pago; el cajero les devuelve el vuelto y los recibos de pago. Implemente un programa que permita resolver el problema anterior usando ADA.}

Program EJ2 is
Task Cajero is
  ENTRY AtenderP2(boletas: IN queue; dinero: IN float; vuelto: OUT float; recibos OUT queue);
  ENTRY AtenderP1(boletas: IN queue; dinero: IN float; vuelto: OUT float; recibos OUT queue);
  ENTRY AtenderP0(boletas: IN queue; dinero: IN float; vuelto: OUT float; recibos OUT queue);
End Cajero;

Task Type Persona;

Task Body Persona is
  boletas, recibos: queue; dinero,vuelto: float;
  cant_b: integer; prior: bool;
Begin
  If (prior) then
    cajero.AtenderP2(boletas,dinero,vuelto,recibos);
  Else
    If (cant_b < 5) then
      cajero.AtenderP1(boletas,dinero,vuelto,recibos);
    Else
      cajero.AtenderP0(boletas,dinero,vuelto,recibos);
    End If;
  End If;
End Persona;

Task Body Cajero is
Begin
  Loop
    Select
      Accept AtenderP2(boletas,dinero,vuelto,recibos) is
        recibos := GenerarRecibos(boletas);
        vuelto := Cobrar(dinero);
      End AtenderP2;
      Or
      When (AtenderP2'count=0) => Accept AtenderP1(boletas,dinero,vuelto,recibos) is
        recibos := GenerarRecibos(boletas);
        vuelto := Cobrar(dinero);
      End AtenderP1;
      When (AtenderP2'count=0) and (AtenderP1'count=0) => Accept AtenderP0(boletas,dinero,vuelto,recibos) is
        recibos := GenerarRecibos(boletas);
        vuelto := Cobrar(dinero);
      End AtenderP0;
    End Select;
  End Loop;
End Cajero;

arrPersona: Array(1..P) of Persona;
cajero: Cajero;
Begin
End EJ2;
