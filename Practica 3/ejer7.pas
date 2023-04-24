program ejer7;
type
	ave = record
		cod: integer;
		especie: string;
		familia: string;
		descripcion: string;
		zona: string;
	end;
	
	aves= file of ave;
	
	procedure eliminarAve (var archivo: aves; e : string);
	var
		a : ave;
	begin
		reset(archivo);
		while (not eof (archivo)) do begin
			read (archivo,a);
			if (a.especie = e) then
				a.cod := a.cod*-1;
			end;
		close (archivo);
	end;
	
	procedure eliminarAves (var archivo : aves);
	var
		e: string;
		cod: integer;
	begin
		readln (e);
		readln (cod);
		while (cod <> 5000) do begin
			eliminarAve (archivo,e);
			readln (e);
			readln (cod);
		end;
		close (archivo);
	end;
	
	procedure compactar (var archivo:aves);
	var
		a,av: ave;
		cant,pos: integer;
	begin
		reset (archivo);
		cant :=0;
		while (not eof (archivo)) do begin
			read (archivo,av);
			if (av.cod <0) then begin
				pos:= filepos(archivo)-1; //me guardo la pos actual
				seek (archivo, filesize (archivo) - cant); 
				read (archivo,a);
				seek (archivo, pos);
				write (archivo,a);
				cant:= cant +1; // voy sumando los registros que movi
				end;
		end;
		seek (archivo, filesize (archivo) - cant); 
		truncate(archivo);
	
	end;
	
		var
	a : aves;
	opcion: integer;
begin
	assign (a, 'aves');
	writeln ('0: finalizar | 1: Eliminar aves| 2: Compactar archivo');
	readln (opcion);
	while (opcion <> 0) do begin
		case opcion of
		1: eliminarAves(a);
		2: compactar(a);
		end;
		writeln ('0: finalizar | 1: Eliminar prendas| 2: Compactar archivo');
		readln (opcion);
	end;
end.

