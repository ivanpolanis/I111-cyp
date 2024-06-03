Program EJ3 is

Task Especialista is
  ENTRY Puntuar(elementos: IN list; puntaje: OUT int);
End Especialista;

Task Type Chico is
  ENTRY RecibirLista(l: IN list);
  ENTRY RecibirGanador(id: IN int);
End Chico;

Task Body Especialista is
  arrPuntos: Array(1..10) of integer; elementos: list; ganador: int;
Begin
  For i:=1 to 10 Loop
    l := GenerarLista();
    arrChicos(i).RecibirLista(l);
  End Loop;

  For i:=1 to 10 Loop
    Accept Puntuar(elementos) is
      arrPuntos(i) := DarPuntaje(elementos);
      puntaje := arrPuntos(i);
    End Puntuar;
  End Loop;

  ganador := CalcularGanador(arrPuntos);

  For i:=1 to 10 Loop
    arrChicos(i).RecibirGanador(ganador)
  End Loop;

End Especialista;

Task Body Chico is
  elementos, l: list; p, ganador: integer;
Begin
  Accept RecibirLista(l);

  elementos := Buscar(l);

  Especialista.Puntaje(elementos,p);

  Accept RecibirGanador(ganador);
End Chico;

Begin
  NULL;
End EJ3;
