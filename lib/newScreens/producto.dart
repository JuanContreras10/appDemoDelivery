import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:tienda/constants/MiListaFav.dart';
import 'package:tienda/constants/MilistaCarrito.dart';
import 'package:tienda/constants/Theme.dart';
import 'package:tienda/constants/clases.dart';
import 'package:tienda/constants/rutas.dart';
import 'package:tienda/constants/url.dart';
import 'package:tienda/screens/home.dart';
//import 'package:tienda/screens/home.dart';
import 'package:tienda/widgets/alerta.dart';
import 'package:tienda/widgets/carga.dart';
import 'package:tienda/widgets/navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:direct_select/direct_select.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
TextEditingController cantidad = new TextEditingController();

List<Uint8List> imgCarrusel = [];
List<Comentario> listaComentarios = [];

//String dropdownValue = 'One';

String dropdownTalla = 'Seleccionar';

String dropdownColor = 'Seleccionar';

class VistaProducto extends StatefulWidget {
  final String infoPro;

  const VistaProducto({this.infoPro, Key key}) : super(key: key);

  @override
  _VistaProductoState createState() => _VistaProductoState();
}

class _VistaProductoState extends State<VistaProducto> {
  Producto infoPro;
  int selectedIndex1 = 0;
  IconData iconStateFav = FontAwesomeIcons.heart;
  TextEditingController pregunta = new TextEditingController();

  var nombreComentario;

  final _formKey = GlobalKey<FormState>();

