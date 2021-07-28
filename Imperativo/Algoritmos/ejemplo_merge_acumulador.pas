//ejemplo con 12 listas
//cada lista esta conformada por nomProv, cantCasos, mes, y ordenadas por nomProv y agrupadas por mes
program ejemploMergeAcumulador;

const
	valorAlto = 'zzz';
	cantMeses = 12;

type
	rangoMeses = 1..cantMeses;
	str20 = String[20];
	
	tProvincia = record
		nomProv : str20;
		cantCasos : integer;
		mes : rangoMeses;
	end;
	
	listaProvincias = ^nodo;
	nodo = record;
		dato : tProvincia;
		sig : listaProvincias;
	end;
	
	arrListasPorMes = array [rangoMeses] of tProvincia;
	
	tCasosProv = record
		nomProv : str20;
		cantCasos : integer;
	end;
	
	listaCasosPorProvincia = ^nodoNuevo;
	nodoNuevo = record
		dato : tCasosProv;
		sig : listaCasosPorProvincia;
	end;
	
procedure iniciarListas (var v : arrListasPorMes);
var
	i : integer;
begin
	for i := 1 to cantMeses do
		v[i] := nil;
end;

//. .. . . . . . . . . . . 
	
procedure minimo(var v : arrListasPorMes; var min : tProvincia);
var
	i, iMin : integer;
begin
	iMin := -1; min.nomProv := valorAlto;
	
	for i := 1 to cantMeses do begin
		if ((v[i] <> nil) and (min.nomProv > v[i].nomProv)) then begin
			min := v[i]; iMin := i;
		end;
	end;
	
	if (iMin <> -1) then
		v[iMin] := v[iMin]^.sig;
end;


procedure agregarAtras(var l, ult : listaCasosPorProvincia; elemento : tCasosProv);
var
	nodo : listaCasosPorProvincia;
begin
	new(nodo);
	nodo^.dato := elemento;
	nodo^.sig := nil;
	if (l = nil) then
		l := nodo
	else
		ult^.sig := nodo;
	ult := nodo;
end;



procedure mergeAcumulador(var nuevaLista : listaCasosPorProvincia; listas : arrListasPorMes);
var
	ult : listaCasosPorProvincia;
	act : tCasosProv;
	min : tProvincia;
begin
	nuevaLista := nil; ult := nil;
	minimo(listas, min);
	
	while (min.nomProv <> valorAlto) do begin
		act.nomProv := min.nomProv; act.cantCasos := 0;
		
		while ((min.nomProv <> valorAlto) and (act.nomProv = min.nomProv)) do begin
			act.cantCasos += min.cantCasos;
			minimo(listas, min);
		end;
		
		agregarAtras(nuevaLista, ult, act);
	end;
end;













	
	
