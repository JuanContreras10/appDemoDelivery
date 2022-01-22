import 'package:ftoast/ftoast.dart';
import 'package:flutter/material.dart';

showToast(BuildContext context, IconData icono, Color color, String text) {
  //print('hola');
  Widget toast = Container(
    margin: EdgeInsets.only(
      right: 10.0,
      left: 10.0,
      top: MediaQuery.of(context).size.height * 0.80,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: color,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icono,
          color: Colors.white,
        ),
        SizedBox(
          width: 12.0,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );

  FToast.toast(
    context,
    toast: toast,
    //duration: 2000
  );
}
