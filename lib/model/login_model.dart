import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:restaurant_app/model/source.dart';

class Login {
  String username;
  String password;
  Login({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}

class LoginModel {
  String username;
  String firstname;
  String lastname;
  int restaurantId;
  String restaurantName;
  int branchId;
  String branchName;
  String token;
  List<String> roles;
  LoginModel({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.restaurantId,
    required this.restaurantName,
    required this.branchId,
    required this.branchName,
    required this.token,
    required this.roles,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'accessToken': token,
      'roles': roles,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      username: map['username'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      restaurantId: map['restaurantId'],
      restaurantName: map['restaurantName'],
      branchId: map['branchId'],
      branchName: map['branchName'],
      token: map['accessToken'],
      roles: List<String>.from(map['roles']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source));
}

Future<LoginModel?> fetchUser(Login infor) async {
  final response =
      await http.post(Uri.parse(url + '/login'), body: infor.toMap());
  if (response.statusCode == 200) {
    return LoginModel.fromJson(response.body);
  } else {
    return null;
  }
}
