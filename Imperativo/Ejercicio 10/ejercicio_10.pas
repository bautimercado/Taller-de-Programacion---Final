program diez;
const
	cantDias = 5;
	corte = '-1';
	valorBajoInt = -32767;
	valorAltoString = 'zzz';
type
	rangoDias = 1..cantDias;
	str10 = String[10];
	tProducto = record
		codProducto, codCliente : str10;
		cantVendida : integer;
	end;
	
	lista = ^nodo;
	nodo = record
		dato : tProducto;
		sig : lista;
	end;
	
	arrListasPorDia = array[rangoDias] of lista;
	
	tProductoAcumulador = record
		codProducto : str10;
		cantVendidaTotal : integer;
	end;
	
	nuevaLista = ^nuevoNodo;
	nuevoNodo = record
		dato : tProductoAcumulador;
		sig : nuevaLista;
	end;
	
procedure iniciarListas(var v : arrListasPorDia);
var
	i : integer;
begin
	for i := 1 to cantDias do
		v[i] := nil;
end;

procedure leerProducto(var unProducto : tProducto; var dia : rangoDias);
begin
	with unProducto do begin
		writeln('-------------------------------------------------------------');
		writeln('Ingrese codigo de producto'); readln(codProducto);
		if (codProducto <> corte) then begin
			writeln('Ingrese codigo de cliente'); readln(codCliente);
			writeln('Ingrese la cantidad vendida del producto'); readln(cantVendida);
			writeln('Ingrese dia de venta'); readln(dia);
		end;
	end;
	writeln('-----------------------------------------------------');
end;

procedure insertarOrdenado(var l : lista; unProducto : tProducto);
var
	nodo, act, ant : lista;
begin
	new(nodo);
	nodo^.dato := unProducto;
	act := l;
	while ((act <> nil) and (act^.dato.codProducto < unProducto.codProducto)) do begin
		ant := act;
		act := act^.sig;
	end;
	if (l = act) then
		l := nodo
	else
		ant^.sig := nodo;
	nodo^.sig := act;
end;

procedure generarEstructura(var v : arrListasPorDia);
var
	unProducto : tProducto;
	dia : rangoDias;
begin
	iniciarListas(v);
	leerProducto(unProducto, dia);
	while (unProducto.codProducto <> corte) do begin
		insertarOrdenado(v[dia], unProducto);
		leerProducto(unProducto, dia);
	end;
end;

procedure minimo(var v : arrListasPorDia; var min : tProducto);
var
	i, iMin : integer;
begin
	iMin := -1; min.codProducto := valorAltoString;
	for i := 1 to cantDias do begin
		if ((v[i] <> nil) and (v[i]^.dato.codProducto < min.codProducto)) then begin
			min := v[i]^.dato;
			iMin := i;
		end;
	end;
	if (iMin <> -1) then
		v[iMin] := v[iMin]^.sig;
end;

procedure agregarAtras(var l, ult : nuevaLista; unProducto : tProductoAcumulador);
var
	nodo : nuevaLista;
begin
	new(nodo); nodo^.dato := unProducto; nodo^.sig := nil;
	if (l = nil) then
		l := nodo
	else
		ult^.sig := nodo;
	ult := nodo;
end;

procedure mergeAcumulador(var l : nuevaLista; v : arrListasPorDia);
var
	ult : nuevaLista;
	min : tProducto;
	act : tProductoAcumulador;
begin
	l := nil; ult := nil;
	minimo(v, min);
	while (min.codProducto <> valorAltoString) do begin
		act.codProducto := min.codProducto;
		act.cantVendidaTotal := 0;
		while ((min.codProducto <> valorAltoString) and (act.codProducto = min.codProducto)) do begin
			act.cantVendidaTotal += min.cantVendida;
			minimo(v, min);
		end;
		agregarAtras(l, ult, act);
	end;
end;

procedure productoMasVendido(l : nuevaLista; var max : tProductoAcumulador);
begin
	if (l <> nil) then begin
		if (max.cantVendidaTotal < l^.dato.cantVendidaTotal) then
			max := l^.dato;
		productoMasVendido(l^.sig, max);
	end;
end;

//Programa Principal
var
	listaAcumuladora : nuevaLista;
	listas : arrListasPorDia;
	max : tProductoAcumulador;
begin
	generarEstructura(listas);
	mergeAcumulador(listaAcumuladora, listas);
	max.cantVendidaTotal := valorBajoInt;
	productoMasVendido(listaAcumuladora, max);
	writeln('El producto más vendido es: ',max.codProducto);
end.


	
