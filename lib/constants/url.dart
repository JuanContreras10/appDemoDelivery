Map<String, String> clientes = {
  "ActualizarCliente":
      "https://power-ups.online/PHP/cliente/actualizar_cliente.php",
  "ActualizarContra":
      "https://power-ups.online/PHP/cliente/actualizar_contrasenia_cliente.php",
  "BuscarCliente": "https://power-ups.online/PHP/cliente/buscar_cliente.php",
  "BuscarClientes": "https://power-ups.online/PHP/cliente/buscar_clientes.php",
  "CrearCliente": "https://power-ups.online/PHP/cliente/crear_cliente.php",
  "EliminarCliente":
      "https://power-ups.online/PHP/cliente/eliminar_cliente.php",
  "LoginCliente": "https://power-ups.online/PHP/cliente/login_cliente.php"
};

Map<String, String> administrador = {
  "ActualizarAdmin":
      "https://power-ups.online/PHP/administrador/actualizar_admin.php",
  "ActualizarContra":
      "https://power-ups.online/PHP/administrador/actualizar_contrasenia.php",
  "CrearAdmin": "https://power-ups.online/PHP/administrador/crear_admin.php",
  "EliminarAdmin":
      "https://power-ups.online/PHP/administrador/eliminar_admin.php",
  "LoginAdmin": "https://power-ups.online/PHP/administrador/login_admin.php"
};

Map<String, String> imagenesProductos = {
  "AgregarRelacionImagenProducto":
      "https://power-ups.online/PHP/imagenes_productos/agregar_relacion_imagen_producto.php",
  "BuscarImagenes":
      "https://power-ups.online/PHP/imagenes_productos/buscar_imagenes_producto.php",
  "SubirImagen":
      "https://power-ups.online/PHP/imagenes_productos/subir_imagen_producto.php"
};

Map<String, String> productos = {
  "ActualizarImagenProdocto":
      "https://power-ups.online/PHP/producto/actualizar_imagen.php",
  "ActualizarProdocto":
      "https://power-ups.online/PHP/producto/actualizar_producto.php",
  "AgregarProducto":
      "https://power-ups.online/PHP/producto/agregar_producto.php",
  "BuscarProductoId":
      "https://power-ups.online/PHP/producto/buscar_producto_id.php",
  "BuscarProductos":
      "https://power-ups.online/PHP/producto/buscar_productos.php",
  "BuscarProductosNombre":
      "https://power-ups.online/PHP/producto/buscar_productos_nombre.php",
  "ListaCategoriaProducto":
      "https://power-ups.online/PHP/producto/busqueda_lista_categoria.php",
  "BuscarProductosDesc":
      "https://power-ups.online/PHP/producto/buscar_productos_descuentos.php", //mandas {"password":"+Tiend@*"}
  "BuscarProductosNov":
      "https://power-ups.online/PHP/producto/buscar_producto_novedades.php", //mandas {"password":"+Tiend@*"}
  "BusquedaProductosCategoria":
      "https://power-ups.online/PHP/producto/busqueda_productos_categoria.php",
  "ElimarProducto":
      "https://power-ups.online/PHP/producto/eliminar_producto.php",
  "MostrarImagenProducto":
      "https://power-ups.online/PHP/producto/mostrar_imagen.php"
};

Map<String, String> clienteProducto = {
  "ActualizarRelacion":
      "https://power-ups.online/PHP/relacion_cliente_producto/actualizar_relacion.php",
  "BuscarRelacionCliente":
      "https://power-ups.online/PHP/relacion_cliente_producto/buscar_relacion_cliente.php",
  "BuscarRelacionProducto":
      "https://power-ups.online/PHP/relacion_cliente_producto/buscar_relacion_producto.php",
  "BuscarRelaciones":
      "https://power-ups.online/PHP/relacion_cliente_producto/buscar_relaciones.php",
  "CrearRelacion":
      "https://power-ups.online/PHP/relacion_cliente_producto/crear_relacion.php",
  "EliminarRelacion":
      "https://power-ups.online/PHP/relacion_cliente_producto/eliminar_relacion.php"
};

Map<String, String> solicitudCompra = {
  "ActualizarSolicitud":
      "https://power-ups.online/PHP/solicitud_compra/actualizar_solicitud_compra.php",
  "AgregarSolicitud":
      "https://power-ups.online/PHP/solicitud_compra/agregar_solicitud_compra.php",
  "buscarSolicitudes":
      "https://power-ups.online/PHP/solicitud_compra/buscar_solicitudes_compra.php",
  "EliminarSolicitud":
      "https://power-ups.online/PHP/solicitud_compra/eliminar_solicitud_compra.php"
};

Map<String, String> relacionComentarios = {
  "AgregarCometarioProducto":
      "https://power-ups.online//PHP/relacion_comentarios_clientes/agregar_comentarios.php", //mandas {"password":"+Tiend@*","id_producto":"","id_cliente":"","comentario":""}
  "BuscarComentarioProductoFecha":
      "https://power-ups.online//PHP/relacion_comentarios_clientes/buscar_comentario_fecha.php", //mandas {"password":"+Tiend@*"}
  "EliminarComentarioProducto":
      "https://power-ups.online//PHP/relacion_comentarios_clientes/eliminar_comentario.php" //mandas {"password":"+Tiend@*","id_comentario":""}
};

Map<String, String> correos = {
  "CorreoActualizarContrasenia":
      "https://power-ups.online//PHP/correos/recuperar_contrasenia_cliente.php" //mandas {"password":"+Tiend@*","id_cliente":"2"}
};

Map<String, String> relacionProductoTalla = {
  "AgregarRelacionTalla":
      "https://power-ups.online//PHP/relacion_producto_tallas/agregar_relacion_tallas.php", //mandas {"password":"+Tiend@*","id_producto":"","talla":"","stock":""}
  "ActualizarRelacionTalla":
      "https://power-ups.online//PHP/relacion_producto_tallas/actualizar_relacion_tallas.php", //mandas {"password":"+Tiend@*",id_talla:"",id_producto":"","talla":"","stock":""}
  "EliminarRelacionTalla":
      "https://power-ups.online//PHP/relacion_producto_tallas/eliminar_relacion_tallas.php" //mandas {"password":"+Tiend@*","id_talla":""}
};
