program tres;
const
	corte = 'zzz';
type
	str10 = String[10];
	rangoAnios = 2010..2018;
	tAuto = record
		patente, marca, modelo : str10;
		anioFabricacion : integer;
	end;
	
	arbol = ^nodoArbol;
	nodoArbol = record
		dato : tAuto;
		hi : arbol;
		hd : arbol;
	end;
	
	lista = ^nodoLista;
	nodoLista = record
		dato : tAuto;
		sig : lista;
	end;
	
	arrListasPorAnio = array[rangoAnios] of lista;

procedure iniciarListas(var listas : arrListasPorAnio);
var
	i : integer;
begin
	for i := 2010 to 2018 do
		listas[i] := nil;
end;

procedure leerAuto(var unAuto : tAuto);
begin
	with unAuto do begin
		writeln('Ingrese patente del auto'); readln(patente);
		if (patente <> corte) then begin
			writeln('Ingrese marca del auto'); readln(marca);
			writeln('Ingrese año de fabricacion'); readln(anioFabricacion);
			writeln('Ingrese modelo del auto'); readln(modelo);
		end;
	end;
end;

procedure agregarDatoArbol(var arbol : arbol; unAuto : tAuto);
begin
	if (arbol = nil) then begin
		new(arbol);
		arbol^.dato := unAuto;
		arbol^.hi := nil;
		arbol^.hd := nil;
	end
	else
		if (arbol^.dato.patente > unAuto.patente) then
			agregarDatoArbol(arbol^.hi, unAuto)
		else
			if (arbol^.dato.patente < unAuto.patente) then
				agregarDatoArbol(arbol^.hd, unAuto);
end;

procedure generarArbol(var arbol : arbol);
var
	unAuto : tAuto;
begin
	arbol := nil; leerAuto(unAuto);
	while (unAuto.patente <> corte) do begin
		agregarDatoArbol(arbol, unAuto);
		leerAuto(unAuto);
	end;
end;

procedure cantidadDeAutosPorMarca(arbol : arbol; marca : str10; var cant : integer);
begin
	if (arbol <> nil) then begin
		if (arbol^.dato.marca = marca) then
			cant += 1;
		cantidadDeAutosPorMarca(arbol^.hi, marca, cant);
		cantidadDeAutosPorMarca(arbol^.hd, marca, cant);
	end; 
end;

procedure agregarDatoLista(var lista : lista; unAuto : tAuto);
var
	nodo : lista;
begin
	new(nodo);
	nodo^.dato := unAuto;
	nodo^.sig := lista;
	lista := nodo;
end;

procedure generarListas(var listas : arrListasPorAnio; arbol : arbol);
begin
	if (arbol <> nil) then begin
		agregarDatoLista(listas[arbol^.dato.anioFabricacion], arbol^.dato);
		generarListas(listas, arbol^.hi);
		generarListas(listas, arbol^.hd);
	end;
end;

function buscarAutoPorPatente(arbol : arbol; unaPatente : str10):arbol;
begin
	if (arbol <> nil) then
		if (arbol^.dato.patente = unaPatente) then
			buscarAutoPorPatente := arbol
		else
			if (arbol^.dato.patente < unaPatente) then
				buscarAutoPorPatente := buscarAutoPorPatente(arbol^.hd, unaPatente)
			else
				buscarAutoPorPatente := buscarAutoPorPatente(arbol^.hi, unaPatente)
	else
		buscarAutoPorPatente := nil;
end;

//Programa Principal
var
	arbolAutos, autoBuscado : arbol;
	listas : arrListasPorAnio;
	cantAutos : integer;
	patente, marca : str10;
begin
	generarArbol(arbolAutos);
	
	cantAutos := 0;
	writeln('Ingrese una marca'); readln(marca);
	cantidadDeAutosPorMarca(arbolAutos, marca, cantAutos);
	writeln('La cantidad de autos de ',marca,' es: ',cantAutos);
	
	iniciarListas(listas);
	generarListas(listas, arbolAutos);
	writeln('Listas generadas');
	
	writeln('Ingrese una patente'); readln(patente);
	autoBuscado := buscarAutoPorPatente(arbolAutos, patente);
	if (autoBuscado = nil) then
		writeln('No se encontró la patente ',patente,' :(')
	else
		writeln(autoBuscado^.dato.patente,' ',autoBuscado^.dato.anioFabricacion);
	
end.
