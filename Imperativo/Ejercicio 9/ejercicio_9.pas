program nueve;
const
	cantPlanes = 5;
	cantAfiliados = 500;
	corte = -1;
type
	rangoAfiliados = 1..cantAfiliados;
	rangoPlanes = 1..cantPlanes;
	
	tAfiliado = record
		nroAfiliado, anioIngreso : integer;
		dni : String;
		plan : rangoPlanes;
	end;
	
	arbolAfiliados = ^nodo;
	nodo = record
		dato : tAfiliado;
		hi, hd : arbolAfiliados;
	end;
	
	tAfiliadoVector = record
		nroAfiliado : integer;
		dni : String;
	end;
	
	arrAfiliados = array[rangoAfiliados] of tAfiliadoVector;
	
procedure leerAfiliado(var unAfiliado : tAfiliado);
begin
	writeln();
	with unAfiliado do begin
		writeln('Ingrese numero de afiliado'); readln(nroAfiliado);
		if (nroAfiliado <> corte) then begin
			writeln('Ingrese DNI'); readln(dni);
			writeln('Ingrese anio de ingreso a la obra social'); readln(anioIngreso);
			writeln('Ingrese su plan (1..5)'); readln(plan);
		end;
	end;
	writeln('///////////////////////////////////////////////////////////////////////');
end;

procedure agregarElementoArbol(var a : arbolAfiliados; unAfiliado : tAfiliado);
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

procedure generarArbol(var a : arbolAfiliados);
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

procedure imprimirArbolEnOrden(a : arbolAfiliados);
begin
	if (a <> nil) then begin
		imprimirArbolEnOrden(a^.hi);
		writeln('-----------------------------------------------------------------');
		writeln('Numero de afiliado: ',a^.dato.nroAfiliado);
		writeln('DNI: ',a^.dato.dni);
		writeln('Anio de ingreso: ',a^.dato.anioIngreso);
		writeln('Plan: ',a^.dato.plan);
		writeln('-----------------------------------------------------------------');
		imprimirArbolEnOrden(a^.hd);
	end;
end;

procedure generarVector(var v : arrAfiliados; var dimL : integer; num1, num2 : string; numPlan : integer; a : arbolAfiliados);
begin
	if ((a <> nil) and (dimL+1 <= cantAfiliados)) then begin
		if ((num1 <= a^.dato.dni) and (a^.dato.dni <= num2) and (a^.dato.plan = numPlan)) then begin
			dimL += 1;
			v[dimL].nroAfiliado := a^.dato.nroAfiliado;
			v[dimL].dni := a^.dato.dni;
		end;
		generarVector(v, dimL, num1, num2, numPlan, a^.hi);
		generarVector(v, dimL, num1, num2, numPlan, a^.hd);
	end;
end;

procedure ordenarVector(var v : arrAfiliados; dimL : integer);
var
	i, j : integer;
	act : tAfiliadoVector;
begin
	for i := 2 to dimL do begin
		act := v[i];
		j := i - 1;
		while ((j > 0) and (v[j].dni > act.dni)) do begin
			v[j+1] := v[j];
			j -= 1;
		end;
		v[j+1] := act;
	end;
end;

procedure generarVectorOrdenado(var v : arrAfiliados; var dimL : integer; a : arbolAfiliados);
var
	num1, num2 : string;
	numPlan : integer;
begin
	dimL := 0;
	writeln('Ingrese numero 1 de DNI'); readln(num1);
	writeln('ingrese numero 2 de DNI'); readln(num2);
	writeln('Ingrese numero de plan (1..5)'); readln(numPlan);
	if ((num1 > num2) and ((1 > numPlan) or (numPlan > 5))) then
		writeln('ERROR')
	else begin
		generarVector(v, dimL, num1, num2, numPlan, a);
		ordenarVector(v, dimL);
	end;
end;

procedure imprimirVector(v : arrAfiliados; dimL : integer);
var
	i : integer;
begin
	for i := 1 to dimL do begin
		writeln('--------------------------------------------------------------');
		writeln('DNI: ',v[i].dni);
		writeln('Numero de afiliado: ',v[i].nroAfiliado);
		writeln('--------------------------------------------------------------');
	end;
end;

//Programa Principal
var
	vectorAfiliados : arrAfiliados;
	dimL : integer;
	arbol : arbolAfiliados;
begin
	generarArbol(arbol);
	imprimirArbolEnOrden(arbol);
	generarVectorOrdenado(vectorAfiliados, dimL, arbol);
	imprimirVector(vectorAfiliados, dimL);
end.



