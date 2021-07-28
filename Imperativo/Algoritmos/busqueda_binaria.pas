//solo se hace con vectores ORDENADOS
//ejemplo con vector de enteros
function busquedaBinaria (var v : vector; dimL, nroBuscar : integer):integer;
var
	izq, der, mid, pos : integer;
begin
	izq := 1; der := dimL; pos := -1;
	mid := (izq + der) div 2;
	
	while ((izq <= der) and (pos = -1)) do begin
		if (v[mid] = nroBuscar) then
			pos := mid
		else begin
			if (v[mid] < nroBuscar) then
				der := mid-1
			else
				izq := mid+1;
			mid := (izq + der) div 2;
		end;
	end;
	
	busquedaBinaria := pos;
end;
