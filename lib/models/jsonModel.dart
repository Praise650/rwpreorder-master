// class Student {
//   final int id;
//   final String name;
//   final int age;
//
//   Student({this.id, this.name, this.age});
//
//   factory Student.fromJson(Map<String, dynamic> json) {
//     return Student(
//       id: json['id'],
//       name: json['name'],
//       age: json['age'],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'name': name,
//     'age': age,
//   };
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future pushData({
  TextEditingController name,
  TextEditingController lastname,
  TextEditingController email,
  TextEditingController department,
  TextEditingController setYear,
  TextEditingController schoolAddress,
  TextEditingController homeAddress,
  String gender,
  String phone,
}) async {
  // url to registration php script
  // var APIURL = "http://192.168.43.162/phpmodels/registration.php";
  // var apiUrl ="http://127.0.0.1:8000/api/register";
  // var apiUrl = "http://10.0.2.2/api/register";
  var apiUrl = "http://192.168.43.162:8000/api/register";

  //json maping user entered details
  Map mapdata = {
    'name': name.text.toString(),
    'lastname': lastname.text.toString(),
    'email': email.text.toString(),
    'phoneNumber': phone.trim().toString(),
    'gender': gender,
    'department': department.text.toString(),
    'setyear': setYear.text.toString(),
    'schoolAddress': schoolAddress.text.toString(),
    'homeAddress': homeAddress.text.toString()
  };
  //send  data using http post to our php code
  http.Response response = await http.post(Uri.parse(apiUrl),
      headers: {'Accept': 'application/json'}, 
      body: mapdata);
  //getting response from php code, here
  // var data = json.decode(response.body);
  // print("DATA: $data");
}
