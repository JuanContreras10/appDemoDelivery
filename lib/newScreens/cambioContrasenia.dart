//import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tienda/constants/url.dart';
import 'package:tienda/screens/home.dart';
import 'package:tienda/widgets/alerta.dart';
//import 'package:tienda/constants/Theme.dart';
import 'package:http/http.dart' as http;

TextEditingController pass = new TextEditingController();
TextEditingController newPass = new TextEditingController();

class NewPass extends StatefulWidget {
  @override
  _NewPassState createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  Future _updatePass() async {
    var url = Uri.parse(clientes['ActualizarContra']);

    Map<String, String> cuerpo = {
      "password": "+Tiend@*",
      "id_cliente": "$usuario",
      "contrasenia": "${newPass.text}"
    };
    var body = jsonEncode(cuerpo);
    print(body);
    try {
      final response = await http.post(url, body: body);
      var datauser = json.decode(response.body);
      print(datauser);
      if (datauser['status'] == true) {
        _cambio();
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
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 400.0,
          width: 375.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
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
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 15.0,
              ),
              Text('Cambiar contraseña',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  )),
              SizedBox(
                height: 15.0,
              ),
              _form(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: pass,
            keyboardType: TextInputType.text,
            obscureText: false,
            style: TextStyle(color: Colors.white),
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
                labelText: 'Contraseña Actual'),
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: newPass,
            keyboardType: TextInputType.text,
            obscureText: false,
            style: TextStyle(color: Colors.white),
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
                labelText: 'Nueva Contraseña'),
          ),
          SizedBox(
            height: 15.0,
          ),
          _iniciarBtn()
        ],
      )),
    );
  }

  Widget _iniciarBtn() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.blue[50]),
      child: ElevatedButton(
        onPressed: () {
          if (pass.text == newPass.text) {
            _updatePass();
          } else {
            _error();
          }
        },
        child: Container(
          child: Text('Cambiar'),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.blue,
          shadowColor: Colors.transparent,
          elevation: 0,
          minimumSize: Size(300.0, 40.0),
        ),
      ),
    );
  }

  Widget _error() {
    return showToast(
        context, FontAwesomeIcons.bug, Colors.red, "Error en los datos!");
  }

  Widget _cambio() {
    return showToast(context, FontAwesomeIcons.check, Colors.green,
        "Contraseña actualizada verifique su correo electronico!");
  }
}
