program seis;
const
	cantCategorias = 10;
	cantAfiliados = 200;
	corte = -1;
type
	rangoCategoria = 1..cantCategorias;
	rangoAfiliados = 1..cantAfiliados;
	str8 = String[8];
	
	tAfiliadoArbol = record
		nroAfiliado, anioIngreso : integer;
		dni : Str8;
		categoria : rangoCategoria;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato : tAfiliadoArbol;
		hi, hd : arbol;
	end;
	
	tAfiliadoArray = record
		nroAfiliado : integer;
		dni : str8;
	end;
	
	arrAfiliados = array[rangoCategoria] of tAfiliadoArray;
	
procedure leerAfiliado(var unAfiliado : tAfiliadoArbol);
begin
	with unAfiliado do begin
		writeln('Ingrese nro de afiliado (ingrese -1 para detener el ingreso de datos)'); readln(nroAfiliado);
		if (nroAfiliado <> corte) then begin
			writeln('Ingrese categoria (1..10)'); readln(categoria);
			writeln('Ingrese anio de ingreso a la obra social'); readln(anioIngreso);
			writeln('Ingrese dni'); readln(dni);
		end;
	end;
	writeln('------------------------------------------------------------------------------------------------------');
end;

procedure agregarElementoArbol(var a : arbol; unAfiliado : tAfiliadoArbol);
begin
	if (a = nil) then begin
		new(a);
		a^.dato := unAfiliado;
		a^.hi := nil;
		a^.hd := nil;
	end
	else
		if (a^.dato.nroAfiliado < unAfiliado.nroAfiliado) then
			agregarElementoArbol(a^.hd, unAfiliado)
		else
			if (a^.dato.nroAfiliado > unAfiliado.nroAfiliado) then
				agregarElementoArbol(a^.hi, unAfiliado);
end;

procedure generarArbol(var a : arbol);
var
	unAfiliado : tAfiliadoArbol;
begin
	a := nil;
	leerAfiliado(unAfiliado);
	while(unAfiliado.nroAfiliado <> corte) do begin
		agregarElementoArbol(a, unAfiliado);
		leerAfiliado(unAfiliado);
	end;
end;

procedure imprimirArbol(a : arbol);
begin
	if (a <> nil) then begin
		imprimirArbol(a^.hi);
		writeln('Numero de afiliado: ',a^.dato.nroAfiliado);
		writeln('DNI: ',a^.dato.dni);
		writeln('Anio de ingreso: ',a^.dato.anioIngreso);
		writeln('Categoria: ',a^.dato.categoria);
		writeln('-------------------------------------');
		imprimirArbol(a^.hd);
	end;
end;

procedure agregarElementoArray(a : arbol; num1, num2, numCategoria : integer; var v : arrAfiliados; var dimL : integer);
begin
	if (a <> nil) then begin
		if ((dimL+1<=cantAfiliados) and (num1 <= a^.dato.nroAfiliado) and (a^.dato.nroAfiliado <= num2) and (a^.dato.categoria = numCategoria)) then begin
			dimL += 1;
			v[dimL].nroAfiliado := a^.dato.nroAfiliado;
			v[dimL].dni := a^.dato.dni;
		end;
		agregarElementoArray(a^.hi, num1, num2, numCategoria, v, dimL);
		agregarElementoArray(a^.hd, num1, num2, numCategoria, v, dimL);
	end;
end;

procedure ordenarArray(var v : arrAfiliados; dimL : integer);
var
	i, j : integer;
	actual : tAfiliadoArray;
begin
	for i := 2 to dimL do begin
		j := i - 1;
		actual := v[i];
		while ((j > 0) and (v[j].dni > actual.dni)) do begin
			v[j+1] := v[j];
			j -= 1;
		end;
		v[j+1] := actual;
	end;
end;

procedure generarArray(var v : arrAfiliados; var dimL : integer; a : arbol);
var
	num1, num2, numCategoria : integer;
begin
	dimL := 0;
	writeln('GENERANDO VECTOR');
	writeln('Ingreso primer numero de afiliado'); readln(num1); 
	writeln('Ingrese segundo numero de afiliado'); readln(num2);
	if (num1 <= num2) then begin
		writeln('Ingrese numero de categoria'); readln(numCategoria);
		agregarElementoArray(a, num1, num2, numCategoria, v, dimL);
		ordenarArray(v, dimL);
	end
	else
		writeln('ERROR');
end;
	

procedure imprimirArray(v : arrAfiliados; dimL : integer);
var
	i : integer;
begin
	for i := 1 to dimL do begin
		writeln('DNI: ',v[i].dni);
		writeln('Numero de afiliado: ',v[i].nroAfiliado);
		writeln('--------------------------------------------------------');
	end;
end;

//Programa Principal
var
	vectorAfiliados : arrAfiliados;
	dimL : integer;
	arbolAfiliados : arbol;
begin
	generarArbol(arbolAfiliados);
	imprimirArbol(arbolAfiliados);
	generarArray(vectorAfiliados, dimL, arbolAfiliados);
	imprimirArray(vectorAfiliados, dimL);
end.
