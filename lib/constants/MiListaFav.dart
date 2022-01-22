import 'package:flutter/material.dart';

class MilistaFav with ChangeNotifier {
  List _listCarrito = [];

  get myList {
    return _listCarrito;
  }

  set myList(List nuevaListaCarrito) {
    this._listCarrito = nuevaListaCarrito;
    notifyListeners();
  }

  get tamanio {
    return _listCarrito.length;
  }
}
