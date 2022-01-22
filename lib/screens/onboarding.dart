import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tienda/constants/url.dart';
import 'package:tienda/newScreens/olvido.dart';
import 'package:tienda/newScreens/registro.dart';
import 'package:tienda/widgets/alerta.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//import 'package:flutter/material.dart';

//import 'package:tienda/constants/Theme.dart';
//import 'package:animated_text_kit/animated_text_kit.dart';

TextEditingController user = new TextEditingController();
TextEditingController pass = new TextEditingController();
String usuario = "";
String password = "";
bool isLogin = false;

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  guardarSesion(usu, pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("infoSesionUser", usu);
    preferences.setString("infoSesionPass", pass);
  }

  Future _obtenerLogin() async {
    var url = Uri.parse(clientes['LoginCliente']);

    Map<String, String> cuerpo = {
      "password": "+Tiend@*",
      "correo": "${user.text}",
      "contrasenia": "${pass.text}"
    };
    var body = jsonEncode(cuerpo);
    try {
      final response = await http.post(url, body: body);
      var datauser = json.decode(response.body);
      if (datauser['status'] == true) {
        print(datauser);
        guardarSesion(datauser['id_cliente'], datauser['cos']);
        showToast(
            context, FontAwesomeIcons.check, Colors.green, "Sesion activa!");
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showToast(context, FontAwesomeIcons.bug, Colors.red,
            "Error al iniciar sesion");
      }
    } catch (e) {
      showToast(context, FontAwesomeIcons.bug, Colors.red,
          "Posible error conexion con el servidor");
      print("error: $e");
    }
  }

  Future _obtenerSesion() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      usuario = preferences.getString("infoSesionUser") ?? "s/n";
      password = preferences.getString("infoSesionPass") ?? "s/n";

      if (usuario != 's/n' && password != 's/n') {
        setState(() {
          isLogin = true;
        });
      } else {
        setState(() {
          isLogin = false;
        });
      }
    });
  }

  // ignore: unused_element
  Widget _olvidoPass(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        child: Text(
          'Olvide mi contraseña!',
          style: TextStyle(
            fontSize: 10.0,
          ),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.black.withOpacity(0.0),
          onPrimary: Colors.white,
          elevation: 0,
          minimumSize: Size(40.0, 40.0),
        ),
        onPressed: () => showMaterialModalBottomSheet(
          elevation: 10.0,
          duration: Duration(milliseconds: 1500),
          expand: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => OlvidoPass(),
        ),
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        textInputAction: TextInputAction.done,
        controller: pass,
        obscureText: true,
        autofocus: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            icon: Icon(
              Icons.lock_outline,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(color: Colors.white)),
            labelStyle: TextStyle(color: Colors.white),
            labelText: 'Contraseña'),
      ),
    );
  }

  Widget _iniciarBtn(BuildContext context) {
    return ElevatedButton(
      //padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15),
      child: Container(
        child: Text('Iniciar sesión'),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        shadowColor: Colors.grey,
        elevation: 5,
        minimumSize: Size(300.0, 40.0),
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      onPressed: () {
        _obtenerLogin();
      },
    );
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        autofocus: false,
        textInputAction: TextInputAction.done,
        controller: user,
        obscureText: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(color: Colors.white)),
            labelStyle: TextStyle(color: Colors.white),
            labelText: 'Usuario'),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 73, left: 32, right: 32, bottom: 16),
      child: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                        25.0), //                 <--- border radius here
                  ),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 250.0,
                      child: Image.asset('assets/img/logo/APLogo.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 15.0),
                        _crearEmail(),
                        SizedBox(height: 15.0),
                        _crearPassword(),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      //child: SingleChildScrollView(
                      //scrollDirection: Axis.horizontal,
                      child: Row(children: <Widget>[
                        Expanded(flex: 1, child: _solicitudCuenta(context)),
                        SizedBox(width: 5.0),
                        Expanded(flex: 1, child: _olvidoPass(context)),
                      ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: _iniciarBtn(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _solicitudCuenta(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: Text(
            'tocar para registrarme!',
            style: TextStyle(
              fontSize: 10.0,
            ),
            textAlign: TextAlign.center,
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.black.withOpacity(0.0),
            onPrimary: Colors.white,
            elevation: 0,
            minimumSize: Size(40.0, 40.0),
          ),
          onPressed:
              //Navigator.pushNamed(context, '/registro');
              () => showBarModalBottomSheet(
            elevation: 10.0,
            duration: Duration(milliseconds: 1250),
            bounce: true,
            expand: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => LoginPage(),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    _obtenerSesion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/fondoEcommerce.jpg"),
              fit: BoxFit.cover),
        ),
      ),
      SingleChildScrollView(
          child: Column(children: <Widget>[
        SafeArea(
          child: SizedBox(height: 150.0),
        ),
        _form(context),
      ])),
    ]));
  }
}
