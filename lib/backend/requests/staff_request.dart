import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/applied_job_model.dart';
import '../models/staff_model.dart';
import '../url_config/urls.dart';

class StaffRequest {

  static Future<String> getStaffDept(String token) async {
    Staff staffProfile = await getStaffProfile(token);
    return staffProfile.department;
  }

  static Future<bool> approveAppliedStudents(String token,
      List<JobAppliedModel> applications) async {
    final response = await http.post(
        Uri.parse(Urls.approveAppliedStudents),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"data": applications})
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Staff> getStaffProfile(String token) async {
    final response = await http.get(
      Uri.parse(Urls.staffByToken),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var obj = jsonDecode(response.body);
      final staff = Staff.fromJson(obj);
      return staff;
    } else {
      throw Exception('Failed to load staff profile: ${response.statusCode}');
    }
  }

  static Future<bool> addStaff(String token, Staff staff) async {
    final response = await http.post(
        Uri.parse(Urls.addStaffs),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(staff.toJson())
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateStaff(String token, Staff staff) async {
    final response = await http.put(
        Uri.parse(Urls.updateStaffs),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(staff.toJson())
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteStaff(String token,int id) async{
    String deleteStudentUrl = "${Urls.deleteStaffs}/$id";
    print(deleteStudentUrl);
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

  static Future<List<Staff>?> getAllStaffs(String token) async {
    final response = await http.get(
      Uri.parse(Urls.allStaffs),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body) as List<dynamic>;

      List<Staff> staffList = [];
      for (var obj in jsonData) {
        final pobj = Staff.fromJson(obj);
        staffList.add(pobj);
      }
      return staffList;
    } else {
      return null;
    }
  }
}