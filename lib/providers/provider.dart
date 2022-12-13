import 'package:flutter/material.dart';
import 'package:order_food/model/card_model.dart';

class CartProvider with ChangeNotifier {
  final List<Cart> _cart = [];
  final List<MinumC> _minum = [];
  final List<CemilC> _cemil = [];
  List<Cart> get cart => _cart;
  List<MinumC> get minum => _minum;
  List<CemilC> get cemil => _cemil;

  int _totMak = 0;
  int _totMin = 0;
  int _totCem = 0;
  // ignore: recursive_getters
  int get totMak => _totMak;
  int get totMin => _totMin;
  int get totCem => _totCem;

  int get total => _totMak + _totMin + totCem;

  int _satu = 1;
  int _dua = 2;
  int _tiga = 2;

  int _totalPrice = 0;
  int get totalPrice => _satu + _dua + _tiga;

  void addMakanan(
      String name, int menuId, bool isAdd, int price, int totalPrice) {
    if (_cart.where((element) => menuId == element.menuId).isNotEmpty) {
      var index = _cart.indexWhere((element) => element.menuId == menuId);
      _cart[index].qty = (isAdd)
          ? _cart[index].qty + 1
          : (_cart[index].qty > 0)
              ? _cart[index].qty - 1
              : 0;

      _totMak = (isAdd)
          ? _totMak + 1
          : (_totMak > 0)
              ? _totMak - 1
              : 0;

      _totalPrice = (isAdd)
          ? price * _totMak
          : (_totMak > 0)
              ? totalPrice - price
              : 0;
      print("total ${_totalPrice}");
    } else {
      _cart.add(Cart(
          name: name,
          menuId: menuId,
          qty: 1,
          price: price,
          totalPrice: totalPrice));
      print("total ${totalPrice}");
      _totMak = _totMak + 1;
      _totalPrice = price * _totMak + 1;
    }
    notifyListeners();
  }

  void addMinuman(String name, int menuId, bool isAdd, int price) {
    if (_minum.where((element) => menuId == element.menuId).isNotEmpty) {
      var index = _minum.indexWhere((element) => element.menuId == menuId);
      _minum[index].qty = (isAdd)
          ? _minum[index].qty + 1
          : (_minum[index].qty > 0)
              ? _minum[index].qty - 1
              : 0;

      _totMin = (isAdd)
          ? _totMin + 1
          : (_totMin > 0)
              ? _totMin - 1
              : 0;
    } else {
      _minum.add(MinumC(name: name, menuId: menuId, qty: 1, price: price));
      _totMin = _totMin + 1;
    }
    notifyListeners();
  }

  void addCemilan(String name, int menuId, bool isAdd, int price) {
    if (_cemil.where((element) => menuId == element.menuId).isNotEmpty) {
      var index = _cemil.indexWhere((element) => element.menuId == menuId);
      _cemil[index].qty = (isAdd)
          ? _cemil[index].qty + 1
          : (_cemil[index].qty > 0)
              ? _cemil[index].qty - 1
              : 0;

      _totCem = (isAdd)
          ? _totCem + 1
          : (_totCem > 0)
              ? _totCem - 1
              : 0;
    } else {
      _cemil.add(CemilC(name: name, menuId: menuId, qty: 1, price: price));
      _totCem = _totCem + 1;
    }
    notifyListeners();
  }
}
