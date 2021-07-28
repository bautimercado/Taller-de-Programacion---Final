program uno;
const
	cantDias = 7;
	corte = 0;
	valorAlto = 32767;
type
	rangoDias = 1..7;
	
	tEntradas = record
		dia : rangoDias;
		codObra, asiento : integer;
		monto : real;
	end;
	
	listaEntradas = ^nodo;
	nodo = record
		datos : tEntradas;
		sig : listaEntradas;
	end;
	
	arrListasPorDia = array[rangoDias] of listaEntradas;
	
	tObra = record
		codObra, cantVendida : integer;
	end; 
	
	nuevaLista = ^nuevoNodo;
	nuevoNodo = record
		datos : tObra;
		sig : nuevaLista;
	end;
	
procedure iniciarListas (var v : arrListasPorDia);
var
	i : integer;
begin
	for i := 1 to cantDias do
		v[i] := nil;
end;

procedure leerEntrada (var entrada : tEntradas);
begin
	with entrada do begin
		writeln('Ingrese codigo de obra'); readln(codObra);
		if (codObra <> 0) then begin
			writeln('Ingrese dia'); readln(dia);
			writeln('Ingrese asiento'); readln(asiento);
			writeln('Ingrese monto'); readln(monto);
		end;
	end;
end;

procedure insertarOrdenado (var lista : listaEntradas; entrada : tEntradas);
var
	nodo, act, ant : listaEntradas;
begin
	new(nodo); nodo^.datos := entrada; nodo^.sig := nil;
	act := lista;
	while ((act <> nil) and (act^.datos.codObra < nodo^.datos.codObra)) do begin
		ant := act;
		act := act^.sig;
	end;
	if (act = lista) then
		lista := nodo
	else
		ant^.sig := nodo;
	nodo^.sig := act;

end;

procedure generarListas (var v : arrListasPorDia);
var
	entrada : tEntradas;
begin
	iniciarListas(v);
	writeln('leo entrada');
	leerEntrada(entrada);
	while (entrada.codObra <> 0) do begin
		writeln('agrego ordenado');
		insertarOrdenado(v[entrada.dia], entrada);
		writeln('leo entrada');
		leerEntrada(entrada);
	end;
end;

procedure minimo (var v : arrListasPorDia; var min : tEntradas);
var
	i, iMin : integer;
begin
	min.codObra := valorAlto; iMin := -1;
	for i := 1 to cantDias do begin
		if ((v[i] <> nil) and (v[i]^.datos.codObra < min.codObra)) then begin
			min := v[i]^.datos;
			iMin := i;
		end;
	end;
	if (iMin <> -1) then
		v[iMin] := v[iMin]^.sig;
end;

procedure agregarAtras (var lista, ultimo : nuevaLista; obra : tObra);
var
	nodo : nuevaLista;
begin
	new(nodo); 
	nodo^.datos := obra; 
	nodo^.sig := nil;
	
	if (lista = nil) then
		lista := nodo
	else
		ultimo^.sig := nodo;
	ultimo := nodo;
end;

procedure mergeAcumulador (var lista : nuevaLista; v : arrListasPorDia);
var
	min : tEntradas;
	obra : tObra;
	ultimo : nuevaLista;
begin
	lista := nil; ultimo := nil; 
	writeln('minimo');
	minimo(v, min);
	while (min.codObra <> valorAlto) do begin
		obra.codObra := min.codObra;
		obra.cantVendida := 0;
		while ((min.codObra <> valorAlto) and (obra.codObra = min.codObra)) do begin
			obra.cantVendida += 1;
			writeln('minimo');
			minimo(v, min);
		end;
		writeln('agrego atras');
		agregarAtras(lista, ultimo, obra);
	end;
end;
	
procedure informarDatos (lista : nuevaLista);
begin
	if (lista <> nil) then begin
		writeln(lista^.datos.codObra);
		writeln(lista^.datos.cantVendida);
		informarDatos(lista^.sig);
	end;
end;

//Programa Principal
var
	listaObras : nuevaLista;
	listasPorDia : arrListasPorDia;
begin
	generarListas(listasPorDia);
	mergeAcumulador(listaObras, listasPorDia);
end.
	
	
	
	
	
	
	
