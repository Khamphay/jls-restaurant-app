// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/source.dart';

class Menus {
  int id;
  String name;
  int price;
  String category;
  String unit;
  int countOrder;
  String image;

  Menus(this.id, this.name, this.price, this.category, this.unit,
      this.countOrder, this.image);

  factory Menus.fromJson(Map<String, dynamic> menu) {
    return Menus(menu["id"], menu["name"], menu["price"], menu["categoryName"],
        menu["unitName"], menu["countOrder"], menu["image"]);
  }
}

List<Menus> parseMenus(String responseBody) {
  final parse = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parse.map<Menus>((json) => Menus.fromJson(json)).toList();
}

Future<List<Menus>> fetchMenus(int categoryId) async {
  final response = await http.get(url + "/menus/${langsCode}/${categoryId}",
      headers: {'Authorization': token});
  if (response.statusCode == 200) {
    return parseMenus(response.body);
  } else if (response.statusCode == 403) {
    throw "No token accepted";
  } else {
    throw "ບໍ່ມີຂໍ້ມູນ";
  }
}
