//import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:tienda/constants/Theme.dart';
//import 'package:http/http.dart' as http;

TextEditingController user = new TextEditingController();

class OlvidoPass extends StatefulWidget {
  @override
  _OlvidoPassState createState() => _OlvidoPassState();
}

class _OlvidoPassState extends State<OlvidoPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 300.0,
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
              Text('Olvide mi Contraseña',
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
            controller: user,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            style: TextStyle(color: Colors.white),
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
          ),
          SizedBox(
            height: 30.0,
          ),
          _iniciarBtn()
        ],
      )),
    );
  }

  Widget _iniciarBtn() {
    return ElevatedButton(
      //padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15),
      child: Container(
        child: Text('Continuar'),
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
        //_nuevaPass();
      },
    );
  }

  // ignore: unused_element
  Widget _error() {
    return AlertDialog(
      title: Text('Id invalido'),
      content: Text("Verifica que tu Id"),
      actions: [
        TextButton(
            child: Text("Aceptar"),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  // ignore: unused_element
  Widget _cambio() {
    return AlertDialog(
      title: Text('Listo!'),
      content: Text(
          "Verifica tu correo te hemos enviado un correo con una contraseña nueva"),
      actions: [
        TextButton(
            child: Text("Aceptar"),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
