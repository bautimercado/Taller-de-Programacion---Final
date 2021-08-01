procedure insertarOrdenado(var l : listaAutos; unAuto : tAuto);
var
	nodo, act, ant : listaAutos;
begin
	new(nodo); nodo^.dato := unAuto;
	act := l;
	while ((act <> nil) and (act^.dato.nroMotor < unAuto.nroMotor)) do begin
		ant := act;
		act := act^.sig;
	end;
	if (l = act) then
		l := nodo
	else
		ant^.sig := nodo;
	nodo^.sig := act
end;
