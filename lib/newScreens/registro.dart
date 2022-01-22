import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tienda/constants/url.dart';
import 'package:tienda/screens/home.dart';
import 'package:http/http.dart' as http;
import 'package:tienda/widgets/alerta.dart';
//import 'package:tienda/constants/Theme.dart';
//import 'package:tienda/widgets/navbar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nombre = new TextEditingController();
  TextEditingController correo = new TextEditingController();
  TextEditingController tel = new TextEditingController();
  TextEditingController dir = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController validarPass = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _reinicioCampos() {
    nombre.text = "";
    correo.text = "";
    pass.text = "";
    validarPass.text = "";
    dir.text = "";
    tel.text = "";
  }

  Future _peticionCuenta() async {
    var url = Uri.parse(clientes['CrearCliente']);

    Map<String, String> cuerpo = {
      "password": "+Tiend@*",
      //"id_cliente": "$usuario",
      "nombre": "${nombre.text}",
      "correo": "${correo.text}",
      "contrasenia": "${validarPass.text}",
      "telefono": "${tel.text}",
      "direccion": "${dir.text}",
      "intento": "0",
      "status": "actvo"
    };
    var body = jsonEncode(cuerpo);
    //print(body);
    try {
      final response = await http.post(url, body: body);
      var datauser = json.decode(response.body);
      //print(datauser['status']);
      if (datauser['status'] == true) {
        showToast(
            context, FontAwesomeIcons.check, Colors.green, "Registro Exitoso!");
        Navigator.pushReplacementNamed(context, '/onboarding');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //height:500.0
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              //MaterialColors.info,
              Colors.blue[300],
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        alignment: Alignment.topCenter,

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(child: SizedBox(height: 20.0)),
              Text('Nueva Cuenta',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  )),
              SizedBox(
                height: 15.0,
              ),
              Container(
                width: 250.0,
                child: Image.asset('assets/img/logo/APLogo.png'),
              ),
              SizedBox(
                height: 55.0,
              ),
              _formRegistro(context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _peticionCuenta();
          }
        },
        label: const Text('Crear'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _inputs() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.done,
            autofocus: false,
            controller: nombre,
            style: TextStyle(color: Colors.white),
            //obscureText: true,
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
                labelText: 'Nombre Completo'),
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor llena este campo';
              }
            },
          ),
          SizedBox(height: 15.0),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            controller: correo,
            style: TextStyle(color: Colors.white),
            autofocus: false,
            //obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.white)),
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Correo'),

            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor llena este campo';
              }
            },
          ),
          SizedBox(height: 15.0),
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            controller: dir,
            style: TextStyle(color: Colors.white),
            autofocus: false,
            //obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.house,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.white)),
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Direccion'),

            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor llena este campo';
              }
            },
          ),
          SizedBox(height: 15.0),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            controller: tel,
            autofocus: false,
            style: TextStyle(color: Colors.white),
            //obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.white)),
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Telefono'),

            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor llena este campo';
              }
            },
          ),
          SizedBox(height: 15.0),
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: pass,
            autofocus: false, style: TextStyle(color: Colors.white),
            //obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.white)),
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Contraseña'),
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor llena este campo';
              }
            },
          ),
          SizedBox(height: 15.0),
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: validarPass,
            autofocus: false,
            style: TextStyle(color: Colors.white),
            //obscureText: true,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Colors.white)),
              labelStyle: TextStyle(color: Colors.white),
              labelText: 'Confirmar contraseña',
            ),
            // ignore: missing_return
            validator: (value) {
              if (value != pass.text) {
                return 'Contraseña no coincide';
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _formRegistro(BuildContext context) {
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
}
