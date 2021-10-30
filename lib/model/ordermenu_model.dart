import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:restaurant_app/model/source.dart';

//Todo: Order Menu table of sqflite database
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

//Todo: Order Menu model save to sqflite database
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

//Todo: Order model send to API
class Order {
  int? id;
  int restaurantId;
  int branchId;
  int tableId;
  String? tableName;
  int? bankId;
  double total;
  double moneyCoupon;
  double moneyDiscount;
  double moneyUpfrontPay;
  double moneyReceived;
  double moneyChange;
  String isStatus; //Todo: enum('pending','success','cancel')
  String paymentType; //Todo: enum('pending','cash','bank')
  String? referenceNumber;
  Order(
      {required this.id,
      required this.restaurantId,
      required this.branchId,
      required this.tableId,
      required this.tableName,
      required this.bankId,
      required this.total,
      required this.moneyCoupon,
      required this.moneyDiscount,
      required this.moneyUpfrontPay,
      required this.moneyReceived,
      required this.moneyChange,
      required this.isStatus,
      required this.paymentType,
      required this.referenceNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'branchId': branchId,
      'tableId': tableId,
      'bankId': bankId,
      'total': total,
      'moneyCoupon': moneyCoupon,
      'moneyDiscount': moneyDiscount,
      "moneyUpfrontPay": moneyUpfrontPay,
      'moneyReceived': moneyReceived,
      'moneyChange': moneyChange,
      'isStatus': isStatus,
      'paymentType': paymentType,
      'referenceNumber': referenceNumber
    };
  }

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
        id: map['id'],
        restaurantId: map['restaurantId'],
        branchId: map['branchId'],
        tableId: map['tableId'],
        tableName: map['tableName'],
        bankId: map['bankId'],
        total: map['total'].toDouble(),
        moneyCoupon: map['moneyCoupon'].toDouble(),
        moneyDiscount: map['moneyDiscount'].toDouble(),
        moneyUpfrontPay: map['moneyUpfrontPay'].toDouble(),
        moneyReceived: map['moneyReceived'].toDouble(),
        moneyChange: map['moneyChange'].toDouble(),
        isStatus: map['isStatus'],
        paymentType: map['paymentType'],
        referenceNumber: map['referenceNumber']);
  }
//Todo:  Fetch json data to object from API
  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

//Todo:  Fetch json data to list object from API
  static List<Order> parseOrderList(String responseBody) {
    final parse = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parse.map<Order>((data) => Order.fromMap(data)).toList();
  }

  static Future<List<Order>> fetchOrderList() async {
    final response = await http.get(
        Uri.parse(url + "/orders/$restaurant_Id&$branch_Id"),
        headers: {'Authorization': token});
    if (response.statusCode == 200) {
      return parseOrderList(response.body);
    } else if (response.statusCode == 403) {
      throw "No token accepted";
    } else {
      throw "Net work error";
    }
  }

//Todo: Post Order
  static Future<Order?> postOrder(Order order) async {
    final post = await http.post(Uri.parse(url + "/orders"),
        headers: {'Authorization': token, 'content-type': 'application/json'},
        body: order.toJson());
    if (post.statusCode == 201) {
      return Order.fromJson(post.body);
    } else {
      throw Exception();
    }
  }

  //Todo: Put Order
  static Future<Order?> putOrder(Order order) async {
    final post = await http.post(Uri.parse(url + "/orders/update"),
        headers: {'Authorization': token, 'content-type': 'application/json'},
        body: order.toJson());
    if (post.statusCode == 201) {
      return Order.fromJson(post.body);
    } else {
      throw Exception();
    }
  }
}

//Todo: Order Detail model send to API
class OrderDetail {
  int? id;
  int orderId;
  int restaurantId;
  int branchId;
  int tableId;
  int menuId;
  String? menuName;
  int? bankId;
  double price;
  int amount;
  double total;
  String status; //Todo: enum('order','cancel','paid')
  String paymentType; //Todo: enum('pending','cash','bank')
  String? comment;
  String? reason;
  String? referenceNumber;
  OrderDetail({
    required this.id,
    required this.orderId,
    required this.restaurantId,
    required this.branchId,
    required this.tableId,
    required this.menuId,
    required this.menuName,
    required this.bankId,
    required this.price,
    required this.amount,
    required this.total,
    required this.status,
    required this.paymentType,
    required this.comment,
    required this.reason,
    required this.referenceNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'restaurantId': restaurantId,
      'branchId': branchId,
      'tableId': tableId,
      'menuId': menuId,
      'bankId': bankId,
      'price': price,
      'amount': amount,
      'total': total,
      'isStatus': status,
      'paymentType': paymentType,
      'comment': comment,
      'reason': reason,
      'referenceNumber': referenceNumber,
    };
  }

  String toJson() => json.encode(toMap());

  static String toListJson(List<OrderDetail> list) {
    List josnList = [];
    list.map((item) => josnList.add(item.toMap())).toList();
    return jsonEncode(josnList); // Todo: json.encode(josnList)
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      id: map['id'],
      orderId: map['orderId'],
      restaurantId: map['restaurantId'],
      branchId: map['branchId'],
      tableId: map['tableId'],
      menuId: map['menuId'],
      menuName: map['menuName'],
      bankId: map['bankId'],
      price: map['price'].toDouble(),
      amount: map['amount'],
      total: map['total'].toDouble(),
      status: map['isStatus'],
      paymentType: map['paymentType'],
      comment: map['comment'],
      reason: map['reason'],
      referenceNumber: map['referenceNumber'],
    );
  }

  factory OrderDetail.fromJson(String source) =>
      OrderDetail.fromMap(json.decode(source));

  //Todo:  Fetch json data to list object from API
  static List<OrderDetail> parseOrderDetail(String responseBody) {
    final parse = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parse.map<OrderDetail>((data) => OrderDetail.fromMap(data)).toList();
  }

  static Future<List<OrderDetail>> fetchOderDetail(int? orderId) async {
    final response = await http.get(
        Uri.parse(url + "/order-details/$restaurant_Id/$branch_Id&$orderId"),
        headers: {'Authorization': token});
    if (response.statusCode == 200) {
      return OrderDetail.parseOrderDetail(response.body);
    } else if (response.statusCode == 404) {
      throw "ບໍ່ມີຂໍ້ມູນ";
    } else {
      throw "Net work error";
    }
  }

  //Todo: Post Order Detail
  static Future<List<OrderDetail>> postOrderDetail(
      List<OrderDetail> orderDetail) async {
    final post = await http.post(Uri.parse(url + "/order-details"),
        headers: {'Authorization': token, 'content-type': 'application/json'},
        body: toListJson(orderDetail));
    if (post.statusCode == 201) {
      return OrderDetail.parseOrderDetail(post.body);
    } else {
      throw Exception("Not data");
    }
  }

  //Todo: Put Order Detail
  static Future<List<OrderDetail>> putOrderDetail(
      List<OrderDetail> orderDetail) async {
    final post = await http.put(Uri.parse(url + "/order-details/update"),
        headers: {'Authorization': token, 'content-type': 'application/json'},
        body: toListJson(orderDetail));
    if (post.statusCode == 201) {
      return OrderDetail.parseOrderDetail(post.body);
    } else {
      throw Exception("Not data");
    }
  }
}
