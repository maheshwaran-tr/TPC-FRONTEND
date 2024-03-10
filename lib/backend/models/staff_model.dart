// To parse this JSON data, do
//
//     final staff = staffFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Staff staffFromJson(String str) => Staff.fromJson(json.decode(str));

String staffToJson(Staff data) => json.encode(data.toJson());

class Staff {
  final dynamic createdAt;
  final dynamic lastModifiedAt;
  final int staffDbid;
  final String staffId;
  final String staffName;
  final String department;
  final String dob;
  final String gender;
  final String email;
  final String phoneNumber;

  Staff({
    this.createdAt,
    this.lastModifiedAt,
    required this.staffDbid,
    required this.staffId,
    required this.staffName,
    required this.department,
    required this.dob,
    required this.gender,
    required this.email,
    required this.phoneNumber,
  });

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    createdAt: json["createdAt"],
    lastModifiedAt: json["lastModifiedAt"],
    staffDbid: json["staffDBID"],
    staffId: json["staffId"],
    staffName: json["staffName"],
    department: json["department"],
    dob: json["dob"],
    gender: json["gender"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "staffDBID": staffDbid,
    "staffId": staffId,
    "staffName": staffName,
    "department": department,
    "dob": dob,
    "gender": gender,
    "email": email,
    "phoneNumber": phoneNumber,
  };
}
