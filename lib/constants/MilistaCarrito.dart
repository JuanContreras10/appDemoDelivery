import 'package:flutter/material.dart';

/*
class MilistaCarrito extends InheritedWidget {
  MilistaCarrito({Key key, this.child, this.listCarrito})
      : super(key: key, child: child);
  final List listCarrito;
  final Widget child;

  static MilistaCarrito of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MilistaCarrito>();
  }

  @override
  bool updateShouldNotify(MilistaCarrito oldWidget) {
    return listCarrito != oldWidget.listCarrito;
  }
}*/
class MilistaCarrito with ChangeNotifier {
  List _listCarrito = [];
  String _hola = 'hola desde provider';
  double _totalsuma = 0;

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

  get suma {
    for (var item in _listCarrito) {
      _totalsuma = _totalsuma +
          (double.parse(item.precio) * double.parse(item.cantidad));
    }
    return _totalsuma;
  }

  get total {
    return _totalsuma;
  }

  get resta {
    return _totalsuma = 0;
  }

  get hi {
    return _hola;
  }
}
