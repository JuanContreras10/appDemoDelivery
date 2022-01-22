//import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:tienda/constants/MiListaFav.dart';
import 'package:tienda/constants/MilistaCarrito.dart';
import 'package:tienda/newScreens/cardCarrito.dart';
import 'package:tienda/newScreens/producto.dart';
import 'package:tienda/widgets/alerta.dart';
import 'package:tienda/widgets/navbar.dart';

import 'cardFav.dart';

//List sumasPro = [];
String dropdownValue = 'One';

String dropdownTalla = 'talla';

String dropdownColor = 'color';

TextEditingController cantidad = new TextEditingController();

class Carrito extends StatefulWidget {
  @override
  _Carrito createState() => _Carrito();
}

class _Carrito extends State<Carrito> {
  List<String> listaTalla = ['chica', 'mediana', 'grande', 'unitalla'];

  List<String> listaColor = ['blanco', 'negro', 'gris', 'azul'];

  Widget _listaCarrito(BuildContext context) {
    //TextEditingController cantidadController = TextEditingController();
    final instanciaLista = Provider.of<MilistaCarrito>(context);

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: instanciaLista.tamanio,
      itemBuilder: (context, int index) {
        final item = instanciaLista.myList[index].idProducto;
        //final precio = double.parse(instanciaLista.myList[index].precio);
        final items = instanciaLista.myList[index];
        return Dismissible(
          background: Container(
            color: Colors.red[100],
            child: Text(
              "Eliminar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          onDismissed: (_) {
            // El parámetro no se usa temporalmente, se indica con un guión bajo
            setState(() {
              //print(instanciaLista.myList.length);
              instanciaLista.resta;

              instanciaLista.myList.removeWhere(
                  (producto) => producto.idProducto == items.idProducto);
              showToast(context, Icons.delete, Colors.red[300],
                  "Eliminado del carrito!");
            });
          }, // monitor
          movementDuration: Duration(milliseconds: 100),
          key: Key(item),
          child: CardCarrito(
              cta: "Editar",
              img: instanciaLista.myList[index].img,
              title: instanciaLista.myList[index].nombre,
              cantidad: instanciaLista.myList[index].cantidad,
              des: instanciaLista.myList[index].precio,
              id: instanciaLista.myList[index].idProducto,
              tap: () {
                setState(() {
                  dropdownTalla = instanciaLista.myList[index].talla;
                  dropdownColor = instanciaLista.myList[index].color;
                  dropdownValue = instanciaLista.myList[index].cantidad;
                });
                showBarModalBottomSheet(
                  elevation: 10.0,
                  duration: Duration(milliseconds: 250),
                  bounce: true,
                  expand: false,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => editar(
                      instanciaLista.myList[index].idProducto,
                      instanciaLista.myList[index].talla,
                      instanciaLista.myList[index].color,
                      instanciaLista.myList[index].cantidad),
                );
              }),
        );
      },
    );
  }

