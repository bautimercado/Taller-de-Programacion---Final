program finalBautistaMercado;
const
	cantCentros = 12;
	valorAlto = 'zzz';
type
	rangoCentros = 1..cantCentros;
	
	tEntregas = record
		codCliente, dniCliente, fecha : String;
		peso : real;
	end;
	
	lista = ^nodoLista;
	nodoLista = record
		dato : tEntregas;
		sig : lista;
	end;
	
	arrListasPorCentro = array[rangoCentros] of lista;
	
	tEntregaArbol = record
		codCliente : String;
		peso : real;
		centro : rangoCentros;
	end;
	
	arbol = ^nodoArbol;
	nodoArbol = record
		dato : tEntregaArbol;
		hi, hd : arbol;
	end;
	
procedure iniciarListas(var v : arrListasPorCentro);
var
	i : integer;
begin
	for i := 1 to cantCentros do
		v[i] := nil;
end;

procedure leerEntrega(var e : tEntregas; var centro : rangoCentros);
begin
	with e do begin
		writeln('Ingrese dni'); readln(dniCliente);
		if (dniCliente <> '0') then begin
			writeln('Ingrese codigo'); readln(codCliente);
			writeln('Ingrese fecha'); readln(fecha);
			writeln('Ingrese peso'); readln(peso);
			writeln('Ingrese centro 1..12'); readln(centro);
		end;
	end;
end;
procedure insertarOrdenado(var l : lista; e : tEntregas);
var
	act, ant, nodo : lista;
begin
	new(nodo);
	nodo^.dato := e;
	act := l;
	while ((act <> nil) and (act^.dato.dniCliente < e.dniCliente)) do begin
		ant := act;
		act := act^.sig;
	end;
	if (l = nil) then
		l := nodo
	else
		ant^.sig := nodo;
	nodo^.sig := act;
end;
	
procedure Entregas(var v : arrListasPorCentro);
var
	e : tEntregas;
	centro : rangoCentros;
begin
	iniciarListas(v);
	leerEntrega(e, centro);
	while (e.dniCliente <> '0') do begin
		insertarOrdenado(v[centro], e);
		leerEntrega(e, centro);
	end;
end;

procedure minimo(var v : arrListasPorCentro; var min : tEntregas; var centro : integer);
var
	i : integer;
begin
	centro := -1; min.dniCliente := valorAlto;
	for i := 1 to cantCentros do begin
		if ((v[i] <> nil) and (v[i]^.dato.dniCliente < min.dniCliente)) then begin
			min := v[i]^.dato;
			centro := i;
		end;
	end;
	if (centro <> -1) then
		v[centro] := v[centro]^.sig;
end;

procedure agregarElemento(var a : arbol; elemento : tEntregaArbol);
begin
	if (a = nil) then begin
		new(a);
		a^.dato := elemento;
		a^.hi := nil;
		a^.hd := nil;
	end
	else
		if (a^.dato.codCliente < elemento.codCliente) then
			agregarElemento(a^.hd, elemento)
		else
			if (a^.dato.codCliente > elemento.codCliente) then
				agregarElemento(a^.hi, elemento);
end;
		
procedure mergeAcumulador(var a : arbol; v : arrListasPorCentro);		
var
	min : tEntregas;
	centro : integer;
	aux : tEntregaArbol;
	dniActual : String;
begin
	a := nil;
	minimo(v, min, centro);
	while (min.dniCliente <> valorAlto) do begin
		dniActual := min.dniCliente;
		aux.peso := -32766;
		aux.codCliente := min.codCliente;
		while ((min.dniCliente <> valorAlto) and (dniActual = min.dniCliente)) do begin
			if (aux.peso < min.peso) then begin
				aux.peso := min.peso;
				aux.centro := centro;
			end;
			minimo(v, min, centro);
		end;
		agregarElemento(a, aux);
	end;
end;

procedure imprimirListas(v : arrListasPorCentro);
var
	i : integer;
begin
	for i := 1 to cantCentros do begin
		writeln('Centro ',i);
		while (v[i] <> nil) do begin
			with v[i]^.dato do begin
				writeln('DNI: ',dniCliente);
				writeln('Codigo: ',codCliente);
				writeln('Fecha: ',fecha);
				writeln('Peso: ',peso:4:2);
			end;
			v[i] := v[i]^.sig;
		end;
		writeln();
	end;
end;	

procedure imprimirEnOrden(a : arbol);
begin
	if (a <> nil) then begin
		imprimirEnOrden(a^.hi);
		with a^.dato do begin
			writeln('Codigo: ',codCliente);
			writeln('Peso: ',peso:4:2);
			writeln('Centro: ',centro);
		end;
		imprimirEnOrden(a^.hd);
	end;
end;

//Programa Principal
var
	a : arbol;
	listas : arrListasPorCentro;
begin
	Entregas(listas);
	imprimirListas(listas);
	mergeAcumulador(a, listas);
	imprimirEnOrden(a);
end.


