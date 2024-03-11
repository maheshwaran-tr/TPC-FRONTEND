import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sit_placement_app/backend/models/status_model.dart';
import 'package:sit_placement_app/backend/requests/update_status_request.dart';
import '../../backend/models/applied_job_model.dart';

class UploadJobStatus extends StatefulWidget {
  final token;
  final JobAppliedModel theJob;

  const UploadJobStatus({Key? key, required this.theJob,required this.token}) : super(key: key);

  @override
  State<UploadJobStatus> createState() => _UploadJobStatusState();
}

class _UploadJobStatusState extends State<UploadJobStatus> {
  String? interviewStatus;
  String proof = '';
  final List<String> interviewStatusOptions = [
    'Selected',
    'Not Selected',
    'Waiting for Result'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Upload Status for ${widget.theJob.jobPost.companyName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Company Name:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              widget.theJob.jobPost.companyName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Company Details:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              widget.theJob.jobPost.companyDetails,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Job Name:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              widget.theJob.jobPost.jobName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              value: interviewStatus,
              items: interviewStatusOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline),
                      SizedBox(width: 8),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  interviewStatus = value;
                });
              },
              decoration: InputDecoration(labelText: 'Interview Status'),
            ),
            SizedBox(height: 10),
            Visibility(
              visible: interviewStatus == 'Selected',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      String? filePath = await FilePicker.platform
                          .pickFiles()
                          .then((value) => value?.files.first.path);

                      if (filePath != null) {
                        setState(() {
                          proof = filePath;
                        });
                      }
                    },
                    icon: Icon(Icons.attach_file),
                    label: Text('Pick a File'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        setState(() {
                          proof = image.path;
                        });
                      }
                    },
                    icon: Icon(Icons.image),
                    label: Text('Pick an Image'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Fill in the details and share your interview experience!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_areAllFieldsFilled()) {
                  _handleSubmit();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Please fill all fields before submitting.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload_rounded),
                  SizedBox(width: 10),
                  Text('Submit'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _areAllFieldsFilled() {
    return interviewStatus != null &&
        (interviewStatus != 'Selected' || proof.isNotEmpty);
  }

  void _handleSubmit() async {
    if (proof.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a file or image.'),
        ),
      );
      return;
    }

    uploadProof();
    updateStatus();

  }

  void uploadProof() async {
    try {
      var responseStatusCode = await UpdateStatusRequest.uploadProof(widget.token, widget.theJob.jobAppliedId.toString(), proof);
      if (responseStatusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Proof uploaded successfully!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload proof.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading proof: $e'),
        ),
      );
    }
  }

  void updateStatus() async{
    try{
      StatusModel updatedStatus = new StatusModel(statusId: 3, statusName: "Selected");
      var responseStatusCode = await UpdateStatusRequest.updateStatus(widget.token, widget.theJob, updatedStatus);
      if (responseStatusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Status uploaded successfully!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload Status.'),
          ),
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading Status: $e'),
        ),
      );
    }
  }

}