  Widget _listaFav(BuildContext context) {
    //TextEditingController cantidadController = TextEditingController();
    final instanciaLista = Provider.of<MilistaFav>(context);

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: instanciaLista.tamanio,
      itemBuilder: (context, int index) {
        final item = instanciaLista.myList[index].idProducto;
        //final precio = double.parse(instanciaLista.myList[index].precio);
        final items = instanciaLista.myList[index];
        return Dismissible(
          background: Container(
            color: Colors.red[100],
            child: Text(
              "Eliminar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          onDismissed: (_) {
            // El parámetro no se usa temporalmente, se indica con un guión bajo
            setState(() {
              //print(instanciaLista.myList.length);

              instanciaLista.myList.removeWhere(
                  (producto) => producto.idProducto == items.idProducto);
              showToast(context, Icons.delete, Colors.red[300],
                  "Eliminado de favoritos!");
            });
          }, // monitor
          movementDuration: Duration(milliseconds: 100),
          key: Key(item),
          child: CardFav(
              cta: "Ver",
              img: instanciaLista.myList[index].img,
              title: instanciaLista.myList[index].nombre,
              des: instanciaLista.myList[index].precio,
              id: instanciaLista.myList[index].idProducto,
              tap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VistaProducto(
                          infoPro: instanciaLista.myList[index].idProducto),
                    ),
                  )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final instanciaLista = Provider.of<MilistaCarrito>(context);
    final instanciaListaFav = Provider.of<MilistaFav>(context);
    instanciaLista.resta;

    return Stack(children: [
      Navbar(
        title: "",
        backButton: true,
        transparent: true,
        animationAppbar: true,
        rightOptions: false,
        noShadow: true,
      ),
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.shopping_cart),
                    text: "Carrito (${instanciaLista.tamanio})",
                  ),
                  Tab(
                    icon: FaIcon(FontAwesomeIcons.heart),
                    text: "favoritos (${instanciaListaFav.tamanio})",
                  ),
                ],
              ),
              centerTitle: true,
              title: Text('Alexander Palacios',
                  style: TextStyle(fontStyle: FontStyle.italic)),
            ),
            body: TabBarView(
              children: [
                instanciaLista.tamanio == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("No tienes productos en tu carrito")],
                      )
                    : Column(children: [
                        Expanded(flex: 4, child: _listaCarrito(context)),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(20.0),
                                height: 120.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          25.0), //                 <--- border radius here
                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.transparent,
                                          spreadRadius: -10,
                                          blurRadius: 12,
                                          offset: Offset(0, 5))
                                    ]),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text('Total con envio',
                                              style:
                                                  TextStyle(fontSize: 20.0))),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                              '\$ ${instanciaLista.suma}',
                                              style:
                                                  TextStyle(fontSize: 15.0))),
                                    ]),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            color: Colors.blue[50]),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            showToast(
                                                context,
                                                Icons.money,
                                                Colors.green,
                                                "Pagar \$ ${instanciaLista.total} MXN");
                                          },
                                          child: Container(
                                            child: Text('Comprar '),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.transparent,
                                            onPrimary: Colors.blue,
                                            shadowColor: Colors.transparent,
                                            elevation: 0,
                                            minimumSize: Size(600.0, 40.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                instanciaListaFav.tamanio == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("No tienes productos favoritos")],
                      )
                    : Column(
                        children: [
                          Expanded(flex: 1, child: _listaFav(context)),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget editar(String id, String talla, String color, String cant) {
    final instanciaLista = Provider.of<MilistaCarrito>(context);
    return Container(
      height: 350.0,
      //color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 15.0),
                      Text("Cantidad: "),
                      SizedBox(width: 15.0),
                      DropdownButton(
                        hint: Text(dropdownValue),
                        //value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Color.fromRGBO(241, 196, 15, 1),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            // print(dropdownValue);
                            newValue == 'otra cantidad'
                                ? dropdownValue = '6'
                                : dropdownValue = newValue;
                            newValue == 'otra cantidad'
                                ? cantidad.text = '6'
                                : cantidad.text = newValue;
                            final nuevo = instanciaLista.myList.firstWhere(
                                (item) => item.idProducto == id,
                                orElse: () => null);
                            if (nuevo != null) nuevo.cantidad = cantidad.text;

                            // print(dropdownValue);
                          });
                        },
                        items: <String>[
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          'otra cantidad'
                        ].map<DropdownMenuItem>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  dropdownValue == '6'
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
                        )
                      : SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 15.0),
                      Text("Talla: "),
                      SizedBox(width: 15.0),
                      DropdownButton(
                        hint: Text(dropdownTalla),
                        //value: dropdown,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Color.fromRGBO(241, 196, 15, 1),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            // print(dropdownValue);
                            dropdownTalla = newValue;
                            final nuevo = instanciaLista.myList.firstWhere(
                                (item) => item.idProducto == id,
                                orElse: () => null);
                            if (nuevo != null) nuevo.talla = newValue;
                            // print(dropdownValue);
                          });
                        },
                        items: listaTalla.map<DropdownMenuItem>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 15.0),
                      Text("Color: "),
                      SizedBox(width: 15.0),
                      DropdownButton(
                        hint: Text(dropdownColor),
                        //value: dropdown,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Color.fromRGBO(241, 196, 15, 1),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            // print(dropdownValue);
                            dropdownColor = newValue;
                            final nuevo = instanciaLista.myList.firstWhere(
                                (item) => item.idProducto == id,
                                orElse: () => null);
                            if (nuevo != null) nuevo.color = newValue;
                            // print(dropdownValue);
                          });
                        },
                        items: listaColor.map<DropdownMenuItem>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0),
                ),
              ),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(double.infinity, double.infinity),
                    primary: Colors.transparent,
                  ),
                  child: Text("Cambiar"),
                  onPressed: () {
                    setState(() {
                      final nuevo = instanciaLista.myList.firstWhere(
                          (item) => item.idProducto == id,
                          orElse: () => null);
                      if (nuevo != null) nuevo.cantidad = cantidad.text;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
