import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/responses.dart';

import 'package:restaurant_app/model/source.dart';

class Tables {
  final int? id;
  final int restaurantId;
  final String? restaurantName;
  final int branchId;
  final String? branchName;
  final String? phone;
  final String status; //todo: enum("empty", "reserved", "concatenate")
  final List<Table>? table;
  Tables({
    required this.id,
    required this.restaurantId,
    required this.restaurantName,
    required this.branchId,
    required this.branchName,
    required this.phone,
    required this.status,
    required this.table,
  });

  Map<String, dynamic> toMap() {
    return {
      'tableId': id,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'branchId': branchId,
      'branchName': branchName,
      'phone': phone,
      'status': status
    };
  }

  factory Tables.fromMap(Map<String, dynamic> map) {
    return Tables(
      id: map['id'],
      restaurantId: map['restaurantId'],
      restaurantName: map['restaurantName'],
      branchId: map['branchId'],
      branchName: map['branchName'],
      phone: map['phone'],
      status: map['status'],
      table: List<Table>.from(map['table']?.map((x) => Table.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Tables.fromJson(String source) => Tables.fromMap(json.decode(source));

//Todo: Use Decode Object Data respone from API
  static Future<Tables> fetchTables() async {
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
/*List<Tables> parseTables(String responseBody) {
  final parse = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parse.map<Tables>((json) => Tables.fromJson(json)).toList();
}

Future<List<Tables>> fetchArrayTables() async {
  final response = await http.get(Uri.parse(url + "/tables/$tableId"),
      headers: {'Authorization': token});
  if (response.statusCode == 200) {
    return parseTables(response.body);
  } else if (response.statusCode == 403) {
    throw "No token accepted";
  } else {
    throw "Net work error";
  }
}*/
//Todo:===================

  static Future<ResponseModel> putTables(Tables table) async {
    final puttable = await http.put(Uri.parse(url + "/tables/update-status"),
        headers: {'Authorization': token, 'content-type': 'application/json'},
        body: table.toJson());
    if (puttable.statusCode == 201) {
      return ResponseModel.fromJson(puttable.body);
    } else {
      throw Exception("Error");
    }
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
