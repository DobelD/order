class Cart {
  String name;
  int menuId;
  int qty;
  int price;
  int? totalPrice;

  Cart(
      {required this.name,
      required this.menuId,
      required this.qty,
      required this.price,
      this.totalPrice});
}

class MinumC {
  String name;
  int menuId;
  int qty;
  int price;

  MinumC(
      {required this.name,
      required this.menuId,
      required this.qty,
      required this.price});
}

class CemilC {
  String name;
  int menuId;
  int qty;
  int price;

  CemilC(
      {required this.name,
      required this.menuId,
      required this.qty,
      required this.price});
}
