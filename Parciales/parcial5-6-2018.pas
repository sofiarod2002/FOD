program parcial;

const
	valor_alto = 9999;

type
	
	sitios = record
		anio :integer;
		mes: string;
		dia: integer;
		id: string;
		tiempo : integer;
	end;
	
	archivo = file of sitios;
	
	procedure AgregarRegistro(var arch: archivo; registro: sitios);
	begin
	  write(arch, registro);
	end;
	
	procedure crearArchivo (var arch : archivo);
	var
		reg: sitios;
	begin
	  assign(arch, 'sitios.dat');
	  rewrite(arch); // Crea el archivo

	  // Registro 1
	  reg.anio := 2002;
	  reg.mes := 'Enero';
	  reg.dia := 10;
	  reg.id := 'sofia';
	  reg.tiempo := 30;
	  AgregarRegistro(arch, reg);

	  // Registro 2
	  reg.anio := 2002;
	  reg.mes := 'Enero';
	  reg.dia := 11;
	  reg.id := 'sofia';
	  reg.tiempo := 15;
	  AgregarRegistro(arch, reg);

	  // Registro 3
	  reg.anio := 2002;
	  reg.mes := 'Febrero';
	  reg.dia := 11;
	  reg.id := 'sofia';
	  reg.tiempo := 45;
	  AgregarRegistro(arch, reg);

	  // Registro 4
	  reg.anio := 2002;
	  reg.mes := 'Febrero';
	  reg.dia := 11;
	  reg.id := 'juan';
	  reg.tiempo := 60;
	  AgregarRegistro(arch, reg);

	  // Registro 5
	  reg.anio := 2002;
	  reg.mes := 'Marzo';
	  reg.dia := 11;
	  reg.id := 'juan';
	  reg.tiempo := 10;
	  AgregarRegistro(arch, reg);

	  // Registro 6
	  reg.anio := 2002;
	  reg.mes := 'Marzo';
	  reg.dia := 25;
	  reg.id := 'juan';
	  reg.tiempo := 20;
	  AgregarRegistro(arch, reg);
	close (arch);
	
	end;
		
	procedure leer (var arch:archivo; var reg : sitios);
	begin
		if (not eof(arch)) then
			read(arch,reg)
		else
			reg.anio := valor_alto;
	end;
	
	procedure generarInforme (var arch : archivo);
	var
		aux, reg : sitios;
		anioX,total_anio,total_mes,total_dia : integer;
	begin
		reset(arch);
		leer(arch,reg);
		
		writeln ('Ingrese el año que busca');
		readln (anioX);
		
		while ((reg.anio <> valor_alto) and (reg.anio <> anioX)) do 
			leer (arch,reg);
		
		if (reg.anio = anioX) then begin
			aux.anio := reg.anio;
			total_anio := 0;
			writeln ('Año: ', aux.anio);
			while (aux.anio = reg.anio) do begin
				aux.mes := reg.mes;
				writeln ('Mes ', aux.mes);
				total_mes := 0;
				while ( (aux.anio = reg.anio) and (aux.mes = reg.mes))do begin
					aux.dia := reg.dia;
					writeln ('Dia ',aux.dia);
					aux.tiempo := 0;
					total_dia := 0;
					while ( (aux.anio = reg.anio) and (aux.mes = reg.mes) and (aux.dia = reg.dia))do begin
						writeln ('id Usuario: ',reg.id,' Tiempo total de accesos en el dia: ', reg.dia, ' Mes: ', reg.mes);
						writeln (reg.tiempo);
						writeln();
						total_dia := total_dia + reg.tiempo;
						leer (arch,reg);
					end; // cierro dia
					writeln ('Tiempo total acceso dia: ',aux.dia, ' Mes  ', aux.mes);
					writeln (total_dia);
					total_mes := total_mes + total_dia;
				end; // cierro mes
				writeln ('Total de accesos mes ',aux.mes, ' ', total_mes);
				total_anio := total_anio + total_mes;
				end; // cierro año
				writeln ('Total de accesos año ',aux.anio, ' ', total_anio);
			end else 
			writeln ('No se ha encontrado el año');
	end;
	
	procedure exportarSitio (var arch : archivo; var txt: text);
	var
		reg : sitios;
	begin
		reset (arch);
		assign (txt, 'sitios.txt');
		rewrite (txt);
		while not (eof (arch)) do begin
			read (arch,reg);
				with reg do begin
				writeln(txt, anio,mes,dia,tiempo);
				writeln (txt, id);
				end;
		end;
			close (arch);
			close (txt);
	end;

var
arch : archivo;
txt : text;
begin
	crearArchivo (arch);
	exportarSitio(arch,txt);
	generarInforme (arch);

end.
