class UsuarioCliente {
  var nombre;
  var correo;
  var direccion;
  var telefono;

  UsuarioCliente(this.nombre, this.correo, this.direccion, this.telefono);
}

class Producto {
  var idProducto;
  var nombre;
  var categoria;
  var modelo;
  var tamanio;
  var imagen;
  var precio;
  var especificacion;
  var stock;
  var descuento;
  var descripcion;
  var nota;
  var caracteristicas;
  var color;
  Producto(
      this.idProducto,
      this.nombre,
      this.categoria,
      this.modelo,
      this.tamanio,
      this.imagen,
      this.precio,
      this.especificacion,
      this.stock,
      this.descuento,
      this.caracteristicas,
      this.descripcion,
      this.nota,
      this.color);
}

class ImagenesCarruselProducto {
  var idImagen;
  var idProducto;
  var imagen;

  ImagenesCarruselProducto(this.idImagen, this.idProducto, this.imagen);
}

class CarritoList {
  var idProducto;
  var talla;
  var color;
  var precio;
  var cantidad;
  var img;
  var nombre;

  CarritoList(this.idProducto, this.talla, this.color, this.precio,
      this.cantidad, this.img, this.nombre);
}

class Comentario {
  var idProducto = "";
  var idCliente = "";
  var comentario = "";
  var fecha = "";

  Comentario(this.idProducto, this.idCliente, this.comentario, this.fecha);
}

class UsuarioClienteComentario {
  var nombre;
  var correo;
  var direccion;
  var telefono;
  var idCliente;

  UsuarioClienteComentario(
      this.idCliente, this.nombre, this.correo, this.direccion, this.telefono);
}
