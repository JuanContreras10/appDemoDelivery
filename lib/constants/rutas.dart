// screens
import 'package:flutter/material.dart';
import 'package:tienda/constants/clases.dart';
import 'package:tienda/newScreens/olvido.dart';
import 'package:tienda/newScreens/producto.dart';
import 'package:tienda/newScreens/registro.dart';
import 'package:tienda/screens/home.dart';
import 'package:tienda/screens/profile.dart';
import 'package:tienda/screens/settings.dart';
import 'package:tienda/screens/components.dart';
import 'package:tienda/screens/onboarding.dart';
import 'package:tienda/screens/pro.dart';

UsuarioCliente usuinfo;

Map<String, WidgetBuilder> rutas() {
  return <String, WidgetBuilder>{
    "/onboarding": (BuildContext context) => new Onboarding(),
    "/pro": (BuildContext context) => new Pro(),
    "/home": (BuildContext context) => new Home(),
    "/components": (BuildContext context) => new Components(),
    "/profile": (BuildContext context) => new Profile(),
    "/settings": (BuildContext context) => new Settings(),
    "/registro": (BuildContext context) => new LoginPage(),
    "/forgotPass": (BuildContext context) => new OlvidoPass(),
    "/producto": (BuildContext context) => new VistaProducto(),
  };
}
