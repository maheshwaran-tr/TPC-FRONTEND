import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/applied_job_model.dart';
import '../models/status_model.dart';
import '../url_config/urls.dart';

class UpdateStatusRequest{


  static Future<int> uploadProof(String token, String applicationId, String proof) async {
    var uri = Uri.parse('http://10.0.2.2:7070/sit/proofs/upload-img');
    var request = http.MultipartRequest('POST', uri);
    request.fields['application_id'] = applicationId; // Replace with the actual username
    request.files.add(await http.MultipartFile.fromPath('file', proof));

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var response = await request.send();
    return response.statusCode;
  }

  static Future<int> updateStatus(String token,JobAppliedModel updatedApplication,StatusModel status) async{
    var uri = Uri.parse('http://10.0.2.2:7070/sit/admin/update-status');
    updatedApplication.status = status;
    final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updatedApplication.toJson())
    );
    return response.statusCode;
  }
}