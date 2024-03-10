import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sit_placement_app/backend/models/applied_job_model.dart';
import 'package:sit_placement_app/backend/models/job_post_model.dart';

import '../url_config/urls.dart';

class JobRequest {

  static Future<bool> postTheJob(String token, JobPostModel job) async {
    var regBody = job.toJson();
    final response = await http.post(Uri.parse(Urls.addJobs),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(regBody));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateTheJob(String token, JobPostModel job) async {
    var regBody = job.toJson();
    final response = await http.put(Uri.parse(Urls.updateJobs),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(regBody));
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  static Future<bool> deleteJob(String token,int id) async{
    String deleteJobUrl = "${Urls.deleteJobs}/$id";
    print(deleteJobUrl);
    final response = await http.delete(
      Uri.parse(deleteJobUrl),
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

  static Future<List<JobAppliedModel>> getAllApplications(String token) async {
    final response = await http.get(
      Uri.parse(Urls.getAllApplications),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print("Sucess");
      List<dynamic> jsonData = jsonDecode(response.body) as List<dynamic>;

      List<JobAppliedModel> joblist = [];
      for (var obj in jsonData) {
        if (obj is Map<String, dynamic>) {
          final pobj = JobAppliedModel.fromJson(obj);
          joblist.add(pobj);
        }
      }
      print(joblist);
      return joblist;
    }
    throw Exception('Failed to load jobs');
  }

  static Future<List<JobPostModel>> getAllJobs(String token) async {
    final response = await http.get(
      Uri.parse(Urls.allJobs),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body) as List<dynamic>;

      List<JobPostModel> joblist = [];
      for (var obj in jsonData) {
        if (obj is Map<String, dynamic>) {
          final pobj = JobPostModel.fromJson(obj);
          joblist.add(pobj);
        }
      }
      print(joblist);
      return joblist;
    }
    throw Exception('Failed to load jobs');
  }

  static Future<String> applyJob(int jobId, int rollNo, String token) async {
    var regBody = {"jobId": jobId, "studentId": rollNo};
    var response = await http.post(Uri.parse(Urls.applyJob),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: jsonEncode(regBody));
    print(jsonEncode(regBody));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }
}
