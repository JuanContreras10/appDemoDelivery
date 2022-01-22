import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tienda/constants/Theme.dart';

class CardHorizontalBusqueda extends StatelessWidget {
  CardHorizontalBusqueda({
    this.title = "Placeholder Title",
    this.cta = "",
    this.img = "",
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
          child: Stack(children: [
            Card(
              //color: Colors.black,
              elevation: 0.7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Row(
                children: [
                  Flexible(flex: 1, child: Container()),
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            SizedBox(width: 5.0),
                            Text(des,
                                style: TextStyle(
                                    color: MaterialColors.caption,
                                    fontSize: 18)),
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
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Image.memory(
                    bytes,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
