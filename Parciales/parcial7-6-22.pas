program parcial;
const
	valor_alto='9999';
type
	
	libreria = record
		rs : string;
		genero : string;
		nombre : string;
		precio : real;
		cantidad : integer;
	end;
	
	archivo = file of libreria;
	
	procedure leer (var arch: archivo; var reg : libreria);
	begin
		if (not eof (arch)) then
			read (arch,reg)
		else
			reg.rs := valor_alto;
	end;
	
	{
		IMPORTANTE
		* Siempre antes de entrar a un while en geeral tengo que poner en 0 alguna cantidad
		* Siempre antes de entrar a un while tengo que darle el valor a una variable auxiliar para chequear el corte de control
		* Siempre antes de entrar al while tengo qeu imprimir a donde estoy entrando, por ejemplo "Genero"
		* Cuando salgo del while, sumo una cantidad e imprimo la informacion de donde sali
		* Hacer el leer en el ultimo while
		* Acordarme de cerrar el archivo
	}
	procedure mostrarInforme (var arch: archivo);
	var
		reg,aux: libreria;
		total_generos, total_libreria, total_librerias : integer;
	begin
		reset (arch);
		leer (arch,reg);
		total_librerias := 0;
		while (reg.rs <> valor_alto) do begin
			total_libreria := 0;
			aux.rs:= reg.rs;
			writeln ('Libreria: ', aux.rs);
			while ( (reg.rs <> valor_alto) and (reg.rs = aux.rs) ) do begin
				aux.genero := reg.genero;
				total_generos :=0;
				writeln ('Genero: ',aux.genero);
				while ( (reg.rs <> valor_alto) and (reg.rs = aux.rs) and (reg.genero = aux.genero)) do begin
					writeln ('Nombre del libro: ', reg.nombre);
					writeln ('Cantidad vendida: ',reg.cantidad);
					total_generos := total_generos + reg.cantidad;
					leer (arch,reg);
				end;
				total_libreria := total_libreria + total_generos;
				writeln ('Total vendido en genero ', aux.genero, ' : ', total_generos);
			end;
			total_librerias := total_librerias + total_libreria;
			writeln ('Total vendido libreria ',aux.rs, ' : ',total_libreria);
			writeln ();
		end;
		writeln ('Total librerias: ',total_librerias);
		close (arch);
	end;
	
	procedure AgregarRegistro(var arch: archivo; registro: libreria);
	begin
	  write(arch, registro);
	end;
	
	procedure crearArchivo (var arch : archivo);
	var
		reg: libreria;
	begin
		//assign(arch, 'libreria.dat');
	  assign(arch, 'libreria2.dat');
	  rewrite(arch); // Crea el archivo

		  // Registro 1
	  reg.rs := '0001';
	  reg.genero := 'Ficción';
	  reg.nombre := 'El Gran Gatsby';
	  reg.precio := 19.99;
	  reg.cantidad := 10;
	  AgregarRegistro(arch, reg);

	  // Registro 2
	  reg.rs := '0001';
	  reg.genero := 'Ficción';
	  reg.nombre := 'El Gran Gatsby';
	  reg.precio := 20.50;
	  reg.cantidad := 5;
	  AgregarRegistro(arch, reg);

	  // Registro 3
	  reg.rs := '0001';
	  reg.genero := 'Ficción';
	  reg.nombre := 'El Gran Gatsby';
	  reg.precio := 20.50;
	  reg.cantidad := 5;
	  AgregarRegistro(arch, reg);

	  // Registro 4
	  reg.rs := '0002';
	  reg.genero := 'Ficción';
	  reg.nombre := '1984';
	  reg.precio := 15.99;
	  reg.cantidad := 5;
	  AgregarRegistro(arch, reg);

	  // Agrega más registros aquí...
	  // Registro 5
	  reg.rs := '0003';
	  reg.genero := 'Aventura';
	  reg.nombre := 'El Hobbit';
	  reg.precio := 25.99;
	  reg.cantidad := 8;
	  AgregarRegistro(arch, reg);

	  // Registro 6
	  reg.rs := '0003';
	  reg.genero := 'Aventura';
	  reg.nombre := 'Las Crónicas de Narnia';
	  reg.precio := 18.50;
	  reg.cantidad := 3;
	  AgregarRegistro(arch, reg);

	  // Registro 7
	  reg.rs := '0003';
	  reg.genero := 'Aventura';
	  reg.nombre := 'Viaje al Centro de la Tierra';
	  reg.precio := 12.99;
	  reg.cantidad := 6;
	  AgregarRegistro(arch, reg);

	  // Registro 8
	  reg.rs := '0004';
	  reg.genero := 'Misterio';
	  reg.nombre := 'El Código Da Vinci';
	  reg.precio := 21.99;
	  reg.cantidad := 7;
	  AgregarRegistro(arch, reg);

	  // Registro 9
	  reg.rs := '0004';
	  reg.genero := 'Misterio';
	  reg.nombre := 'La Chica del Tren';
	  reg.precio := 16.50;
	  reg.cantidad := 4;
	  AgregarRegistro(arch, reg);

	  // Registro 10
	  reg.rs := '0004';
	  reg.genero := 'Misterio';
	  reg.nombre := 'El Silencio de los Corderos';
	  reg.precio := 20.50;
	  reg.cantidad := 6;
	  AgregarRegistro(arch, reg);
	  
	  // Registro 11
	  reg.rs := '0004';
	  reg.genero := 'Aventura';
	  reg.nombre := 'Viaje al Centro de la Tierra';
	  reg.precio := 11.99;
	  reg.cantidad := 15;
	  AgregarRegistro(arch, reg);
	  
	  // Registro 12
	  reg.rs := '0004';
	  reg.genero := 'Aventura';
	  reg.nombre := 'Viaje al Centro de la Tierra';
	  reg.precio := 12.99;
	  reg.cantidad := 6;
	  AgregarRegistro(arch, reg);
	end;
	
	var
		arch: archivo;
	begin
	  crearArchivo (arch);
	  mostrarInforme (arch);
	end.
	
