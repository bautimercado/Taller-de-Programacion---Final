program dos;
const
	cantOficinas = 300;
	corte = -1;
type
	str8 = String[8];
	rangoOficinas = 1..cantOficinas;
	
	tOficina = record
		dni : str8;
		codId : integer;
		expensa : real;
	end;
	
	arrOficinas = array[rangoOficinas] of tOficina;

procedure leerOficina(var unaOficina : tOficina);
begin
	with unaOficina do begin
		writeln('Ingrese codigo de identificacion'); readln(codId);
		if (codId <> corte) then begin
			writeln('Ingrese DNI'); readln(dni);
			writeln('Ingrese el monto de la expensa'); readln(expensa);
		end;
	end;
end;


procedure generarVector(var v : arrOficinas; var dimL : integer);
var
	unaOficina : tOficina;
begin
	dimL := 0; leerOficina(unaOficina);
	while ((dimL+1 <= cantOficinas) and (unaOficina.codId <> corte)) do begin
		dimL += 1;
		v[dimL] := unaOficina;
		leerOficina(unaOficina);
	end;
end;

procedure ordenarVector(var v : arrOficinas; dimL : integer);
var
	i, j : integer;
	oficinaActual : tOficina;
begin
	for i := 2 to dimL do begin
		j := i-1;
		oficinaActual := v[i];
		while ((j > 0) and (v[j].codId > oficinaActual.codId)) do begin
			v[j+1] := v[j];
			j -= 1;
		end;
		v[j+1] := oficinaActual;
	end;
end;

function busquedaBinaria (v : arrOficinas; dimL, codId : integer): integer;
var
	izq, mid, pos : integer;
begin
	izq := 1; pos := -1; mid := (izq + dimL) div 2;
	while ((izq <= dimL) and (pos = -1)) do begin
		if (v[mid].codId = codId) then
			pos := mid
		else begin
			if (v[mid].codId < codId) then
				dimL := mid -1
			else
				izq := mid + 1;
			mid := (izq + dimL) div 2;
		end;
	end;
	busquedaBinaria := pos;
end;

//Programa Principal
var
	vectorOficinas : arrOficinas;
	dimL, pos, codId : integer;
begin
	generarVector(vectorOficinas, dimL);
	ordenarVector(vectorOficinas, dimL);
	writeln('Ingrese un codigo de identificacion'); readln(codId);
	pos := busquedaBinaria(vectorOficinas, dimL, codId);
	if (pos = -1) then
		writeln('No se encontro al codigo de identificacion', codId,' :(')
	else
		writeln(vectorOficinas[pos].dni);
end.
