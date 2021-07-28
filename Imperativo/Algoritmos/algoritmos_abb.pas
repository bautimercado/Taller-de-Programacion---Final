program ejemploArbol;
//arbol de enteros
type
	arbolEnteros = ^nodo;
	nodo = record
		dato : integer;
		hi : arbolEnteros; 		//hijo izquierdo
		hd : arbolEnteros; 		// hijo derecho
	end;
	
//algoritmo recursivo, el caso base es si el puntero es nil (en ese caso hay que agregar el elemento)
//si no es nil, hay que comparar el nro con el dato al que apunta el puntero para saber con que hijo llamar recursivamente
procedure agregarElemento (var arbol : arbolEnteros; nro : integer);
begin
	if (arbol = nil) then begin
		new(arbol);
		arbol^.dato := nro;
		arbol^.hi := nil;
		arbol^.hd := nil;
	end
	else
		if (arbol^.dato > nro) then
			agregarElemento(arbol^.hd, nro)
		else
			if (arbol^.dato < nro) then
				agregarElemento(arbol^.hi, nro);       //para no tener elementos repetidos
end;


procedure preOrden(arbol : arbolEnteros);
begin
	if (arbol <> nil) then begin
		print(arbol^.dato);
		preOrden(arbol^.hi);
		preOrden(arbol^.hd);
	end;
end;	

procedure postOrden(arbol : arbolEnteros);
begin
	if (arbol <> nil) then begin
		postOrden(arbol^.hi);
		postOrden(arbol^.hd);
		print(arbol^.dato);
	end;
end;

procedure enOrden(arbol : arbolEnteros);
begin
	if (arbol <> nil) then begin
		enOrden(arbol^.hi);
		print(arbol^.dato);
		enOrden(arbol^.hd);
	end;
end;

//el caso baso es que el arbol sea nil, en ese caso no se encontró el elemento, retorno nil
//si lo encuentro, retorno el puntero a ese nodo del arbol donde lo encontré.
//sino, comparo el parametro formal con el elemento del nodo y segun el resultado, llamo recursivamente con alguno de los hijos
function buscar (arbol : arbolEnteros; nro : integer):arbol;
begin
	if (arbol = nil) then
		buscar := nil
	else
		if (arbol^.dato = nro) then
			buscar := arbol
		else
			if (arbol^.dato < nro) then
				buscar := buscar(arbol^.hd, nro)
			else
				buscar := buscar(arbol^.hi, nro);
end;

//O(log 2 n)


