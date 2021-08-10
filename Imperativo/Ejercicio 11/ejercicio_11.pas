program once;
const
	cantSucursales = 8;
	corte = '0';
	valorAltoString = 'zzz';
type
	str10 = String[10];
	
	rangoSucursales = 1..cantSucursales;
	
	tProducto = record
		codProducto, descripcion : str10;
		precio : real;
		stock : integer;
	end;
	
	listaProductos = ^nodo;
	nodo = record
		dato : tProducto;
		sig : listaProductos;
	end;
	
	arrListasPorSucursal = array[rangoSucursales] of listaProductos;
	
	tProductoStockMax = record
		stockMaximo : integer;
		sucursal : rangoSucursales;
		codProducto : str10;
	end;
	
	nuevaLista = ^nuevoNodo;
	nuevoNodo = record
		dato : tProductoStockMax;
		sig : nuevaLista;
	end;
	
procedure iniciarListas(var v : arrListasPorSucursal);
var
	i : integer;
begin
	for i := 1 to cantSucursales do
		v[i] := nil;
end;
	
procedure leerProducto(var unProducto : tProducto; var sucursal : rangoSucursales);
begin
	with unProducto do begin
		writeln('Ingrese codigo de producto: '); readln(codProducto);
		if (codProducto <> corte) then begin
			writeln('Ingrese descripcion: '); readln(descripcion);
			writeln('Ingrese precio: '); readln(precio);
			writeln('Ingrese stock: '); readln(stock);
			writeln('Ingrese sucursal (1..5): '); readln(sucursal);
		end; 
	end;
	writeln();
end;

procedure insertarOrdenado(var l : listaProductos; unProducto : tProducto);
var
	act, ant, nodo : listaProductos;
begin
	new(nodo);
	nodo^.dato := unProducto;
	act := l;
	while ((act <> nil) and (act^.dato.codProducto < unProducto.codProducto)) do begin
		ant := act;
		act := act^.sig;
	end;
	if (l = nil) then
		l := nodo
	else
		ant^.sig := nodo;
	nodo^.sig := act;
end;

procedure generarListas(var v : arrListasPorSucursal);
var
	unProducto : tProducto;
	sucursal : rangoSucursales;
begin
	iniciarListas(v);
	leerProducto(unProducto, sucursal);
	while (unProducto.codProducto <> corte) do begin
		insertarOrdenado(v[sucursal], unProducto);
		leerProducto(unProducto, sucursal);
	end;
end;

procedure imprimirListas(v : arrListasPorSucursal);
var
	i : integer;
begin
	for i := 1 to cantSucursales do begin
		writeln('Sucursal ',i,': ');
		while (v[i] <> nil) do begin
			with v[i]^.dato do begin
				writeln('  Codigo de producto: ',codProducto);
				writeln('  Descripcion: ',descripcion);
				writeln('  Precio: ',precio:4:2);
				writeln('  Stock: ',stock);
			end;
			v[i] := v[i]^.sig;
			writeln();
		end;
		writeln('----------------------------------------------------------');
	end;
end;

procedure minimo(var v : arrListasPorSucursal; var min : tProducto; var sucursal : integer);
var
	i : integer;
begin
	sucursal := -1; min.codProducto := valorAltoString;
	for i := 1 to cantSucursales do begin
		if ((v[i] <> nil) and (v[i]^.dato.codProducto < min.codProducto)) then begin
			sucursal := i;
			min := v[i]^.dato;
		end;
	end;
	if (sucursal <> -1) then
		v[sucursal] := v[sucursal]^.sig;
end;

procedure agregarAtras(var l, ult : nuevaLista; var unProducto : tProductoStockMax);
var
	nodo : nuevaLista;
begin
	new(nodo);
	nodo^.dato := unProducto;
	nodo^.sig := nil;
	if (l = nil) then
		l := nodo
	else
		ult^.sig := nodo;
	ult := nodo;
end;

procedure mergeAcumulador(var l : nuevaLista; v : arrListasPorSucursal);
var
	ult : nuevaLista;
	min : tProducto;
	sucursal : integer;
	aux : tProductoStockMax;
begin
	l := nil; ult := nil;
	minimo(v, min, sucursal);
	while (min.codProducto <> valorAltoString) do begin
		aux.codProducto := min.codProducto;
		aux.stockMaximo := -32767;
		while ((min.codProducto <> valorAltoString) and (aux.codProducto = min.codProducto)) do begin
			if (aux.stockMaximo < min.stock) then begin
				aux.stockMaximo := min.stock;
				aux.sucursal := sucursal;
			end;
			minimo(v, min, sucursal);
		end;
		agregarAtras(l, ult, aux);
	end;
end;

procedure imprimirListaNueva(l : nuevaLista);
begin
	while (l <> nil) do begin
		with l^.dato do begin
			writeln();
			writeln('Codigo de producto: ',codProducto);
			writeln('Stock maximo: ',stockMaximo);
			writeln('Sucursal: ',sucursal);
			writeln();
		end;
		l := l^.sig;
	end;
end;

//Programa Principal
var
	l : nuevaLista;
	listas : arrListasPorSucursal;
begin
	generarListas(listas);
	imprimirListas(listas);
	mergeAcumulador(l, listas);
	imprimirListaNueva(l);
end.





