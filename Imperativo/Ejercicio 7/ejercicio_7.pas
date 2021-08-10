program siete;
const
	corte = -1;
	cantPlanes = 15;
	cantAfiliados = 300;
type
	rangoAfiliados = 1..cantAfiliados;
	rangoPlanes = 1..cantPlanes;
	str8 = String[8];
	tAfiliado = record
		plan : rangoPlanes;
		nroAfiliado, anioIngreso : integer;
		dni : str8;
	end;
	
	arbolAfiliados = ^nodo;
	nodo = record
		dato : tAfiliado;
		hi, hd : arbolAfiliados;
	end;
	tAfiliadoPlan = record
		nroAfiliado : integer;
		dni : str8;
	end;
	
	arrAfiliados = array[rangoAfiliados] of tAfiliadoPlan;
	
procedure leerAfiliado(var unAfiliado : tAfiliado);
begin
	with unAfiliado do begin
		writeln('Ingrese numero de afiliado'); readln(nroAfiliado);
		if (nroAfiliado <> corte) then begin
			writeln('Ingrese DNI'); readln(dni);
			writeln('Ingrese anio de ingreso a la obra social'); readln(anioIngreso);
			writeln('Ingrese plan (1..15)'); readln(plan);
		end;
	end;
	writeln('////////////////////////////////////////////////////////////////////');
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

procedure agregarElementoVector(var v : arrAfiliados; a : arbolAfiliados; num1, num2, numPlan : integer; var dimL : integer);
begin
	if ((a <> nil) and (dimL+1<=cantAfiliados)) then begin
		agregarElementoVector(v, a^.hi, num1, num2, numPlan, dimL);
		if ((num1 <= a^.dato.nroAfiliado) and (a^.dato.nroAfiliado <= num2) and (a^.dato.plan = numPlan)) then begin
			dimL += 1;
			v[dimL].nroAfiliado := a^.dato.nroAfiliado;
			v[dimL].dni := a^.dato.dni;
		end;
		agregarElementoVector(v, a^.hd, num1, num2, numPlan, dimL);
	end;
end;

procedure generarVector(var v : arrAfiliados; var dimL : integer; a : arbolAfiliados);
var
	num1, num2, numPlan : integer;
begin
	dimL := 0;
	writeln('Ingrese nro 1 de afiliado'); readln(num1);
	writeln('Ingrese nro 2 de afiliado'); readln(num2);
	writeln('Ingrese numero de plan (1..15)'); readln(numPlan);
	if ((num1 > num2) and ((1 > numPlan) or (numPlan > 15))) then
		writeln('ERROR')
	else
		agregarElementoVector(v, a, num1, num2, numPlan, dimL);
end;

procedure enOrden(a : arbolAfiliados);
begin
	if (a <> nil) then begin
		enOrden(a^.hi);
		writeln('-------------------------------------------------------------');
		writeln('Numero de afiliado: ', a^.dato.nroAfiliado);
		writeln('DNI: ',a^.dato.dni);
		writeln('Anio de ingreso: ',a^.dato.anioIngreso);
		writeln('Plan: ',a^.dato.plan);
		writeln('-------------------------------------------------------------');
		enOrden(a^.hd); 
	end;
end;

procedure imprimirVector(v : arrAfiliados; dimL : integer);
var
	i : integer;
begin
	for i := 1 to dimL do begin
		writeln('-------------------------------------------------------------');
		writeln('Numero de afiliado: ',v[i].nroAfiliado);
		writeln('DNI: ',v[i].dni);
		writeln('-------------------------------------------------------------');
	end;
end;


var
	afiliados : arrAfiliados;
	dimL : integer;
	arbol : arbolAfiliados;
begin
	generarArbol(arbol);
	enOrden(arbol);
	generarVector(afiliados, dimL, arbol);
	imprimirVector(afiliados, dimL);
end.
