Program EJ2 is
Task Type Cliente is
  ENTRY ObtenerPrioridad(prior: IN int);
End Cliente;

Task Portal is
  ENTRY ComprarEntradaPremium(comprobrante: OUT string);
  ENTRY ComprarEntrada(comprobante: OUT string);
End Portal;

Task Body Portal is
  entradas: integer;
Begin
  entradas := 0;

  While (entradas < P) Loop
    Select
        Accept ComprarEntradaPremium(comprobante) is
          If (entradas <  E) then comprobante := GenerarComprobante();
          Else comprobante := "SOLDOUT"; End If;
          entradas := entradas + 1;
        End ComprarEntradaPremium;
      Or
        When(ComprarEntradaPremium'count = 0) => Accept ComprarEntrada(comprobante) is
          If (entradas <  E) then comprobante := GenerarComprobante();
          Else comprobante := "SOLDOUT"; End If;
          entradas := entradas + 1;
        End ComprarEntrada;
    End Select;
  End Loop;

End Portal;

Task Body Cliente is
  prior: integer; comprobante: string;
Begin
  Accept ObtenerPrioridad(prior);

  comprobante :=  "VACIO";
  If (prior = 1) then
    Portal.ComprarEntradaPremium(comprobante);
  Else
    While (comprobante = "VACIO") Loop
      Select
        Portal.ComprarEntrada(comprobante);
      Or
        Delay 600
          NULL;
      End Select;
    End Loop;
  End If;

  If (comprobante <> "SOLDOUT") Then Imprimir(comprobante) End If;
End;

arrPersonas: Array(1..P) of Cliente;

Begin
  For i in 1..P Loop
    prior = ObtenerPrior(i);
    arrPersonas(i).ObtenerPrioridad(prior);
  End Loop;
End EJ2;
