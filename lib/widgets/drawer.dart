import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'package:tienda/constants/Theme.dart';
import 'package:tienda/constants/clases.dart';
import 'package:tienda/newScreens/olvido.dart';

//import 'package:tienda/newScreens/olvido.dart';

import 'package:tienda/screens/profile.dart';
import 'package:tienda/widgets/alerta.dart';

import 'package:tienda/widgets/drawer-tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaterialDrawer extends StatefulWidget {
  final String currentPage;
  final UsuarioCliente usuInfo;

  MaterialDrawer({this.currentPage, this.usuInfo});

  @override
  _MaterialDrawerState createState() => _MaterialDrawerState();
}

class _MaterialDrawerState extends State<MaterialDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          child: Column(children: [
        DrawerHeader(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              colorFilter: ColorFilter.srgbToLinearGamma(),
              image: AssetImage("assets/img/fondoEcommerce.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/img/logo/APLogo.png'),
                  maxRadius: 30.0,
                  backgroundColor: Colors.black.withOpacity(0.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                  child: Text("Alexander Palacio",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 21)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text("${widget.usuInfo.nombre}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text("",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            )),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text("",
                                style: TextStyle(
                                    color: MaterialColors.warning,
                                    fontSize: 16)),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: ListView(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            DrawerTile(
                icon: Icons.home,
                onTap: () {
                  if (widget.currentPage != "Fragos")
                    Navigator.pushReplacementNamed(context, '/home');
                },
                iconColor: Colors.black,
                title: "Inicio",
                isSelected: widget.currentPage == "Fragos" ? true : false),
            DrawerTile(
                icon: Icons.account_circle,
                onTap: () {
                  if (widget.currentPage != "Perfil")
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Profile(isLogin: true, usuInfo: widget.usuInfo)),
                    );
                },
                iconColor: Colors.black,
                title: "Mi cuenta",
                isSelected: widget.currentPage == "Perfil" ? true : false),
            DrawerTile(
                icon: Icons.lock,
                onTap: () {
                  //if (currentPage != "Ajustes")
                  //Navigator.pushReplacementNamed(context, '/settings');
                  showMaterialModalBottomSheet(
                    elevation: 10.0,
                    duration: Duration(milliseconds: 1250),
                    bounce: true,
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => OlvidoPass(),
                  );
                },
                iconColor: Colors.black,
                title: "Olvide mi contraseña",
                isSelected: widget.currentPage == "Settings" ? true : false),
            DrawerTile(
                icon: Icons.settings,
                onTap: () {
                  //if (currentPage != "Ajustes")
                  //Navigator.pushReplacementNamed(context, '/settings');
                },
                iconColor: Colors.black,
                title: "Ajustes",
                isSelected: widget.currentPage == "Settings" ? true : false),
            Container(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        _cerrarSesion(context),
                      ],
                    ))),
          ],
        ))
      ])),
    );
  }

  Widget _cerrarSesion(BuildContext context) {
    guardarSesion() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("infoSesionUser", "s/n");
      preferences.setString("infoSesionPass", "s/n");
    }

    return ElevatedButton(
      //padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15),
      child: Container(
        child: Text('Cerrar Sesion'),
      ),
      style: ElevatedButton.styleFrom(
        primary: MaterialColors.error,
        onPrimary: Colors.white,
        shadowColor: Colors.grey,
        elevation: 5,
        minimumSize: Size(250.0, 40.0),
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
      ),
      onPressed: () {
        showToast(context, FontAwesomeIcons.powerOff, Colors.green, "Adios!");
        guardarSesion();
        Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }
}
