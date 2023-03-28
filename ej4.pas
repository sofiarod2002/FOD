program ejer3;
type
	empleado = record
		nro: string[8];
		edad: integer;
		dni: string[8];
		apellido: string[30];
		nombre: string[30];
	end;
	archivo_empleado = file of empleado;

var
	empleados: archivo_empleado;
	nombre_fisico: string[12];
{----------------------------------------------------------------------------A
Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.}

procedure lectura (var empleados : archivo_empleado);
var
	emp :empleado;
begin
	{apertura del archivo para creación}
	 rewrite(empleados);
	{lectura del DNI una persona}
	 write('Ingrese el apellido de la empleado: ');
	 readln(emp.apellido);
	while (emp.apellido <> 'fin') do begin
		{lectura del resto de los datos de la persona}
		write('Ingrese el  nombre de la empleado: ');
		readln(emp.nombre);
		write('Ingrese el numero de empleado: ');
		readln(emp.nro);
		write('Ingrese la edad empleado: ');
		readln(emp.edad);
		write('Ingrese el dni del empleado: ');
		readln(emp.dni);
		{escritura del registro de la persona en el archivo}
		write(empleados, emp);
		{lectura del DNI de una nueva persona}
		write('Ingrese el apellido de la empleado: ');
		readln(emp.apellido);
	end;
	{cierre del archivo}
	 close(empleados);
end;

{----------------------------------------------------------------------------B
Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse
}

procedure imprimir (e : empleado);
begin
	writeln ('Nombre: ', e.nombre);
	writeln ('Apellido: ', e.apellido);
	writeln ('Edad: ',e.edad);
	writeln ('Dni: ', e.dni);
	writeln ('Numero de empleado: ', e.nro);
end;

procedure listarPorNombre (var empleados : archivo_empleado);
var
	buscar : string[30];
	e : empleado;
begin
	reset (empleados);
	writeln ('Ingrese el nombre o apellido que busca');
	readln (buscar);
	while not eof(empleados) do begin
		read (empleados, e);
		if ((e.apellido = buscar) or (e.nombre = buscar)) then 
			imprimir (e);
	end;
	close (empleados);
	
end;

procedure listarTodos (var empleados : archivo_empleado);
var
	e : empleado;
begin
	reset (empleados);
	writeln ('Todos los empleados: ');
	while not eof(empleados) do begin
		read (empleados, e);
		imprimir (e);
	end;
	close (empleados);
end;

procedure listarMayores (var empleados : archivo_empleado);
var
	e : empleado;
begin
	reset (empleados);
	writeln ('Empleados mayores de 70 años: ');
	while not eof(empleados) do begin
		read (empleados, e);
		if (e.edad > 70) then
			imprimir (e);
	end;
	close (empleados);
end;
//--------------------------------------------------4
procedure imprimir2 (var empleados: archivo_empleado);
var
	e: empleado;
begin
	reset (empleados);
	while not eof (empleados) do begin
		read (empleados,e);
		writeln ('Nombre: ', e.nombre);
		writeln ('Apellido: ', e.apellido);
		writeln ('Edad: ',e.edad);
		writeln('Dni: ', e.dni);
		writeln ('Numero de empleado: ', e.nro);
	end;
	close (empleados);
end;

procedure leer (var emp: empleado);
begin
		{lectura del resto de los datos de la persona}
		write('Ingrese el  nombre de la empleado: ');
		readln(emp.nombre);
		write('Ingrese el numero de empleado: ');
		readln(emp.nro);
		write('Ingrese la edad empleado: ');
		readln(emp.edad);
		write('Ingrese el dni del empleado: ');
		readln(emp.dni);
		{escritura del registro de la persona en el archivo}
		write(empleados, emp);
		{lectura del DNI de una nueva persona}
		write('Ingrese el apellido de la empleado: ');
		readln(emp.apellido);
end;

procedure agregarEmpleados (var empleados: archivo_empleado);
var
emp,e : empleado;
esta: boolean;
num : integer;
begin
	esta := false;
	writeln ('---------------------------------------------------------');
	writeln ('Aprete 1 si quire agregar un empleado y 0 si no quiere');
	readln (num);
	
	while (num = 1) do begin
		reset (empleados);
		seek (empleados, filesize(empleados));
		leer (emp);
		while not eof (empleados) do begin
			read (empleados,e);
			writeln  ('numero leido: ',emp.nro);
			writeln ('en el archivo: ',e.nro);
			if (e.nro = emp.nro) then begin
				writeln ('entre');
				esta := true;
				end;
		end;
		if (esta = false) then begin
			seek (empleados, filesize(empleados));
			write (empleados, emp);
		end;
		close (empleados);
		writeln ('Aprete 1 si quire agregar un empleado y 0 si no quiere');
		readln (num);
		end;
		
end;

Procedure actualizarEdad(var empleados: archivo_empleado);
var  
e : empleado;
ok,nueva_edad: integer;
	begin
	reset(empleados);
	while not eof (empleados)do begin
	read( empleados, e);
	imprimir (e);
	writeln ('¿Desea modificar la edad? 1 = si | 2 = no');
	readln (ok);
	if (ok =1) then begin
		writeln ('Ingrese la edad: ');
		readln (nueva_edad);
		e.edad := nueva_edad;
		seek(empleados, filePos(empleados)-1);
		write(empleados, e)
		end;
	end;
	close(empleados);
end;

procedure exportarEmpleados (var empleados: archivo_empleado);
var
	e: empleado;
	txt: text;
begin
	reset (empleados);
	assign (txt, 'Todos_los_empleados.txt');
	rewrite (txt);
	while not (eof (empleados)) do begin
		read (empleados, e);
		with e do
			writeln (txt,'|NRO: ',nro:10,'|EDAD: ',edad:10,'|DNI: ',dni:10,'|APELLIDO: ',apellido:10,'|NOMBRE: ',nombre:10); 
		end;
		close (empleados);
		close (txt);
		
end;

{Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
que no tengan cargado el DNI (DNI en 00).}
procedure exportarSinDni (var empleados: archivo_empleado);
var
	e: empleado;
	txt: text;
begin
	reset (empleados);
	assign (txt, 'Todos_los_empleados_sin_dni.txt');
	rewrite (txt);
	while not (eof (empleados)) do begin
		read (empleados, e);
		if (e.dni = '00') then begin 
			with e do
				writeln (txt,'|NRO: ',nro:10,'|EDAD: ',edad:10,'|DNI: ',dni:10,'|APELLIDO: ',apellido:10,'|NOMBRE: ',nombre:10); 
		end;
	end;
		close (empleados);
		close (txt);
end;


begin
write('Ingrese el nombre del archivo: ');
readln(nombre_fisico);
{enlace entre el nombre lógico y el nombre
 físico}
assign(empleados, nombre_fisico);
lectura (empleados);
//listarPorNombre (empleados);
//listarTodos (empleados);
//listarMayores (empleados);
//-------4
agregarEmpleados (empleados);
imprimir2 (empleados);
end.
