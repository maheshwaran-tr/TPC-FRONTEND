import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sit_placement_app/backend/models/applied_job_model.dart';

import '../models/student_model.dart';
import '../url_config/urls.dart';

class StudentRequest {

  static Future<List<JobAppliedModel>?> getJobAppliedForAllDeptStudents(
      String token, String dept, int statusId) async {

    final response = await http.post(Uri.parse(Urls.studentsByDeptAndStatus),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"statusId": statusId, "dept": dept}));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body) as List<dynamic>;
      List<JobAppliedModel> jobAppliedStudents = [];
      for (var obj in jsonData) {
        final pobj = JobAppliedModel.fromJson(obj);
        jobAppliedStudents.add(pobj);
      }
      print(jobAppliedStudents);
      return jobAppliedStudents;
    } else {
      return null;
    }
  }

  static Future<List<JobAppliedModel>?> getApprovedStudents(
      String token, int statusId) async {
    final response = await http
        .get(Uri.parse("${Urls.getApprovedStudentsAdmin}/$statusId"), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body) as List<dynamic>;
      List<JobAppliedModel> jobAppliedStudents = [];
      for (var obj in jsonData) {
        final pobj = JobAppliedModel.fromJson(obj);
        jobAppliedStudents.add(pobj);
      }
      print(jobAppliedStudents);
      return jobAppliedStudents;
    } else {
      return null;
    }
  }

  static Future<List<JobAppliedModel>?> getJobsAppliedByStudents(
      String token, int studentId) async {
    final response = await http.get(
      Uri.parse("${Urls.appliedJobsByStudent}/$studentId"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body) as List<dynamic>;
      List<JobAppliedModel> jobsList = [];
      for (var obj in jsonData) {
        final pobj = JobAppliedModel.fromJson(obj);
        jobsList.add(pobj);
      }
      return jobsList;
    } else {
      return null;
    }
  }

  static Future<Student> getStudentProfile(String token) async {
    final response = await http.get(
      Uri.parse(Urls.studentByToken),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var obj = jsonDecode(response.body);
      final student = Student.fromJson(obj);
      return student;
    } else {
      throw Exception('Failed to load profile: ${response.statusCode}');
    }
  }

  static Future<bool> addStudent(String token, Student student) async {
    final response = await http.post(Uri.parse(Urls.addStudents),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(student.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateStudent(String token, Student student) async {
    final response = await http.put(Uri.parse(Urls.updateStudents),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(student.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Student>?> getAllStudents(String token) async {
    final response = await http.get(
      Uri.parse(Urls.allStudents),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body) as List<dynamic>;

      List<Student> studentsList = [];
      for (var obj in jsonData) {
        final pobj = Student.fromJson(obj);
        studentsList.add(pobj);
      }
      return studentsList;
    } else {
      return null;
    }
  }

  // static Future<List<Student>> getStudentsByDept(
  //     String token, String dept) async {
  //   final response = await http.get(
  //     Uri.parse("${Urls.studentsByDept}/$dept"),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonData = jsonDecode(response.body) as List<dynamic>;
  //
  //     List<Student> studentsList = [];
  //     for (var obj in jsonData) {
  //       final pobj = Student.fromJson(obj);
  //       studentsList.add(pobj);
  //     }
  //     return studentsList;
  //   }
  //   throw Exception("No Students For This Dept");
  // }

  static Future<bool> updatePlacementWilling(
      String token, Map<String, String> data) async {
    final response = await http.put(Uri.parse(Urls.updatePlacementWilling),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // static Future<List<Student>?> getPWStudents(String token) async {
  //   final response = await http.get(
  //     Uri.parse("${Urls.studentsByPlacementWilling}/yes"),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonData = jsonDecode(response.body) as List<dynamic>;
  //     List<Student> studentsList = [];
  //     for (var obj in jsonData) {
  //       final pobj = Student.fromJson(obj);
  //       studentsList.add(pobj);
  //     }
  //     return studentsList;
  //   } else {
  //     return null;
  //   }
  // }

  static Future<bool> deleteStudent(String token,int id) async{
    String deleteStudentUrl = "${Urls.deleteStudents}/$id";
    final response = await http.delete(
      Uri.parse(deleteStudentUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

}
