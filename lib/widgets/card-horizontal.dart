import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tienda/constants/Theme.dart';

class CardHorizontal extends StatelessWidget {
  CardHorizontal({
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
    return Container(
        height: 130,
        margin: EdgeInsets.only(top: 10),
        child: GestureDetector(
          onTap: tap,
          child: Stack(
            children: [
              Card(
                color: Colors.black,
                elevation: 0.7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              SizedBox(width: 5.0),
                              Text("\$ " + des + " MXN",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              Text(cta,
                                  style: TextStyle(
                                      color: Color.fromRGBO(241, 196, 15, 1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              FractionalTranslation(
                translation: Offset(0.04, -0.08),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    height: MediaQuery.of(context).size.height / 2,
                    width: 165,
                    //color: Colors.black,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors
                                .transparent, //Colors.black.withOpacity(0.06),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: Offset(0, 0))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
