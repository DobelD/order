class MinumModel {
  int? i;
  int? id;
  String? name;
  int? price;
  String? description;
  String? image;

  MinumModel(
      {this.i, this.id, this.name, this.price, this.description, this.image});

  MinumModel.fromJson(Map<String, dynamic> json) {
    i = json['i'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['i'] = this.i;
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
