program doce;
const
	cantCentros = 10;
	valorAlto = 32765;
	corte = -1;
type
	rangoCentros = 1..cantCentros;
	
	str10 = String[10];
	
	tServicio = record
		patente, fecha : str10;
		nroMotor, cantRepuestos : integer;
	end;
	
	lista = ^nodoLista;
	nodoLista = record
		dato : tServicio;
		sig : lista;
	end;
	
	arrListasPorCentro = array[rangoCentros] of lista;
	
	tAuto = record
		patente : str10;
		cantRepuestosTotales : integer;
	end;
	
	arbol = ^nodoArbol;
	nodoArbol = record
		dato : tAuto;
		hi, hd : arbol;
	end;
	
procedure iniciarListas(var v : arrListasPorCentro);
var
	i : integer;
begin
	for i := 1 to cantCentros do
		v[i] := nil;
end;

procedure insertarOrdenado(var l : lista; unServicio : tServicio);
var
	nodo, act, ant : lista;
begin
	new(nodo);
	nodo^.dato := unServicio;
	act := l;
	while ((act <> nil) and (act^.dato.nroMotor < unServicio.nroMotor)) do begin
		ant := act;
		act := act^.sig;
	end;
	if (l = nil) then
		l := nodo
	else
		ant^.sig := nodo;
	nodo^.sig := act;
end;

procedure leerServicio(var unServicio : tServicio; var centro : rangoCentros);
begin
	writeln();
	with unServicio do begin
		writeln('Ingrese numero de motor'); readln(nroMotor);
		if (nroMotor <> corte) then begin
			writeln('Ingrese patente'); readln(patente);
			writeln('Ingrese fecha'); readln(fecha);
			writeln('Ingrese cantidad de repuestos reemplazados'); readln(cantRepuestos);
			writeln('Ingrese centro de atencion (1..10)'); readln(centro);
		end;
	end;
end;

procedure Cargar(var v : arrListasPorCentro);
var
	unServicio : tServicio;
	centro : rangoCentros;
begin
	iniciarListas(v);
	leerServicio(unServicio, centro);
	while (unServicio.nroMotor <> corte) do begin
		insertarOrdenado(v[centro], unServicio);
		leerServicio(unServicio, centro);
	end;
	writeln();
end;

procedure imprimirListas(v : arrListasPorCentro);
var
	i : integer;
begin
	for i := 1 to cantCentros do begin
		writeln('Centro de atencion ',i,': ');
		while (v[i] <> nil) do begin
			writeln('-------------------------------------------');
			with v[i]^.dato do begin
				writeln('Numero de motor: ',nroMotor);
				writeln('Patente: ',patente);
				writeln('Fecha: ',fecha);
				writeln('Cantidad de repuestos reemplazados: ',cantRepuestos);
			end;
			writeln('-------------------------------------------');
			v[i] := v[i]^.sig;
		end;
	end;
end;

procedure minimo(var v : arrListasPorCentro; var min : tServicio);
var
	i, iMin : integer;
begin
	writeln('minimo');
	iMin := -1; min.nroMotor := valorAlto;
	for i := 1 to cantCentros do begin
		if ((v[i] <> nil) and (v[i]^.dato.nroMotor < min.nroMotor)) then begin
			min := v[i]^.dato;
			iMin := i;
		end;
	end;
	if (iMin <> -1) then
		v[iMin] := v[iMin]^.sig;
end;

procedure agregarElemento(var a : arbol; unAuto : tAuto);
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

procedure mergeAcumulador(var a : arbol; v : arrListasPorCentro);
var
	aux : tAuto;
	min : tServicio;
	nroMotorActual : integer;
begin
	a := nil;
	minimo(v, min);
	while (min.nroMotor <> valorAlto) do begin
		nroMotorActual := min.nroMotor;
		aux.patente := min.patente;
		aux.cantRepuestosTotales := 0;
		while ((min.nroMotor <> valorAlto) and (nroMotorActual = min.nroMotor)) do begin
			writeln('corte de control');
			aux.cantRepuestosTotales += min.cantRepuestos;
			minimo(v, min);
		end;
		writeln('agrego elemento');
		agregarElemento(a, aux);
	end;
end;

procedure imprimirEnOrden(a : arbol);
begin
	if (a <> nil) then begin
		imprimirEnOrden(a^.hi);
		with a^.dato do begin
			writeln('-------------------------------------------');
			writeln('Patente: ',patente);
			writeln('Cantidad de repuestos reemplazados en total: ',cantRepuestosTotales);
			writeln('-------------------------------------------');
		end;
		imprimirEnOrden(a^.hd);
	end;
end;

//Programa Principal
var
	listas : arrListasPorCentro;
	arbolAutos : arbol;
begin
	Cargar(listas);
	imprimirListas(listas);
	writeln('merge');
	mergeAcumulador(arbolAutos, listas);
	imprimirEnOrden(arbolAutos);
end.
