program dos;
const
	cantCentros = 10;
	corte = -1;
	valorAlto = 32767;
type
	rangoCentros = 1..cantCentros;
	str10 = String[10];

	tAuto = record
		patente, fecha : str10;
		nroMotor, cantRepuestos : integer;
		centro : rangoCentros;
	end;
	
	listaAutos = ^nodoLista;
	nodoLista = record
		dato : tAuto;
		sig : listaAutos;
	end;
	
	arrListasPorCentro = array[rangoCentros] of listaAutos;
	
	tRepuestosPorPatente = record
		patente : str10;
		cantRepuestos : integer;
	end;
	
	arbolAutos = ^nodoArbol;
	nodoArbol = record
		dato : tRepuestosPorPatente;
		hi, hd : arbolAutos;
	end;

procedure iniciarListas(var v : arrListasPorCentro);
var
	i : integer;
begin
	for i:= 1 to cantCentros do
		v[i] := nil;
end;

procedure leerAuto(var unAuto : tAuto);
begin
	with unAuto do begin
		writeln('Ingrese nro de motor'); readln(nroMotor);
		if (nroMotor <> corte) then begin
			writeln('Ingrese centro de atencion (1..10)'); readln(centro);
			writeln('Ingrese patente'); readln(patente);
			writeln('Ingrese la cantidad de repuestos reemplazados'); readln(cantRepuestos);
			writeln('Ingrese fecha'); readln(fecha);
		end;
	end;
end;

procedure insertarOrdenado(var l : listaAutos; unAuto : tAuto);
var
	nodo, act, ant : listaAutos;
begin
	new(nodo); nodo^.dato := unAuto;
	act := l;
	while ((act <> nil) and (act^.dato.nroMotor < unAuto.nroMotor)) do begin
		ant := act;
		act := act^.sig;
	end;
	if (l = act) then
		l := nodo
	else
		ant^.sig := nodo;
	nodo^.sig := act
end;

procedure cargar(var v : arrListasPorCentro);
var
	unAuto : tAuto;
begin
	iniciarListas(v);
	leerAuto(unAuto);
	while (unAuto.nroMotor <> corte) do begin
		insertarOrdenado(v[unAuto.centro], unAuto);
		leerAuto(unAuto);
	end;
end;

procedure minimo(var v : arrListasPorCentro; var min : tAuto);
var
	i, iMin : integer;
begin
	iMin := corte; min.nroMotor := valorAlto;
	for i:= 1 to cantCentros do begin
		if ((v[i] <> nil) and (v[i]^.dato.nroMotor < min.nroMotor)) then begin
			iMin := i;
			min := v[i]^.dato;
		end;
	end;
	if (iMin <> corte) then
		v[iMin] := v[iMin]^.sig;
end;

procedure agregarElemento(var a : arbolAutos; unAuto : tRepuestosPorPatente);
begin
	if (a = nil) then begin
		new(a);
		a^.dato := unAuto;
		a^.hi := nil;
		a^.hd := nil;
	end
	else
		if (a^.dato.patente < unAuto.patente) then
			agregarElemento(a^.hd, unAuto)
		else
			if (a^.dato.patente > unAuto.patente) then
				agregarElemento(a^.hi, unAuto);
end;

procedure mergeAcumulador(var a : arbolAutos; v : arrListasPorCentro);
var
	min, act : tAuto;
	aux : tRepuestosPorPatente;
begin
	a := nil;
	minimo(v, min);
	while(min.nroMotor <> valorAlto) do begin
		act.nroMotor := min.nroMotor;
		act.cantRepuestos := 0;
		while ((min.nroMotor <> valorAlto) and (act.nroMotor = min.nroMotor)) do begin
			act.cantRepuestos += min.cantRepuestos;
			minimo(v, min);
		end;
		aux.patente := act.patente;
		aux.cantRepuestos := act.cantRepuestos;
		agregarElemento(a, aux);
	end;
end;

var
	arbol : arbolAutos;
	listas : arrListasPorCentro;
begin
	cargar(listas);
	mergeAcumulador(arbol, listas);
end.
