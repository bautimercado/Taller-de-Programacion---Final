program uno;
const
	cantPlanes = 10;
	cantAfiliados = 250;
	corte = -1;
type
	cuil = String[11];
	rangoAfiliados = 1..250;
	rangoPlanes = 1..10;


	tAfiliado = record
		nroAfiliado : integer;
		nroCuil : cuil;
		plan : rangoPlanes;
		anioIngreso : integer;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato : tAfiliado;
		hi : arbol;
		hd : arbol;
	end;
	
	tPlan = record
		nroAfiliado : integer;
		nroCuil : cuil;
	end;
	
	arrPlan = array[rangoAfiliados] of tPlan;
	
procedure agregarElemento(var a : arbol; elemento : tAfiliado);
begin
	if (a = nil) then begin
		new(a);
		a^.dato := elemento;
		a^.hi := nil;
		a^.hd := nil;
	end
	else
		if (a^.dato.nroAfiliado > elemento.nroAfiliado) then
			agregarElemento(a^.hi, elemento)
		else
			if (a^.dato.nroAfiliado < elemento.nroAfiliado) then
				agregarElemento(a^.hd, elemento);
end;

procedure leerAfiliado(var afiliado : tAfiliado);
begin
	with afiliado do begin
		writeln('Ingrese numero de afiliado'); readln(nroAfiliado);
		if (nroAfiliado <> corte) then begin
			writeln('Ingrese numero de CUIL'); readln(nroCuil);
			writeln('Ingrese plan'); readln(plan);
			writeln('Ingrese año de ingreso a la obra social'); readln(anioIngreso);
		end;
	end;
end;

procedure generarArbol(var a : arbol);
var
	elemento : tAfiliado;
begin
	a := nil;
	leerAfiliado(elemento);
	while (elemento.nroAfiliado <> corte) do begin
		agregarElemento(a, elemento);
		leerAfiliado(elemento);
	end;
end;

procedure generarVector(a : arbol; var v : arrPlan; var dimL : integer; nro1, nro2 : cuil; plan : integer);
begin
	if ((a <> nil) and (dimL+1 <= cantAfiliados)) then begin
		if ((a^.dato.plan = plan) and (nro1 <= a^.dato.nroCuil) and (a^.dato.nroCuil <= nro2)) then begin
			dimL += 1;
			v[dimL].nroAfiliado := a^.dato.nroAfiliado;
			v[dimL].nroCuil := a^.dato.nroCuil;
		end;
		generarVector(a^.hi, v, dimL, nro1, nro2, plan);
		generarVector(a^.hd, v, dimL, nro1, nro2, plan);
	end;
end;

procedure ordenarVector(var v : arrPlan; dimL : integer);
var
	i, j : integer;
	actual : tPlan;
begin
	for i := 2 to cantPlanes do begin
		j := i-1;
		actual := v[i];
	
		while ((j > 0) and (v[j].nroCuil > actual.nroCuil)) do begin
			v[j+1] := v[j];
			j -= 1;
		end;
		v[j+1] := actual;
	end;
end;

procedure procesar(var v : arrPlan; var dimL : integer; a : arbol);
var
	nro1Cuil, nro2Cuil : cuil;
	nroPlan : integer;
begin
	dimL := 0;
	writeln('Ingrese nro1 de cuil'); readln(nro1Cuil);
	writeln('Ingrese nro2 de cuil'); readln(nro2Cuil);
	writeln('Ingrese nro de Plan'); readln(nroPlan);
	
	generarVector(a, v, dimL, nro1Cuil, nro2Cuil, nroPlan);
	ordenarVector(v, dimL);
	
end;

//Programa Principal
var
	vectorPlan : arrPlan;
	arbolAfiliados : arbol;
	dimL : integer;
begin
	generarArbol(arbolAfiliados);
	procesar(vectorPlan, dimL, arbolAfiliados);
end.
