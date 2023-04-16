program ejer9;
const
	valor_alto = '9999';
type
	provincia = record
		cod_provincia: string;
		cod_localidad: string;
		nro: integer;
		cant: integer;
	end;
	
	provincias = file of provincia;
	
procedure leer (var archivo: provincias ; var dato:provincia);
begin
	if (not eof(archivo)) then
		read (archivo,dato)
	else
		dato.cod_provincia:= valor_alto;
end;

var
	archivo: provincias;
	reg: provincia;
	totprov,totloc,totgen:  integer;
	prov, localidad: string;
{programa principal}
begin
	assign (archivo, 'archivo_provincias');
	reset (archivo);
	leer(archivo, reg);
	totgen:= 0;
	localidad := '';
	while (reg.cod_provincia <> valor_alto) do begin
		writeln('Codigo provincia: ', reg.cod_provincia);
		prov := reg.cod_provincia;
		totprov := 0;
		while (reg.cod_provincia <> valor_alto) and (prov = reg.cod_provincia)do begin
			writeln('Codigo Localidad: ', reg.cod_localidad);
			localidad:= reg.cod_localidad;
			totloc := 0;
			while (reg.cod_provincia <> valor_alto) and (prov= reg.cod_provincia) and (localidad = reg.cod_localidad)do begin
				totloc := totloc + reg.cant;
				leer(archivo, reg);
			end;
			write('Total de votos de la localidad : ', totloc);
			totprov := totprov + totloc;
		end;
		writeln('Total de votos provincia: ', totprov);
		totgen := totgen + totprov;
	end;
	writeln('Total general de votos: ', totgen);
	close (archivo);
end.
