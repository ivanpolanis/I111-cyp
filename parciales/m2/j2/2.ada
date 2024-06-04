-- {Resolver con ADA el siguiente problema. La oficina central de una empresa de venta de indumentaria debe calcular cuántas veces fue vendido cada uno de los artículos de su catálogo. La empresa se compone de 100 sucursales y cada una de ellas maneja su propia base de datos de ventas. La oficina central cuenta con una herramienta que funciona de la siguiente manera: ante la consulta realizada para un artículo determinado, la herramienta envía el identificador del artículo a cada una de las sucursales, para que cada uno de éstas calcule cuántas veces fue vendido en ella. Al final del procesamiento, la herramienta debe conocer cuántas veces fue vendido en total, considerando todas las sucursales. Cuando ha terminado de procesar un artículo comienza con el siguiente (suponga que la herramienta tiene una función generarArtículo que retorna el siguiente ID a consultar). Nota: maximizar la concurrencia. Supongo que existe una función ObtenerVentas(ID) que retorna la cantidad de veces que fue vendido el artículo con identificador ID en la base de datos de la sucursal que la llama.}


Program EJ2 is

Task Central is
  ENTRY RecibirVentas(ventas: IN int);
  ENTRY PedirId(id: OUT int);
  ENTRY Siguiente;
End Central;

Task Type Sucursal is
End Sucursal;


Task Body Central is
  idArt, total: integer;
Begin
  Loop
    idArt := GenerarArticulo();
    total := 0;

    for i in 1..200 Loop
      Select
        Accept PedirId(id) is
          id:= idArt;
        End PedirId;
      Or
        When (PedirId'count=0) => Accept RecibirVentas(ventas) is
          total := total + ventas;
        End RecibirVentas;
    End Loop;

    for i in 1..100 Loop
      Accept SiguienteBusqueda;
    End Loop;
  End Loop;
End;

Task Body Sucursal is
  id, ventas : integer;
Begin
  Loop
    central.PedirId(id);
    ventas := ObtenerVentas(id);
    central.RecibirVentas(ventas);
    central.Siguiente;
  End Loop;
End Sucursal;

Begin
End EJ2;
