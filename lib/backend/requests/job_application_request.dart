import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sit_placement_app/backend/models/applied_job_model.dart';
import '../url_config/urls.dart';

class JobApplicationRequest{

  static Future<List<JobAppliedModel>> findAll(String token) async {
    final response = await http.get(
      Uri.parse(Urls.findAllJobApplications),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }
    );
    if(response.statusCode==200){
      List<dynamic> jsonData = jsonDecode(response.body) as List<dynamic>;
      List<JobAppliedModel> allApplications = [];
      for(var obj in jsonData){
        allApplications.add(JobAppliedModel.fromJson(obj));
      }
      return allApplications;
    }else{
      return [];
    }
  }


}