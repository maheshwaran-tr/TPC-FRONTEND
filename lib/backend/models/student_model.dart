// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  final int studentId;
  final String rollNo;
  final String regNo;
  final String studentName;
  final String department;
  final double cgpa;
  final double score10Th;
  final double score12Th;
  final String placementWilling;
  final String community;
  final String gender;
  final String section;
  final String fatherName;
  final String fatherOccupation;
  final String motherName;
  final String motherOccupation;
  final String placeOfBirth;
  final String dateOfBirth;
  final String board10Th;
  final String yearOfPassing10Th;
  final String board12Th;
  final String yearOfPassing12Th;
  final String scoreDiploma;
  final String branchDiploma;
  final String yearOfPassingDiploma;
  final String permanentAddress;
  final String presentAddress;
  final String phoneNumber;
  final String parentPhoneNumber;
  final String email;
  final String aadhar;
  final int batch;
  final int currentSem;
  final String? skills;
  final int standingArrears;
  final int historyOfArrears;
  final String viii;
  final String i;
  final String ii;
  final String iv;
  final String iii;
  final String vii;
  final String v;
  final String vi;

  Student({
    required this.studentId,
    required this.rollNo,
    required this.regNo,
    required this.studentName,
    required this.department,
    required this.cgpa,
    required this.score10Th,
    required this.score12Th,
    required this.placementWilling,
    required this.community,
    required this.gender,
    required this.section,
    required this.fatherName,
    required this.fatherOccupation,
    required this.motherName,
    required this.motherOccupation,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.board10Th,
    required this.yearOfPassing10Th,
    required this.board12Th,
    required this.yearOfPassing12Th,
    required this.scoreDiploma,
    required this.branchDiploma,
    required this.yearOfPassingDiploma,
    required this.permanentAddress,
    required this.presentAddress,
    required this.phoneNumber,
    required this.parentPhoneNumber,
    required this.email,
    required this.aadhar,
    required this.batch,
    required this.currentSem,
    required this.skills,
    required this.standingArrears,
    required this.historyOfArrears,
    required this.viii,
    required this.i,
    required this.ii,
    required this.iv,
    required this.iii,
    required this.vii,
    required this.v,
    required this.vi,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    studentId: json["studentId"],
    rollNo: json["rollNo"],
    regNo: json["regNo"],
    studentName: json["studentName"],
    department: json["department"],
    cgpa: json["cgpa"]?.toDouble(),
    score10Th: json["score10th"]?.toDouble(),
    score12Th: json["score12th"]?.toDouble(),
    placementWilling: json["placementWilling"],
    community: json["community"],
    gender: json["gender"],
    section: json["section"],
    fatherName: json["fatherName"],
    fatherOccupation: json["fatherOccupation"],
    motherName: json["motherName"],
    motherOccupation: json["motherOccupation"],
    placeOfBirth: json["placeOfBirth"],
    dateOfBirth: json["dateOfBirth"],
    board10Th: json["board10th"],
    yearOfPassing10Th: json["yearOfPassing10th"],
    board12Th: json["board12th"],
    yearOfPassing12Th: json["yearOfPassing12th"],
    scoreDiploma: json["scoreDiploma"],
    branchDiploma: json["branchDiploma"],
    yearOfPassingDiploma: json["yearOfPassingDiploma"],
    permanentAddress: json["permanentAddress"],
    presentAddress: json["presentAddress"],
    phoneNumber: json["phoneNumber"],
    parentPhoneNumber: json["parentPhoneNumber"],
    email: json["email"],
    aadhar: json["aadhar"],
    batch: json["batch"],
    currentSem: json["currentSem"],
    skills: json["skills"],
    standingArrears: json["standingArrears"],
    historyOfArrears: json["historyOfArrears"],
    viii: json["viii"],
    i: json["i"],
    ii: json["ii"],
    iv: json["iv"],
    iii: json["iii"],
    vii: json["vii"],
    v: json["v"],
    vi: json["vi"],
  );

  Map<String, dynamic> toJson() => {
    "studentId": studentId,
    "rollNo": rollNo,
    "regNo": regNo,
    "studentName": studentName,
    "department": department,
    "cgpa": cgpa,
    "score10th": score10Th,
    "score12th": score12Th,
    "placementWilling": placementWilling,
    "community": community,
    "gender": gender,
    "section": section,
    "fatherName": fatherName,
    "fatherOccupation": fatherOccupation,
    "motherName": motherName,
    "motherOccupation": motherOccupation,
    "placeOfBirth": placeOfBirth,
    "dateOfBirth": dateOfBirth,
    "board10th": board10Th,
    "yearOfPassing10th": yearOfPassing10Th,
    "board12th": board12Th,
    "yearOfPassing12th": yearOfPassing12Th,
    "scoreDiploma": scoreDiploma,
    "branchDiploma": branchDiploma,
    "yearOfPassingDiploma": yearOfPassingDiploma,
    "permanentAddress": permanentAddress,
    "presentAddress": presentAddress,
    "phoneNumber": phoneNumber,
    "parentPhoneNumber": parentPhoneNumber,
    "email": email,
    "aadhar": aadhar,
    "batch": batch,
    "currentSem": currentSem,
    "skills": skills,
    "standingArrears": standingArrears,
    "historyOfArrears": historyOfArrears,
    "viii": viii,
    "i": i,
    "ii": ii,
    "iv": iv,
    "iii": iii,
    "vii": vii,
    "v": v,
    "vi": vi,
  };
}
