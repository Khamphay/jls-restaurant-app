const tableName = "ordermenu";

class OrderFields {
  static final List<String> values = [
    id,
    menuName,
    price,
    qty,
    totalPrice,
    image
  ];

  static const String id = "id";
  static const String menuName = "name";
  static const String price = "price";
  static const String qty = "qty";
  static const String totalPrice = "totalPrice";
  static const String image = 'image';
}

class OrderMenu {
  int id;
  String menuName;
  double price;
  int qty;
  double totalPrice;
  String image;
  OrderMenu({
    required this.id,
    required this.menuName,
    required this.price,
    required this.qty,
    required this.totalPrice,
    required this.image,
  });

  OrderMenu copy({
    int? id,
    String? menuName,
    double? price,
    int? qty,
    double? totalPrice,
    String? image,
  }) {
    return OrderMenu(
      id: id ?? this.id,
      menuName: menuName ?? this.menuName,
      price: price ?? this.price,
      qty: qty ?? this.qty,
      totalPrice: totalPrice ?? this.totalPrice,
      image: image ?? this.image,
    );
  }

  Map<String, Object> toJson() {
    return {
      OrderFields.id: id,
      OrderFields.menuName: menuName,
      OrderFields.price: price,
      OrderFields.qty: qty,
      OrderFields.totalPrice: totalPrice,
      OrderFields.image: image
    };
  }

  static OrderMenu fromJson(Map<String, Object?> json) {
    return OrderMenu(
        id: json[OrderFields.id] as int,
        menuName: json[OrderFields.menuName] as String,
        price: json[OrderFields.price] as double,
        qty: json[OrderFields.qty] as int,
        totalPrice: json[OrderFields.totalPrice] as double,
        image: json[OrderFields.image] as String);
  }
}
