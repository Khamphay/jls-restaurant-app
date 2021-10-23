// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/source.dart';

class Category {
  int id;
  String name;
  String ipAddress;
  int portNumber;

  Category(this.id, this.name, this.ipAddress, this.portNumber);

  factory Category.fromJson(Map<String, dynamic> categories) {
    return Category(categories["id"], categories["name"],
        categories["ipAddress"], categories["portNumber"]);
  }
}

List<Category> parseCategory(String responseBody) {
  final parse = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parse.map<Category>((json) => Category.fromJson(json)).toList();
}

Future<List<Category>> fetchCategory() async {
  final response = await http.get(
      Uri.parse(url + "/categories/${langsCode}/${restaurantId}&${branchId}"),
      headers: {'Authorization': token});
  if (response.statusCode == 200) {
    return parseCategory(response.body);
  } else if (response.statusCode == 403) {
    throw "No token accepted";
  } else {
    throw "Net work error";
  }
}
