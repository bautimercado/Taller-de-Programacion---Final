program cinco;
const
	cantCentros = 10;
	corte = '0';
	valorAlto = 'zzz';
type
	rangoCentros = 1..cantCentros;
	str10 = String[10];
	tEntrega = record
		codCliente, dni, fecha : str10;
		peso : real;
	end;
	
	listaEntregas = ^nodoLista;
	nodoLista = record
		dato : tEntrega;
		sig : listaEntregas;
	end;
	
	arrListasPorCentro = array[rangoCentros] of listaEntregas;
	
	tPesoDeEntrega = record
		pesoTotal : real;
		codCliente : str10;
	end;
	
	arbolEntregas = ^nodoArbol;
	nodoArbol = record
		dato : tPesoDeEntrega;
		hi, hd : arbolEntregas;
	end;

procedure iniciarListas(var v : arrListasPorCentro);
var
	i : integer;
begin
	for i:= 1 to cantCentros do
		v[i] := nil;
end;

procedure leerEntrega(var unaEntrega : tEntrega; var centro : integer);
begin
	with unaEntrega do begin
		writeln('Ingrese DNI'); readln(dni);
		if (dni <> corte) then begin
			writeln('Ingrese nro de centro (1..10)'); readln(centro);
			writeln('Ingrese codigo de cliente'); readln(codCliente);
			writeln('Ingrese peso del paquete'); readln(peso);
			writeln('Ingrese fecha'); readln(fecha);
		end;
	end;
end;

procedure insertarOrdenado(var l : listaEntregas; unaEntrega : tEntrega);
var
	nodo, act, ant : listaEntregas;
begin
	new(nodo); nodo^.dato := unaEntrega;
	act := l;
	while ((act <> nil) and (act^.dato.codCliente < unaEntrega.codCliente)) do begin
		ant := act;
		act := act^.sig;
	end;
	if (l = act) then
		l := nodo
	else
		ant^.sig := nodo;
	nodo^.sig := act;
end;

procedure Entregas(var v : arrListasPorCentro);
var
	unaEntrega : tEntrega;
	centro : integer;
begin
	iniciarListas(v);
	leerEntrega(unaEntrega, centro);
	while (unaEntrega.dni <> corte) do begin
		insertarOrdenado(v[centro], unaEntrega);
		leerEntrega(unaEntrega, centro);
	end;
end;

procedure minimo(var v : arrListasPorCentro; var min : tEntrega);
var
	i, iMin : integer;
begin
	iMin := -1; min.dni := valorAlto;
	for i:= 1 to cantCentros do begin
		if ((v[i] <> nil) and (v[i]^.dato.dni < min.dni)) then begin
			min := v[i]^.dato;
			iMin := i;
		end;
	end;
	if (iMin <> -1) then
		v[iMin] := v[iMin]^.sig;
end;

procedure agregarElemento(var a : arbolEntregas; unaEntrega : tPesoDeEntrega);
begin
	if (a = nil) then begin
		new(a);
		a^.dato := unaEntrega;
		a^.hi := nil;
		a^.hd := nil;
	end
	else
		if (a^.dato.codCliente < unaEntrega.codCliente) then
			agregarElemento(a^.hd, unaEntrega)
		else
			if (a^.dato.codCliente > unaEntrega.codCliente) then
				agregarElemento(a^.hi, unaEntrega);
end;

procedure mergeAcumulador(var a : arbolEntregas; v : arrListasPorCentro);
var
	min, act : tEntrega;
	aux : tPesoDeEntrega;
begin
	a := nil;
	minimo(v, min);
	while(min.dni <> valorAlto) do begin
		act.codCliente := min.codCliente;
		act.peso := 0;
		act.dni := min.dni;
		while ((min.dni <> valorAlto) and (act.dni = min.dni)) do begin
			act.peso += min.peso;
			minimo(v,min);
		end;
		aux.codCliente := act.codCliente;
		aux.pesoTotal := act.peso;
		agregarElemento(a, aux);
	end;
end;

//Programa Principal
var
	arbol : arbolEntregas;
	listas : arrListasPorCentro;
begin
	Entregas(listas);
	mergeAcumulador(arbol, listas);
end.
	
