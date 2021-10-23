import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/source.dart';

class Coupons {
  int id;
  String couponeCode;
  int percentDiscount;
  bool isUse;
  DateTime dateExit;
  Coupons({
    required this.id,
    required this.couponeCode,
    required this.percentDiscount,
    required this.isUse,
    required this.dateExit,
  });

//Todo: Use for Encode Or Convert Object to Json
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'couponeCode': couponeCode,
      'percentAmount': percentDiscount,
      'isUse': isUse,
      'dateExit': dateExit.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

//Todo: User for Decode Or Convert Json to Object
  factory Coupons.fromMap(Map<String, dynamic> map) {
    return Coupons(
      id: map['id'],
      couponeCode: map['generatedCode'],
      percentDiscount: map['percentAmount'],
      isUse: map['isUse'],
      dateExit: DateTime.parse(map['dateExit']),
    );
  }

  factory Coupons.fromJson(String source) =>
      Coupons.fromMap(json.decode(source));
}

Future<Coupons?> fetchCoupons(String code) async {
  final response = await http.get(
      Uri.parse(url + "/coupons/coupon/$branchId&$code"),
      headers: {'Authorization': token});
  if (response.statusCode == 200) {
    return Coupons.fromJson(response.body);
  } else if (response.statusCode == 403) {
    throw "No token accepted";
  } else {
    return null;
  }
}
