//ejemplo de merge con 10 listas
//las listas han de estar ordenadas por el mismo criterio

procedure ejemploMerge;
const
	valorAlto = 'zzz';
	
type
	listaNombres = ^nodo;
	nodo = record
		dato : String;
		sig : listaNombres;
	end;
	
	arrListas = array[1..10] of listaNombres;
	
//. . . . . . . . . 
procedure iniciarListas (var v : arrListas);
var
	i : integer;
begin
	for i:= 1 to 10 do
		v[i] := nil;
end;

//obtener el minimo de cada estructura y que la estructura de donde lo obtuve apunte al siguiente elemento.
procedure minimo(var v : arrListas; var min : String);
var
	i, iMin : integer;
begin
	iMin := -1; min := valorAlto;
	for i := 1 to 10 do begin
		if ((v[i] <> nil) and (v[i]^.dato < min)) then begin
			iMin := i; min := v[i]^.dato;
		end;
 	end;
 	if (iMin <> -1) then
		v[iMin] := v[iMin]^.sig;
end;

//como los elementos que se van obteniendo estan ordenados, se usa un agregar atras.
procedure agregarAtras(var l, ult : listaNombres; unNombre : String);
var
	nodo : listaNombres;
begin
	new(nodo); nodo^.dato := unNombre; nodo^.sig := nil;
	if (l = nil) then
		l := nodo
	else
		ult^.sig := nodo;
	ult := nodo;
end;

//se va iterando obteniendo el minimo y agregando los elementos a la nueva lista hasta que no queden mas elementos para incluir
procedure merge(var nuevaLista : listaNombres; listas : arrListas);
var
	min : String;
	ult : listaNombres;
begin
	nuevaLista := nil; ult := nil;
	minimo(listas, min);
	while (min <> valorAlto) do begin
		agregarAtras(nuevaLista, ult, min);
		minimo(listas, min);
	end;
end;





