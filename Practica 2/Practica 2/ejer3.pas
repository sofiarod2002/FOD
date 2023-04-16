program ejer3;
Uses sysutils;
const 
	valor_alto=9999;
	dimF = 30;
type 
	producto = record
		cod: integer;
		descripcion: string[30];
		nombre: string[30];
		precio: real;
		stock_min: integer;
		stock_dis: integer
	end;
	
	det_producto = record
		cod: integer;
		cant: integer;
	end;
	
	detalle = file of det_producto;
	maestro = file of producto;
	vectorDetalles = array[1 .. dimF] of detalle;
	vectorProductos = array[1 .. dimF] of det_producto;

	

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
	
procedure leer (var archivo:detalle; var dato:det_producto);
begin
	if (not eof(archivo)) then
		read (archivo,dato)
	else
		dato.cod:= valor_alto;
end;

procedure minimo (vDet : vectorDetalles; vProd: vectorProductos; min : det_producto);
var
	i, pos : integer;
begin
		min.cod:= valor_alto;
		for i:= 1 to dimF do begin
			if (vProd[i].cod < min.cod) then begin
				min:= vProd[i];
				pos:= i;
			end;
		end;
		if(min.cod <> valor_alto) then 
			leer(vDet[pos], vProd[pos]);

end;


procedure actualizarProducto (var mae1: maestro; var det1: detalle);
var
	regm: producto;
	regd: det_producto;
	vDet: vectorDetalles;
	vProd: vectorProductos;
	i :integer;
begin
	reset (mae1);
	resetTodos (vDet);
	read(mae1,regm);
	
	for i:=1 to dimF do 
		leer(vDet[i], vProd[i]);
	minimo (vDet,vProd,regd);
	read (mae1, regm);
	while(regd.cod <> valor_alto) do begin
		{ busco el producto en el maestro }
		while(regd.cod <> regm.cod) do
			read(mae1, regm);
		while(regd.cod = regm.cod) do begin
			regm.stock_dis:= regm.stock_dis - regd.cant;
			minimo (vDet,vProd, regd);
		end;
		seek(mae1, filepos(mae1)-1);
		write(mae1, regm);
	end;
	closeTodos (vDet);
	close (mae1);
end;

procedure exportarProductos (var productos: maestro);
var
	p: producto;
	txt: text;
begin
	reset (productos);
	assign (txt, 'productos.txt');
	rewrite (txt);
	while not (eof (productos)) do begin
		read (productos,p);
		with p do begin
			writeln(txt, 'Nombre: ',nombre,' descripcion: ',descripcion,' stock: ',stock_dis);
		if (p.stock_dis < p.stock_min) then begin 
			writeln(txt, 'Precio: ',precio);
			end;
		end;
	end;
		close (productos);
		close (txt);
end;

var

	mae1: maestro;
	det1: detalle;
	vDet: vectorDetalles;
{programa principal}
begin
assign (mae1, 'maestro');
asignarDetalles (vDet);
actualizarProducto (mae1,det1);
exportarProductos(mae1);
end.
