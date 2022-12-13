class MenuModel {
  int? i;
  int? id;
  String? name;
  int? price;
  String? description;
  String? image;

  MenuModel(
      {this.i, this.id, this.name, this.price, this.description, this.image});

  MenuModel.fromJson(Map<String, dynamic> json) {
    i = json['i'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['i'] = i;
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
