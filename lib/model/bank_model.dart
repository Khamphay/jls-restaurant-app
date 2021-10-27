// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/source.dart';

class Banks {
  int id;
  String bank;
  String QRCode;
  Banks(
    this.id,
    this.bank,
    this.QRCode,
  );

  factory Banks.fromMap(Map<String, dynamic> map) {
    return Banks(
      map['id'],
      map['bank'],
      map['QRCode'],
    );
  }
}

List<Banks> parseBanks(String responseBody) {
  final pares = json.decode(responseBody).cast<Map<String, dynamic>>();
  return pares.map<Banks>((data) => Banks.fromMap(data)).toList();
}

Future<List<Banks>> fetchBanks(int restaurantId, int branchId) async {
  final response = await http.get(
      Uri.parse(url + "/banks/$restaurantId&$branchId"),
      headers: {'Authorization': token});
  if (response.statusCode == 200) {
    return parseBanks(response.body);
  } else if (response.statusCode == 403) {
    throw "No token accepted";
  } else {
    return throw "Network Error...";
  }
}
