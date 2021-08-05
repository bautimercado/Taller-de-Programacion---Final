program ocho;
const
	cantSucursales = 8;
	corte = '0';
	valorAlto = 'zzz';
	valorBajo = -32767;
type
	rangoSucursales = 1..cantSucursales;
	str10 = String[10];
	tProducto = record
		codProducto, descripcion : str10;
		stock : integer;
		precio : real;
		sucursal : rangoSucursales;
	end;
	
	lista = ^nodo;
	nodo = record
		dato : tProducto;
		sig : lista;
	end;
	
	arrListasPorSucursal = array[rangoSucursales] of lista;
	
	tProductoStockMaximo = record
		codProducto : str10;
		stockMaximo : integer;
		sucursal : rangoSucursales;
	end;
	
	nuevaLista = ^nuevoNodo;
	nuevoNodo = record
		dato : tProductoStockMaximo;
		sig : nuevaLista;
	end;
	
	
procedure iniciarListas(v : arrListasPorSucursal);
var
	i : integer;
begin
	for i := 1 to cantSucursales do
		v[i] := nil;
end;

procedure leerProducto(var unProducto : tProducto);
begin
	with unProducto do begin
		writeln('Ingrese codigo de producto'); readln(codProducto);
		if (codProducto <> corte) then begin
			writeln('Ingrese descripcion'); readln(descripcion);
			writeln('Ingrese stock'); readln(stock);
			writeln('Ingrese precio'); readln(precio);
			writeln('Ingrese sucursal'); readln(sucursal);
		end;
	end;
end;

procedure insertarOrdenado(var l : lista; unProducto : tProducto);
var
	nodo, act, ant : lista;
begin
	new(nodo); nodo^.dato := unProducto; act := l;
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

procedure Generar(var v : arrListasPorSucursal);
var
	unProducto : tProducto;
begin
	iniciarListas(v);
	leerProducto(unProducto);
	while (unProducto.codProducto <> corte) do begin
		insertarOrdenado(v[unProducto.sucursal],unProducto);
		leerProducto(unProducto);
	end;
end;

procedure minimo(var v : arrListasPorSucursal; var min : tProducto);
var
	i, iMin : integer;
begin
	iMin := -1; min.codProducto := valorAlto;
	for i := 1 to cantSucursales do begin
		if ((v[i] <> nil) and (v[i]^.dato.codProducto < min.codProducto)) then begin
			iMin := i;
			min := v[i]^.dato;
		end;
	end;
	if (iMin <> -1) then
		v[iMin] := v[iMin]^.sig;
end;

procedure agregarAtras(var l, ult : nuevaLista; var unProducto : tProductoStockMaximo);
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

procedure mergeAcumulador(var l : nuevaLista; v : arrListasPorSucursal);
var
	min, act : tProducto;
	aux : tProductoStockMaximo;
	ult : nuevaLista;
begin
	l := nil; ult := nil;
	minimo(v, min);
	while (min.codProducto <> valorAlto) do begin
		act.codProducto := min.codProducto;
		act.stock := valorBajo;
		while ((min.codProducto <> valorAlto) and (act.codProducto = min.codProducto)) do begin
			if (act.stock < min.stock) then begin
				act.stock := min.stock;
				act.sucursal := min.sucursal;
			end;
			minimo(v, min);
		end;
		aux.stockMaximo := act.stock;
		aux.sucursal := act.sucursal;
		aux.codProducto := act.codProducto;
		agregarAtras(l, ult, aux);
	end;
end;

//Programa Principal
var
	listas : arrListasPorSucursal;
	listaStockMaximo : nuevaLista;
begin
	Generar(listas);
	mergeAcumulador(listaStockMaximo, listas);
end.