  final elements1 = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "otra cantidad",
  ];

  List<Widget> _buildItems1() {
    return elements1.map((val) => MySelectionItem(title: val)).toList();
  }

  List<String> listaTalla = ['chica', 'mediana', 'grande', 'unitalla'];

  List<String> listaColor = ['blanco', 'negro', 'gris', 'azul'];

  Future addComentario() async {
    var url = Uri.parse(relacionComentarios['AgregarCometarioProducto']);
    Map<String, String> cuerpo = {
      "password": "+Tiend@*",
      "id_producto": "${widget.infoPro}",
      "id_cliente": "$idCliente",
      "comentario": "${pregunta.text}"
    };
    var body = jsonEncode(cuerpo);
    try {
      final response = await http.post(url, body: body);
      var datauser = json.decode(response.body);
      //print(datauser);
      if (datauser['status'] == true) {
        showToast(context, FontAwesomeIcons.check, Colors.green, "Publicado");
      } else {
        showToast(context, FontAwesomeIcons.bug, Colors.red,
            "Posible error la optencion de datos!");
      }
    } catch (e) {
      // showToast(context, FontAwesomeIcons.bug, Colors.red,
      //   "Posible error conexion con el servidor !");
      print("error op: $e");
    }
  }

  Future<List<Comentario>> getComentario() async {
    var url = Uri.parse(relacionComentarios['BuscarComentarioProductoFecha']);
    Map<String, String> cuerpo = {
      "password": "+Tiend@*",
      "id_producto": "${widget.infoPro}",
    };
    var body = jsonEncode(cuerpo);
    try {
      final response = await http.post(url, body: body);
      var datauser = json.decode(response.body);
      Comentario comentario;
      //print(datauser);
      for (var item in datauser) {
        comentario = Comentario(item['id_producto'], item['id_cliente'],
            item['comentario'], item['fecha']);
        listaComentarios.add(comentario);
      }
      print(listaComentarios.length);
    } catch (e) {
      // showToast(context, FontAwesomeIcons.bug, Colors.red,
      //   "Posible error conexion con el servidor !");
      print("error com: $e");
    }

    return listaComentarios;
  }

  Future<Producto> _obteneProducto() async {
    listaComentarios = [];
    getComentario();
    imgCarrusel = [];

    var url = Uri.parse(productos['BuscarProductoId']);
    Uint8List bytes;
    Map<String, String> cuerpo = {
      "password": "+Tiend@*",
      "id_producto": "${widget.infoPro}"
    };
    var body = jsonEncode(cuerpo);
    try {
      final response = await http.post(url, body: body);
      var datauser = json.decode(response.body);
      //print(datauser);
      if (datauser['status'] == true) {
        infoPro = Producto(
            datauser['id_producto'],
            datauser['nombre'],
            datauser['categoria'],
            datauser['modelo'],
            datauser['tamanio'],
            datauser['imagen'],
            datauser['precio'],
            datauser['especificacion'],
            datauser['stock'],
            datauser['descuento'],
            datauser['descripcion'],
            datauser['caracteristicas'],
            datauser['nota'],
            datauser['color']);
        //dropdownTalla = datauser['tamanio'];
        bytes = base64.decode(datauser['imagen']);
        imgCarrusel.add(bytes);
        _obtenerImagenes();
      } else {
        showToast(context, FontAwesomeIcons.bug, Colors.red,
            "Posible error la optencion de datos!");
      }
    } catch (e) {
      // showToast(context, FontAwesomeIcons.bug, Colors.red,
      //   "Posible error conexion con el servidor !");
      print("error op: $e");
    }

    return infoPro;
  }

  Future _obtenerImagenes() async {
    var url = Uri.parse(imagenesProductos['BuscarImagenes']);
    Uint8List bytes;
    Map<String, String> cuerpo = {
      "password": "+Tiend@*",
      "id_producto": "${widget.infoPro}"
    };
    var body = jsonEncode(cuerpo);
    try {
      final response = await http.post(url, body: body);
      var datauser = json.decode(response.body);
      // print(datauser.lenght);
      for (var item in datauser) {
        bytes = base64.decode(item['imagen']);
        imgCarrusel.add(bytes);
        //print(imgCarrusel);
      }
    } catch (e) {
      // showToast(context, FontAwesomeIcons.bug, Colors.red,
      //     "Posible error conexion con el servidor !");
      print("error imagenc: $e");
    }
  }

  Future _obtenerCliente(String idClienteComentario) async {
    var url = Uri.parse(clientes['BuscarCliente']);

    Map<String, String> cuerpo = {
      "password": "+Tiend@*",
      "id_cliente": "$idClienteComentario"
    };
    var body = jsonEncode(cuerpo);
    try {
      final response = await http.post(url, body: body);
      var datauser = json.decode(response.body);
      // ignore: unused_local_variable
      var nombreComentario;
      // print(datauser);
      if (datauser['status'] == true) {
        setState(() {
          nombreComentario = datauser['nombre'];
        });
      } else {
        showToast(context, FontAwesomeIcons.bug, Colors.red,
            "Posible error en los datos de sesion!");
      }
    } catch (e) {
      showToast(context, FontAwesomeIcons.bug, Colors.red,
          "Posible error conexion con el servidor !");
      print("error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "Alexander Palacio ",
        backButton: true,
        transparent: true,
        animationAppbar: true,
        rightOptions: true,
      ),
      // backgroundColor: Colors.black,

      body: FutureBuilder(
        future: _obteneProducto(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Carga(),
              ),
            );
          } else {
            return SingleChildScrollView(child: _cuerpo(context));
          }
        },
      ),
    );
  }

  Widget carruselImg() {
    return Builder(
      builder: (context) {
        final double height = MediaQuery.of(context).size.height;
        return CarouselSlider(
          options: CarouselOptions(
            height: height,
            viewportFraction: 2.0,
            enlargeCenterPage: false,
            aspectRatio: 2.0,

            // autoPlay: false,
          ),
          items: imgCarrusel
              .map((item) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Center(
                      child: Stack(
                        children: [
                          Image.memory(
                            item,
                            fit: BoxFit.cover,
                            height: height,
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _cuerpo(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,

          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: carruselImg(),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          //width: MediaQuery.of(context).size.width * 0.6,
          //alignment: Alignment.topRight,
          child: Icon(
            Icons.arrow_left,
            color: Colors.white,
          ),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(
                right: 10.0,
                left: 10.0,
                top: MediaQuery.of(context).size.height * 0.50,
              ),
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text("\$ ${infoPro.precio} MXN",
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  //color: MaterialColors.label,
                                ),
                                child: Text("${infoPro.categoria}",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 14))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text("${infoPro.nombre}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 21)),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text("${infoPro.modelo}",
                                    style: TextStyle(
                                        color: MaterialColors.warning,
                                        fontSize: 14)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 8,
                          blurRadius: 10,
                          offset: Offset(0, 0))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13.0),
                      topRight: Radius.circular(13.0),
                    )),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                //alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 12.0),
                  child: _formProducto(),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _formProducto() {
    // String tamanio = infoPro.tamanio;
    final instanciaLista = Provider.of<MilistaCarrito>(context);
    final instanciaListaFav = Provider.of<MilistaFav>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15.0),
                Text("Talla: "),
                SizedBox(width: 15.0),
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.blue[50]),
                  child: DropdownButton(
                    hint: Text(
                      dropdownTalla,
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                    //value: dropdown,
                    //  icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.blue),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownTalla = newValue;
                        print(dropdownTalla);
                      });
                    },
                    items: listaTalla.map<DropdownMenuItem>((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(width: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15.0),
                Text("Color: "),
                SizedBox(width: 15.0),
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.blue[50]),
                  child: DropdownButton(
                    hint: Text(
                      dropdownColor,
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                    //value: dropdown,
                    // icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.blue),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownColor = newValue;
                        print(dropdownColor);
                      });
                    },
                    items: listaColor.map<DropdownMenuItem>((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 15.0),
        Row(
          children: [
            Text(
              "\$ ${infoPro.precio}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
                //color: Colors.black.withOpacity(0.5)),
              ),
            ),
            SizedBox(width: 5.0),
            Text(
              "\$ ${infoPro.precio}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  color: Colors.black.withOpacity(0.5)),
            ),
            SizedBox(width: 5.0),
            Text(
              "Descuento ${infoPro.descuento}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  color: Colors.green.withOpacity(0.9)),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "IVA incluido",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.truck,
              color: Colors.green,
            ),
            SizedBox(width: 15.0),
            Text(
              "Entrega el dia Jueves",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Ver mas formas de entrega",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.share,
              color: Colors.green,
            ),
            SizedBox(width: 15.0),
            Text(
              "Devolución gratis",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Tienes 30 dias desde que lo recibas",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Conocer mas",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        Row(
          children: [
            int.parse(infoPro.stock) > 5
                ? Text(
                    "Stock disponible",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                : Text(
                    "Existentes ${infoPro.stock} existentes",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
          ],
        ),
        SizedBox(height: 15.0),
        Row(
          children: [
            Text(
              "Cantidad",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        DirectSelect(
            mode: DirectSelectMode.tap,
            itemExtent: 50.0,
            selectedIndex: selectedIndex1,
            backgroundColor: Colors.transparent,
            child: MySelectionItem(
              isForList: false,
              title: elements1[selectedIndex1],
            ),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedIndex1 = index;
                cantidad.text = elements1[selectedIndex1];
              });
            },
            items: _buildItems1()),
        SizedBox(height: 15.0),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.blue),
          child: ElevatedButton(
            onPressed: () {},
            child: Container(
              child: Text('Comprar ahora'),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              onPrimary: Colors.white,
              shadowColor: Colors.transparent,
              elevation: 0,
              minimumSize: Size(300.0, 40.0),
            ),
          ),
        ),
        SizedBox(height: 15.0),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.blue[50]),
          child: ElevatedButton(
            onPressed: () {
              cantidad.text == ""
                  ? cantidad.text = "1"
                  : cantidad.text = cantidad.text;

              CarritoList nuevo = new CarritoList(
                  "${infoPro.idProducto}",
                  "$dropdownTalla",
                  "$dropdownColor",
                  "${infoPro.precio}",
                  "${cantidad.text}",
                  "${infoPro.imagen}",
                  "${infoPro.nombre}");
              setState(() {
                instanciaLista.myList.add(nuevo);
                // listCarrito.add(nuevo);
                cantidad.text = "";
              });
              showToast(context, Icons.add_shopping_cart, Colors.blue,
                  "Agregado a tu carrito!");
            },
            child: Container(
              child: Text('Agregar al carrito'),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              onPrimary: Colors.blue,
              shadowColor: Colors.transparent,
              elevation: 0,
              minimumSize: Size(300.0, 40.0),
            ),
          ),
        ),
        SizedBox(height: 15.0),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.transparent),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (iconStateFav == FontAwesomeIcons.solidHeart) {
                        instanciaListaFav.myList.removeWhere((producto) =>
                            producto.idProducto == infoPro.idProducto);
                        showToast(context, Icons.delete, Colors.red[300],
                            "Eliminado de favoritos!");

                        iconStateFav = FontAwesomeIcons.heart;
                      } else {
                        CarritoList nuevo = new CarritoList(
                            "${infoPro.idProducto}",
                            "$dropdownTalla",
                            "${infoPro.color}",
                            "${infoPro.precio}",
                            "${cantidad.text}",
                            "${infoPro.imagen}",
                            "${infoPro.nombre}");
                        instanciaListaFav.myList.add(nuevo);
                        showToast(
                            context, Icons.favorite, Colors.blue, "Favorito!");
                        iconStateFav = FontAwesomeIcons.solidHeart;
                      }
                    });
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          iconStateFav,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 5.0),
                        Text('Favoritos', style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.white,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    minimumSize: Size(300.0, 40.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: 5.0),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.transparent),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.shareAlt,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 5.0),
                        Text('Compartir', style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.blue,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    minimumSize: Size(300.0, 40.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Infomacion del producto",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        ListTile(
            title: Text(
              "Especificaciones",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "${infoPro.especificacion}",
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
            )),
        SizedBox(height: 15.0),
        ListTile(
            title: Text(
              "Descripcion",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "${infoPro.descripcion}",
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
            )),
        SizedBox(height: 15.0),
        ListTile(
            title: Text(
              "Caracteristicas",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "${infoPro.caracteristicas}",
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
            )),
        SizedBox(height: 15.0),
        ListTile(
            title: Text(
              "Nota",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "${infoPro.nota}",
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
            )),
        SizedBox(height: 15.0),
        Row(
          children: [
            getComentarios(context),
          ],
        ),
        SizedBox(height: 15.0),
        preguntas(),
      ],
    );
  }

  Widget preguntas() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Comentarios",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            autofocus: false,
            controller: pregunta,

            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.black)),
                labelStyle: TextStyle(color: Colors.black),
                helperText: 'Escribe tu comentario'),
            // ignore: missing_return
            /* validator: (value) {
              if (value.isEmpty) {
                return 'Por favor llena este campo';
              }
            },*/
          ),
          SizedBox(height: 15.0),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.blue),
            child: ElevatedButton(
              onPressed: () {
                addComentario();

                pregunta.text = "";
              },
              child: Container(
                child: Text('Comentar'),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Colors.white,
                shadowColor: Colors.transparent,
                elevation: 0,
                minimumSize: Size(300.0, 40.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getComentarios(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: listaComentarios.length,
        itemBuilder: (BuildContext context, int index) {
          //  _obtenerCliente(listaComentarios[index].idCliente);
          return Container(
            height: 50,
            color: Colors.transparent,
            child: Center(
              child: ListTile(
                title: Text(listaComentarios[index].comentario),
                subtitle: Text(
                  listaComentarios[index].fecha +
                      ' ' +
                      listaComentarios[index].idCliente +
                      ' ',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MySelectionItem extends StatefulWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  _MySelectionItemState createState() => _MySelectionItemState();
}

class _MySelectionItemState extends State<MySelectionItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: widget.isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : widget.title == "otra cantidad"
              ? TextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  controller: cantidad,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black),
                      hintText: 'Cantidad'),

                  /*onChanged: (value) {
                    setState(() {
                      cantidad.text = value;
                    });
                  },*/
                )
              : Card(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Stack(
                    children: <Widget>[
                      _buildItem(context),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(widget.title),
    );
  }
}
