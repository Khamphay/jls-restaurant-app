import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/source.dart';

class Tables {
  final int restaurantId;
  final String restaurantName;
  final int branchId;
  final String branchName;
  final String phone;
  final String status;
  final List<Table> table;

  Tables(this.restaurantId, this.restaurantName, this.branchId, this.branchName,
      this.phone, this.status, this.table);
  factory Tables.fromMap(Map<String, dynamic> data) {
    return Tables(
        data["restaurantId"],
        data["restaurantName"],
        data["branchId"],
        data["branchName"],
        data["phone"],
        data["status"],
        List<Table>.from(data["table"].map((item) => Table.fromMap(item)))
            .toList());
  }

  factory Tables.fromJson(String responseBody) {
    return Tables.fromMap(json.decode(responseBody));
  }
}

class Table {
  final int id;
  final String name;
  final String status;

  Table(this.id, this.name, this.status);
  factory Table.fromMap(Map<String, dynamic> item) {
    return Table(item["id"], item["name"], item["status"]);
  }
}

//Todo: Use Decode Object Data respone from API
Future<Tables> fetchTables() async {
  final response = await http.get(Uri.parse(url + "/tables/$branch_Id"),
      headers: {'Authorization': token});
  if (response.statusCode == 200) {
    return Tables.fromJson(response.body);
  } else if (response.statusCode == 403) {
    throw "No token accepted";
  } else {
    throw "Net work error";
  }
}

//Todo: Use Decode Array Data respone from API
// List<Tables> parseTables(String responseBody) {
//   final parse = json.decode(responseBody).cast<Map<String, dynamic>>();
//   return parse.map<Tables>((json) => Tables.fromJson(json)).toList();
// }

// Future<List<Tables>> fetchArrayTables() async {
//   final response = await http.get(Uri.parse(url + "/tables/$tableId"),
//       headers: {'Authorization': token});
//   if (response.statusCode == 200) {
//     return parseTables(response.body);
//   } else if (response.statusCode == 403) {
//     throw "No token accepted";
//   } else {
//     throw "Net work error";
//   }
// }
//Todo:===================
