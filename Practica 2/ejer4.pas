program ejer4;
Uses sysutils;
const 
	valor_alto=9999;
	dimF = 5;
type 
	datos = record
		cod: integer;
		fecha: string[10];
		sesiones: integer;
	end;
	
	det_datos = record
		cod: integer;
		fecha: string[10];
		sesiones: integer
	end;
	
	detalle = file of det_datos;
	maestro = file of datos;
	vectorDetalles = array[1 .. dimF] of detalle;
	vectorDatos = array[1 .. dimF] of det_Datos;

	

procedure asignarDetalles (var det : vectorDetalles);
var
	i : integer;
begin
	for i:=1 to dimF do 
		assign(det[i], 'detalle' + IntToStr(i));
end;

procedure resetTodos(var v: vectorDetalles);
var
	i: integer;
begin
		for i:= 1 to dimF do
			reset(v[i]);
end;
	
procedure closeTodos(var v: vectorDetalles);
var
	i: integer;
begin
		for i:= 1 to dimF do
			close(v[i]);
end;
	
procedure leer (var archivo:detalle; var dato:det_datos);
begin
	if (not eof(archivo)) then
		read (archivo,dato)
	else
		dato.cod:= valor_alto;
end;

procedure minimo (var vDet : vectorDetalles;var  vDat: vectorDatos; var regd : det_datos);
var
	i, pos : integer;
begin
		regd.cod:= valor_alto;
		for i:= 1 to dimF do begin
			if (vDet[i].cod < regd.cod) then begin
				regd:= vDat[i];
				pos:= i;
			end;
		end;
		if(regd.cod <> valor_alto) then 
			leer(vDet[pos], vDat[pos]);
end;


procedure actualizar (var mae1: maestro; var det1: detalle);
var
	usuario: datos;
	regd: det_datos;
	vDet: vectorDetalles;
	vDat: vectorDatos;
	i :integer;
begin
	rewrite (mae1);
	resetTodos (vDet);
	for i:=1 to dimF do 
		leer(vDet[i], vDat[i]);
	minimo (vDet,vDat,regd);
	while(regd.cod <> valor_alto) do begin
		usuario.sesiones := 0; usuario.cod := regd.cod; usuario.fecha:= regd.fecha;
		while(regd.cod = usuario.cod) do begin
			usuario.sesiones := usuario.sesiones + regd.sesiones;
			minimo (vDet,vDat,regd);
		end;
		write(mae1, usuario);
	end;
	closeTodos (vDet);
	close (mae1);
end;

var
	mae1: maestro;
	det1: detalle;
	vDet: vectorDetalles;
{programa principal}
begin
assign (mae1, 'maestro');
asignarDetalles (vDet);
actualizar (mae1,det1);
end.
