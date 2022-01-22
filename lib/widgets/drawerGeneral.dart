import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'package:tienda/constants/Theme.dart';
import 'package:tienda/newScreens/registro.dart';
import 'package:tienda/screens/onboarding.dart';

import 'package:tienda/widgets/drawer-tile.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MaterialDrawerGen extends StatelessWidget {
  final String currentPage;

  MaterialDrawerGen({this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          child: Column(children: [
        DrawerHeader(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage("assets/img/fondoEcommerce.jpg"),
                  fit: BoxFit.cover),
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
                  child: Text("Alexander Palacios",
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
                            child: Text("",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))),
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
            ))),
        Expanded(
            child: ListView(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            DrawerTile(
                icon: Icons.home,
                onTap: () {
                  if (currentPage != "Fragos")
                    Navigator.pushReplacementNamed(context, '/home');
                },
                iconColor: Colors.black,
                title: "Inicio",
                isSelected: currentPage == "Fragos" ? true : false),
            DrawerTile(
                icon: Icons.star,
                onTap: () {
                  showBarModalBottomSheet(
                    elevation: 10.0,
                    duration: Duration(milliseconds: 1250),
                    bounce: true,
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Onboarding(),
                  );
                },
                iconColor: Colors.black,
                title: "Iniciar sesion",
                isSelected: currentPage == "Perfil" ? true : false),
            DrawerTile(
                icon: Icons.account_circle,
                onTap: () {
                  showBarModalBottomSheet(
                    elevation: 10.0,
                    duration: Duration(milliseconds: 1250),
                    bounce: true,
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => LoginPage(),
                  );
                },
                iconColor: Colors.black,
                title: "Registarme",
                isSelected: currentPage == "Perfil" ? true : false),
            DrawerTile(
                icon: Icons.contact_page,
                onTap: () {
                  showBarModalBottomSheet(
                    elevation: 10.0,
                    duration: Duration(milliseconds: 1250),
                    bounce: true,
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(),
                  );
                },
                iconColor: Colors.black,
                title: "Contacto",
                isSelected: currentPage == "Settings" ? true : false),
          ],
        ))
      ])),
    );
  }
}
