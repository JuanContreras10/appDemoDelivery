import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tienda/constants/clases.dart';
import 'package:tienda/constants/url.dart';
import 'package:tienda/newScreens/cardBusqueda.dart';
import 'package:tienda/newScreens/producto.dart';
import 'package:tienda/screens/onboarding.dart';
import 'package:tienda/screens/profile.dart';
import 'package:tienda/widgets/alerta.dart';
import 'package:tienda/widgets/carga.dart';
import 'package:tienda/widgets/drawerGeneral.dart';

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//widgets
import 'package:tienda/widgets/navbar.dart';
import 'package:tienda/widgets/card-horizontal.dart';
import 'package:tienda/widgets/card-small.dart';
import 'package:tienda/widgets/card-square.dart';
import 'package:tienda/widgets/drawer.dart';
//import 'package:tienda/widgets/photo-album.dart';
import 'package:tienda/widgets/slider-product.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String usuario = "";
String password = "";
String idCliente = "";
var nomselect;

class Home extends StatefulWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  TextEditingController busqueda = new TextEditingController();

  //List<Producto> listaProductos = [];

  List<Map<String, String>> imgArray = [
    {
      "img": "assets/img/productos/libreta.jpg",
      "title": "Libreta NoteBook",
      "description": "Libreta de cuadors, 200 hojas.",
      "price": "\$212",
    },
    {
      "img": "assets/img/productos/pluma.jpg",
      "title": "Pluma Baoer Modelo 388Pluma",
      "description":
          "Pluma Fuente Marca Baoer Modelo 388Pluma Fuente diseñada para una escritura suave, clásica y elegante.",
      "price": "\$200",
    },
    {
      "img": "assets/img/productos/carpeta.jpg",
      "title": "Carpeta",
      "description":
          "WOBEECO - Carpeta con cremallera para conferencias, organizador multifuncional de archivos de negocios, con bolsillos y tarjeteros, cuero A4",
      "price": "\$300",
    },
  ];

  bool isLogin = false;
  UsuarioCliente usuInfo;
  List vacia = [];
  Future _obtenerSesion() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      usuario = preferences.getString("infoSesionUser") ?? "s/n";
      password = preferences.getString("infoSesionPass") ?? "s/n";
      //_obtenerCliente();
      if (usuario != 's/n' && password != 's/n') {
        setState(() {
          isLogin = true;
        });
        _obtenerCliente();
      } else {
        setState(() {
          isLogin = false;
        });
      }
    });
  }

  Future _obtenerCliente() async {
    var url = Uri.parse(clientes['BuscarCliente']);

    Map<String, String> cuerpo = {
      "password": "+Tiend@*",
      "id_cliente": "$usuario"
    };
    var body = jsonEncode(cuerpo);
    try {
      final response = await http.post(url, body: body);
      var datauser = json.decode(response.body);
      // print(datauser);
      if (datauser['status'] == true) {
        usuInfo = UsuarioCliente(datauser['nombre'], datauser['correo'],
            datauser['direccion'], datauser['telefono']);
        setState(() {
          idCliente = datauser['id_cliente'];
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
  void initState() {
    super.initState();
    _obtenerSesion();
    // _obtenerProductos();
    _scrollViewController = new ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

/*
  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[850],
      //extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "Alexander Palacios",
        searchBar: true,
        bgColor: Colors.black,
        searchAutofocus: false,
        searchController: busqueda,
        animationAppbar: true,
        searchOnTap: () => {
          showSearch(
            context: context,
            delegate:
                BuscarPro(list: vacia, isLogin: isLogin, usuInfo: usuInfo),
          )
        },
      ),
      //backgroundColor: MaterialColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: isLogin
          ? MaterialDrawer(currentPage: "Fragos", usuInfo: usuInfo)
          : MaterialDrawerGen(currentPage: "Fragos"),
      body: PanelCentral(control: _scrollViewController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _showAppbar ? floatingNavBar() : Container(),
    );
  }

  Widget floatingNavBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          height: 50.0,
          duration: Duration(milliseconds: 100),
          margin: const EdgeInsets.all(10.0),
          width: 300.0,
          //height: 50.0,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(
                    25.0), //                 <--- border radius here
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black,
                  offset: Offset(1, 3),
                ),
              ] // Make rounded corner of border

              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.transparent,
                tooltip: "Categoria",
                elevation: 0,
                hoverColor: Colors.white30,
                heroTag: "btn1",
                onPressed: () => showMaterialModalBottomSheet(
                  elevation: 10.0,
                  duration: Duration(milliseconds: 1250),
                  bounce: true,
                  expand: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Container(),
                ),
                child: const Icon(
                  Icons.category,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.0),
              FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Colors.transparent,
                tooltip: "Pedidos",
                elevation: 0,
                onPressed: () => showMaterialModalBottomSheet(
                  elevation: 10.0,
                  duration: Duration(milliseconds: 1250),
                  bounce: true,
                  expand: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Container(),
                ),
                child: const Icon(
                  Icons.attach_money,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.0),
              FloatingActionButton(
                heroTag: "btn3",
                backgroundColor: Colors.transparent,
                tooltip: "Favoritos",
                elevation: 0,
                onPressed:
                    // Add your onPressed code here!
                    () => showMaterialModalBottomSheet(
                  elevation: 10.0,
                  duration: Duration(milliseconds: 1250),
                  bounce: true,
                  expand: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Container(),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.heart,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.0),
              FloatingActionButton(
                heroTag: "btn4",
                backgroundColor: Colors.transparent,
                tooltip: "Mi cuenta",
                elevation: 0,
                onPressed:
                    // Add your onPressed code here!
                    () {
                  if (isLogin)
                    showMaterialModalBottomSheet(
                      elevation: 10.0,
                      duration: Duration(milliseconds: 1250),
                      bounce: true,
                      expand: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          Profile(isLogin: true, usuInfo: usuInfo),
                    );
                  else if (isLogin)
                    showMaterialModalBottomSheet(
                      elevation: 10.0,
                      duration: Duration(milliseconds: 1250),
                      bounce: true,
                      expand: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Onboarding(),
                    );
                },
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BuscarPro extends SearchDelegate<String> {
  List<dynamic> list;
  bool isLogin;
  UsuarioCliente usuInfo;

  BuscarPro({this.list, this.isLogin, this.usuInfo});
  var registro;

  Future showAllPost() async {
    List<Producto> listaProductos = [];
    var url2 = Uri.parse(productos['BuscarProductosNombre']);
    Map cuerpo = {"password": "+Tiend@*", 'nombre': query};
    var body = jsonEncode(cuerpo);
    // print(body);
    final response = await http.post(url2, body: body);
    var datauser = json.decode(response.body);
    //print(datauser);
    for (var i in datauser) {
      // print('object');
      //print(datauser);
      Producto pro = Producto(
          i['id_producto'],
          i['nombre'],
          i['categoria'],
          i['modelo'],
          i['tamanio'],
          i['imagen'],
          i['precio'],
          i['especificacion'],
          i['stock'],
          i['descuento'],
          i['descripcion'],
          i['caracteristicas'],
          i['nota'],
          i['color']);
      listaProductos.add(pro);
    }

    return listaProductos;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = ''; //texto del textfild restablecido
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().length == 0) {
      return Center(child: Text('Producto'));
    }
    return FutureBuilder(
      future: showAllPost(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _crearCart(snapshot, isLogin, usuInfo);
        }
        return Center(child: Carga());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var listData = query.isEmpty
        ? list
        : list
            .where((element) => element.toLowerCase().contains(query))
            .toList();
    return listData.isEmpty
        ? Center(child: Text('Sin resultados'))
        : ListView.builder(
            itemCount: listData.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  query = listData[index];
                  nomselect = listData[index];
                  showResults(context);
                  // Navigator.pushReplacementNamed(context, '/ConsultaEmpresa');
                },
                title: Text(listData[index]),
              );
            });
  }

  Widget _crearCart(
      AsyncSnapshot snapshot, bool isLogin, UsuarioCliente usuInfo) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          var list = snapshot.data[index];

          //String correoId = list['correo'];
          return CardHorizontalBusqueda(
              cta: "Ver",
              title: list.nombre,
              des: "\$ " + list.precio + " MXN",
              img: list.imagen,
              tap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VistaProducto(infoPro: list.idProducto),
                  ),
                );
              });
        });
  }
}

class PanelCentral extends StatefulWidget {
  final ScrollController control;

  const PanelCentral({Key key, this.control}) : super(key: key);

  @override
  _PanelCentral createState() => _PanelCentral();
}

class _PanelCentral extends State<PanelCentral> {
  List<Map<String, String>> imgArray = [
    {
      "img": "assets/img/productos/libreta.jpg",
      "title": "Libreta NoteBook",
      "description": "Libreta de cuadors, 200 hojas.",
      "price": "\$212",
    },
    {
      "img": "assets/img/productos/pluma.jpg",
      "title": "Pluma Baoer Modelo 388Pluma",
      "description":
          "Pluma Fuente Marca Baoer Modelo 388Pluma Fuente diseñada para una escritura suave, clásica y elegante.",
      "price": "\$200",
    },
    {
      "img": "assets/img/productos/carpeta.jpg",
      "title": "Carpeta",
      "description":
          "WOBEECO - Carpeta con cremallera para conferencias, organizador multifuncional de archivos de negocios, con bolsillos y tarjeteros, cuero A4",
      "price": "\$300",
    },
  ];

  Future<List<Producto>> _obtenerProductos() async {
    //_obtenerSesion();
    List<Producto> listaProductos = [];
    var url2 = Uri.parse(productos['BuscarProductos']);
    Map cuerpo = {"password": "+Tiend@*"};
    var body = jsonEncode(cuerpo);
    //print(body);
    try {
      final response = await http.post(url2, body: body);
      var datauser = json.decode(response.body);
      //print(response);
      for (var i in datauser) {
        Producto pro = Producto(
            i['id_producto'],
            i['nombre'],
            i['categoria'],
            i['modelo'],
            i['tamanio'],
            i['imagen'],
            i['precio'],
            i['especificacion'],
            i['stock'],
            i['descuento'],
            i['descripcion'],
            i['caracteristicas'],
            i['nota'],
            i['color']);
        //print(pro.nombre);
        listaProductos.add(pro);
      }
      // print("prueba:  " + listaProductos[0].nombre);
    } catch (e) {
      print('error: ' + e);
    }
    return listaProductos;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: FutureBuilder(
        future: _obtenerProductos(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            print(snapshot.data);
            return Container(
              child: Center(
                child: Carga(),
              ),
            );
          } else {
            return
                //screarFondo(0, 0, 0, 1.0),
                SingleChildScrollView(
                    controller: widget.control,
                    child: _form(context, snapshot));
            // Text('data_$index _' + snapshot.data[index].idcontrato);
          }
        },
      ),
    );
  }

  Widget _form(BuildContext context, AsyncSnapshot snapshot) {
    var productoinfo = snapshot.data;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProductCarousel(imgArray: imgArray),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CardHorizontal(
              cta: "Ver",
              title: productoinfo[0].nombre,
              des: productoinfo[0].precio,
              img: productoinfo[0].imagen,
              tap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VistaProducto(infoPro: productoinfo[0].idProducto),
                  ),
                );
              }),
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardSmall(
                cta: "Ver",
                title: productoinfo[1].nombre,
                des: productoinfo[1].precio,
                img: productoinfo[1].imagen,
                tap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VistaProducto(infoPro: productoinfo[1].idProducto),
                    ),
                  );
                }),
            CardSmall(
                cta: "Ver",
                title: productoinfo[2].nombre,
                des: productoinfo[2].precio,
                img: productoinfo[2].imagen,
                tap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VistaProducto(infoPro: productoinfo[2].idProducto),
                    ),
                  );
                })
          ],
        ),
        SizedBox(height: 8.0),
        CardHorizontal(
            cta: "Ver",
            title: productoinfo[3].nombre,
            des: productoinfo[3].precio,
            img: productoinfo[3].imagen,
            tap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VistaProducto(infoPro: productoinfo[3].idProducto),
                ),
              );
            }),
        SizedBox(height: 8.0),
        CardSquare(
            cta: "Ver",
            title: productoinfo[4].nombre,
            des: productoinfo[4].precio,
            img: productoinfo[4].imagen,
            tap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VistaProducto(infoPro: productoinfo[4].idProducto),
                ),
              );
            }),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardSmall(
                cta: "Ver",
                title: productoinfo[5].nombre,
                des: productoinfo[5].precio,
                img: productoinfo[5].imagen,
                tap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VistaProducto(infoPro: productoinfo[5].idProducto),
                    ),
                  );
                }),
            CardSmall(
                cta: "Ver",
                title: productoinfo[6].nombre,
                des: productoinfo[6].precio,
                img: productoinfo[6].imagen,
                tap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VistaProducto(infoPro: productoinfo[6].idProducto),
                    ),
                  );
                })
          ],
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CardHorizontal(
              cta: "Ver",
              title: productoinfo[7].nombre,
              des: productoinfo[7].precio,
              img: productoinfo[7].imagen,
              tap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VistaProducto(infoPro: productoinfo[7].idProducto),
                  ),
                );
              }),
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardSmall(
                cta: "Ver",
                title: productoinfo[8].nombre,
                des: productoinfo[8].precio,
                img: productoinfo[8].imagen,
                tap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VistaProducto(infoPro: productoinfo[8].idProducto),
                    ),
                  );
                }),
            CardSmall(
                cta: "Ver",
                title: productoinfo[9].nombre,
                des: productoinfo[9].precio,
                img: productoinfo[9].imagen,
                tap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VistaProducto(infoPro: productoinfo[9].idProducto),
                    ),
                  );
                })
          ],
        ),
      ],
    );
  }
}
