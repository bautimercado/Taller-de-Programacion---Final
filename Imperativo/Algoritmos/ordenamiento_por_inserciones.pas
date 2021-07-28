//la dimL a veces no es necesaria
//ejemplo de un vector de enteros
procedure ordenarVector (var v : vector; dimL : integer);
var
	i, j, nroActual : integer;
begin
	for i:= 2 to dimL do begin
		j := i-1;
		nroActual := v[i];
		//mientras j sea mayor a 0 y el nroActual sea menor al anterior
		while ((j > 0) and (v[j] > nroActual)) do begin
			v[j+1] := v[j];
			j -= 1;
		end;
		v[j+1] := nroActual;
	end;
end;

//si el vector esta ordenado de manera ascendente --> O(n)
//si el vector esta ordenado de manera descendente --> O(n^2)
