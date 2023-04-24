program ejer6;
const
	valor_alto = 9999;
type
	
	prenda = record
		cod: integer;
		descripcion: string;
		colores: string;
		tipo: string;
		stock: integer;
		precio_unitario: real;
	end;
	
	archivo_prendas = file of prenda;
	archivo_stock = file of integer;
	
	procedure eliminarPrendas (var aP : archivo_prendas; var aC : archivo_stock);
	var
		p : prenda;
		c: integer;
	begin
		reset(aP);
		reset(aC);
		while (not eof (aC)) do begin
			read (aP, p);
			read (aC,c);
			if (p.cod = c) then begin
				p.stock:= p.stock*-1;
				seek(aP, filepos(aP)-1);
				write (aP,p);
			end;
		close (aP);
		close (aC);
	end;
	end;
	
	procedure compactarArchivo (var AP: archivo_prendas);
	var
		aux: archivo_prendas;
		p: prenda;
	begin
		reset (aP);
		rewrite(aux);
		while (not eof (aP)) do begin
			read (aP,p);
			if (p.stock > 0)then
				write (aux,p);
		end;
		close (aP);
		close (aux);
	end;
	
	var
	aP : archivo_prendas;
	aC: archivo_stock;
	opcion: integer;
begin
	assign (aP, 'prendas');
	assign (aC, 'stock');
	writeln ('0: finalizar | 1: Eliminar prendas| 2: Compactar archivo');
	readln (opcion);
	while (opcion <> 0) do begin
		case opcion of
		1: eliminarPrendas(aP,aC);
		2: compactarArchivo(aP);
		end;
		writeln ('0: finalizar | 1: Eliminar prendas| 2: Compactar archivo');
		readln (opcion);
	end;
end.
