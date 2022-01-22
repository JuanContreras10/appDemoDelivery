import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tienda/constants/Theme.dart';
//import 'package:tienda/widgets/navbar.dart';

class CardFav extends StatefulWidget {
  CardFav({
    this.title = "Placeholder Title",
    this.cta = "",
    this.img = "",
    this.tap = defaultFunc,
    this.des = "",
    this.id,
  });

  final String cta;
  final String img;
  final Function tap;
  final String title;
  final String des;

  final String id;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  _CardFavState createState() => _CardFavState();
}

class _CardFavState extends State<CardFav> {
  @override
  Widget build(BuildContext context) {
    // double _currentSliderValue = widget.cantidad;
    //double precio = double.parse(widget.des) * double.parse(widget.cantidad);
    //var cantidad = widget.cantidad;

    Uint8List bytes = base64.decode(widget.img);

    return Container(
        height: 130,
        margin: EdgeInsets.only(top: 10),
        child: GestureDetector(
          //onTap: widget.tap,
          child: Stack(
            children: [
              Card(
                elevation: 0.7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                child: Row(
                  children: [
                    Flexible(flex: 1, child: Container()),
                    Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.title,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18)),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text("\$ ${widget.des}",
                                          style: TextStyle(
                                              color: MaterialColors.caption,
                                              fontSize: 20)),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: ElevatedButton(
                                          child: Text(
                                            widget.cta,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.transparent,
                                            onPrimary: Colors.blue,
                                            elevation: 0,
                                            minimumSize: Size(40.0, 40.0),
                                          ),
                                          onPressed: widget.tap,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Text(
                                          "Deslisa para eliminar",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.red),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
                    width: 100,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.06),
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
