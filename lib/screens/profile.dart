import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda/constants/Theme.dart';
import 'package:tienda/constants/clases.dart';
import 'package:tienda/constants/url.dart';
import 'package:tienda/newScreens/cambioContrasenia.dart';

import 'package:tienda/widgets/alerta.dart';
import 'package:tienda/widgets/carga.dart';
import 'package:tienda/widgets/drawerGeneral.dart';
//import 'package:tienda/constants/clases.dart';

//widgets
import 'package:tienda/widgets/navbar.dart';
import 'package:tienda/widgets/drawer.dart';

import 'home.dart';
import 'package:http/http.dart' as http;
//import 'package:tienda/widgets/photo-album.dart';

class Profile extends StatefulWidget {
  final bool isLogin;
  final UsuarioCliente usuInfo;
  Profile({this.isLogin, this.usuInfo});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nombre = new TextEditingController();

  TextEditingController correo = new TextEditingController();

  TextEditingController tel = new TextEditingController();

  TextEditingController dir = new TextEditingController();

  TextEditingController pass = new TextEditingController();

  TextEditingController validarPass = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  UsuarioCliente usuInfoPer;

  Future<UsuarioCliente> _obtenerCliente() async {
    // _obtenerSesion();
    var url = Uri.parse(clientes['BuscarCliente']);

    Map<String, String> cuerpo = {
      "password": "+Tiend@*",
      "id_cliente": "$usuario"
    };
    var body = jsonEncode(cuerpo);
    //print(body);
    try {
      final response = await http.post(url, body: body);
      var datauser = json.decode(response.body);
      // print(datauser);
      if (datauser['status'] == true) {
        usuInfoPer = UsuarioCliente(datauser['nombre'], datauser['correo'],
            datauser['direccion'], datauser['telefono']);
      } else {
        showToast(context, FontAwesomeIcons.bug, Colors.red,
            "Posible error en los datos de sesion!");
      }
    } catch (e) {
      showToast(context, FontAwesomeIcons.bug, Colors.red,
          "Posible error conexion con el servidor !");
      print("error: $e");
    }
    return usuInfoPer;
  }

  Future _updateCampo() async {
    var url = Uri.parse(clientes['ActualizarCliente']);

    Map<String, String> cuerpo = {
      "password": "+Tiend@*",
      "id_cliente": "$usuario",
      "nombre": "${nombre.text}",
      "correo": "${correo.text}",
      "telefono": "${tel.text}",
      "direccion": "${dir.text}",
    };
    var body = jsonEncode(cuerpo);
    //print(body);
    try {
      final response = await http.post(url, body: body);
      var datauser = json.decode(response.body);
      //print(datauser['status']);
      if (datauser['status'] == true) {
        showToast(context, FontAwesomeIcons.check, Colors.green,
            "Dato(s) actualizados!");
        _obtenerCliente();
      } else {
        showToast(context, FontAwesomeIcons.bug, Colors.red,
            "Posible error envio datos!");
      }
    } catch (e) {
      showToast(context, FontAwesomeIcons.bug, Colors.red,
          "Posible error conexion con  parametros !");
      print("error: $e");
    }
    _reinicioCampos();
  }

  _reinicioCampos() {
    nombre.text = "";
    correo.text = "";
    dir.text = "";
    tel.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "Perfil",
        rightOptions: true,
        transparent: true,
        animationAppbar: true,
      ),
      backgroundColor: MaterialColors.bgColorScreen,
      drawer: widget.isLogin
          ? MaterialDrawer(currentPage: "Perfil", usuInfo: widget.usuInfo)
          : MaterialDrawerGen(currentPage: "Perfil"),
      body: FutureBuilder(
        future: _obtenerCliente(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
              child: _cuerpo(context),
            );
            //Text('data_$index _' + snapshot.data[index].idcontrato);
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _updateCampo();
        },
        label: const Text('Guardar'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _cuerpo(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage("assets/img/fondoEcommerce.jpg"),
                  fit: BoxFit.cover)),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0.9),
              ])),
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.35,
          ),
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text("${usuInfoPer.nombre}",
                    style: TextStyle(fontSize: 28, color: Colors.white)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
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
                              child: Text("${usuInfoPer.correo}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text("${usuInfoPer.telefono}",
                              style: TextStyle(
                                  color: MaterialColors.warning, fontSize: 12)),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Text("",
                                  style: TextStyle(
                                      color: MaterialColors.warning,
                                      fontSize: 16)),
                            ),
                            //Icon(Icons.star_border,
                            // color: MaterialColors.warning, size: 20)
                          ],
                        )
                      ],
                    ),
                  ),
                  /* Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child:
                              Icon(Icons.pin_drop, color: MaterialColors.muted),
                        ),
                        Text("{usuInfo.direccion}",
                            style: TextStyle(color: MaterialColors.muted))
                      ],
                    ),
                  )*/
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
                top: MediaQuery.of(context).size.height * 0.48,
              ),
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Informacion de perfil",
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                    _form(context),
                  ],
                ),
              )),
        )
      ],
    );
  }

  Widget _inputs() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: nombre,
            decoration: InputDecoration(
              hintText: "${usuInfoPer.nombre}",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),

            //obscureText: true,
            //decoration: InputDecoration(labelText: 'Fernando Rojas'),
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor llena este campo';
              }
            },
          ),
          SizedBox(height: 5.0),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            controller: correo,
            //obscureText: true,
            decoration: InputDecoration(
              hintText: "${usuInfoPer.correo}",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor llena este campo';
              }
            },
          ),
          SizedBox(height: 5.0),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            controller: tel,
            //obscureText: true,
            decoration: InputDecoration(
              hintText: "${usuInfoPer.telefono}",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor llena este campo';
              }
            },
          ),
          SizedBox(height: 5.0),
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            controller: dir,
            //obscureText: true,
            decoration: InputDecoration(
              hintText: "${usuInfoPer.direccion}",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor llena este campo';
              }
            },
          ),
          SizedBox(height: 5.0),
          _contrasenia(context)
        ],
      ),
    );
  }

  Widget _form(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _inputs(),
          ],
        ),
      ),
    );
  }

  Widget _contrasenia(BuildContext context) {
    return ElevatedButton(
      //padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15),
      child: Container(
        child: Text('Cambiar contraseña'),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue[50],
        onPrimary: Colors.blue,
        shadowColor: Colors.grey,
        elevation: 5,
        minimumSize: Size(300.0, 40.0),
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      onPressed: () {
        showMaterialModalBottomSheet(
          elevation: 10.0,
          duration: Duration(milliseconds: 1250),
          bounce: true,
          expand: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => NewPass(),
        );
      },
    );
  }
}
