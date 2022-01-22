import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tienda/constants/Theme.dart';

class CardSmall extends StatelessWidget {
  CardSmall({
    this.title = "Placeholder Title",
    this.cta = "",
    this.img = "https://via.placeholder.com/200",
    this.tap = defaultFunc,
    this.des = "",
  });

  final String cta;
  final String img;
  final Function tap;
  final String title;

  final String des;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64.decode(img);
    return Flexible(
        child: Container(
      height: 235,
      margin: EdgeInsets.only(top: 10),
      child: GestureDetector(
          onTap: tap,
          child: Stack(children: [
            Card(
                //color: Color.fromRGBO(241, 196, 15, 1),
                color: Colors.black,
                elevation: 0.7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14)),
                              SizedBox(width: 5.0),
                              Text("\$ " + des + " MNX",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(cta,
                                    style: TextStyle(
                                        color: Color.fromRGBO(241, 196, 15, 1),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            FractionalTranslation(
                translation: Offset(0, -0.04),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.185,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(241, 196, 15, 1),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                    ),
                  ),
                ))
          ])),
    ));
  }
}
