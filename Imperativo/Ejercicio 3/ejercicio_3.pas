program tres;
const
	cantCategoria = 10;
	corte = -1;
type
	rangoCategoria = 1..cantCategoria;
	str10 = String[10];
	tAfiliado = record
		nroAfiliado, anioIngreso : integer;
		dni : str10;
		categoria : rangoCategoria;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato : tAfiliado;
		hi, hd : arbol;
	end;
	
	tAfiliadoVector = record
		nroAfiliado : integer;
		dni : str10;
	end;
	
	arrAfiliados = array[1..200] of tAfiliadoVector;
	
procedure leerAfiliado(var unAfiliado : tAfiliado);
begin
	with unAfiliado do begin
		writeln('Ingrese nro de afiliado'); readln(nroAfiliado);
		if (nroAfiliado <> corte) then begin
			writeln('Ingrese dni'); readln(dni);
			writeln('Ingrese categoria'); readln(categoria);
			writeln('Ingrese año de ingreso a la obra social'); readln(anioIngreso);
		end;
	end;
end;

procedure agregarElementoArbol(var a : arbol; unAfiliado : tAfiliado);
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
				agregarElementoArbol(a^.hi, unAfiliado)
end;

procedure generarArbol(var a : arbol);
var
	unAfiliado : tAfiliado;
begin
	a := nil;
	leerAfiliado(unAfiliado);
	while (unAfiliado.nroAfiliado <> corte) do begin
		agregarElementoArbol(a, unAfiliado);
		leerAfiliado(unAfiliado);
	end;
end;

procedure agregarElementoVector(var v : arrAfiliados; var dimL : integer; a : arbol; num1, num2, numCategoria : integer);
begin
	if ((dimL+1 <= 200) and (a <> nil)) then begin
		if ((num1 <= a^.dato.nroAfiliado) and (a^.dato.nroAfiliado <= num2) and (a^.dato.categoria = numCategoria)) then begin
			dimL += 1;
			v[dimL].nroAfiliado := a^.dato.nroAfiliado;
			v[dimL].dni := a^.dato.dni;
		end;
		agregarElementoVector(v, dimL, a^.hi, num1, num2, numCategoria);
		agregarElementoVector(v, dimL, a^.hd, num1, num2, numCategoria);
	end;
end;

procedure ordenarVector(var v : arrAfiliados; dimL : integer);
var
	i, j : integer;
	actual : tAfiliadoVector;
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

procedure generarVectorOrdenado(var v : arrAfiliados; var dimL : integer; a : arbol);
var
	nro1, nro2, nroCategoria : integer;
begin
	dimL := 0;
	writeln('Ingrese primer numero de afiliado'); readln(nro1);
	writeln('Ingress segundo numero de afiliado'); readln(nro2);
	writeln('Ingrese numero de categoria'); readln(nroCategoria);
	agregarElementoVector(v, dimL, a, nro1, nro2, nroCategoria);
	ordenarVector(v, dimL);
end;

//Programa Principal
var
	v : arrAfiliados;
	dimL : integer;
	a : arbol;
begin
	generarArbol(a);
	generarVectorOrdenado(v, dimL, a);
end.


