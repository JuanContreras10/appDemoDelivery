import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda/constants/MilistaCarrito.dart';
import 'package:tienda/constants/rutas.dart';
import 'package:tienda/screens/home.dart';

import 'constants/MiListaFav.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MilistaCarrito()),
        ChangeNotifierProvider(create: (_) => MilistaFav()),
      ],
      child: MaterialKitPROFlutter(),
    ),
  );
}

class MaterialKitPROFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Splash(),
            debugShowCheckedModeBanner: false,
          );
        } else {
          // Loading is done, return the app:
          return MaterialApp(
              theme: ThemeData(
                brightness: Brightness.light,
                primarySwatch: Colors.orange,

                /* light theme settings */
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.orange,

                /* dark theme settings */
              ),
              themeMode: ThemeMode.light,
              title: "tienda",
              debugShowCheckedModeBanner: false,
              initialRoute: "/home",
              routes: rutas(),
              home: Home());
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 38, 38, 0.4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.785,
              child: Image(
                image: AssetImage(
                  'assets/img/logo/APLogo.png',
                ),
              ),
            ),
            Text(
              'ALEXANDER PALACIOS',
              style:
                  TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
