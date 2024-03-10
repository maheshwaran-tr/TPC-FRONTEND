import 'dart:async';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sit_placement_app/backend/models/job_post_model.dart';

import '../../backend/requests/job_request.dart';



class JobPostingScreen extends StatefulWidget {
  final token;

  const JobPostingScreen({super.key, required this.token});

  @override
  _JobPostingScreenState createState() => _JobPostingScreenState();
}

class _JobPostingScreenState extends State<JobPostingScreen> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController JobDetailsController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController arrearsHistoryController = TextEditingController();
  TextEditingController companyDetailsController = TextEditingController();
  TextEditingController onOffCampusController = TextEditingController();
  TextEditingController tenthMarkController = TextEditingController();
  TextEditingController twelveController = TextEditingController();
  TextEditingController cgpaController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController venueController = TextEditingController();

  String? filePath;
  String? logoPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Job Posting ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Company Name:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: companyNameController,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter company name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: _pickLogo,
                    icon: Icon(FontAwesomeIcons.image),
                    tooltip: 'Pick company logo',
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Details:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: JobDetailsController,
                maxLines: 5,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Enter job details',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Skills Needed:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: skillsController,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Enter required skills',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'History of Arrears:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: arrearsHistoryController,
                style: TextStyle(fontSize: 18),
                keyboardType: TextInputType.number,
                // Set the keyboard type to numeric
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  // Allow only numeric input
                ],
                decoration: InputDecoration(
                  hintText: 'Enter arrears history details',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Company Details:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
// Rest of your code...

              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: companyDetailsController,
                maxLines: 5,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Enter company details',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'On-campus/Off-campus:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: onOffCampusController,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Enter on-campus or off-campus',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Text(
                '10th Mark:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: tenthMarkController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                // Allow decimal input
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  // Allow double values
                ],
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Enter 10th Mark',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Text(
                '12th Mark:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: twelveController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Enter 12th Mark',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'CGPA:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: cgpaController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Enter CGPA',
                  border: OutlineInputBorder(),
                ),
              ),
// Rest of your code...

              SizedBox(height: 15),
              Text(
                'Interview Date:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: dateController,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Select interview date',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (selectedDate != null) {
                    dateController.text =
                    "${selectedDate.toLocal()}".split(' ')[0];
                  }
                },
              ),
              SizedBox(height: 15),
              Text(
                'Interview Time:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: timeController,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Select interview time',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    timeController.text = selectedTime.format(context);
                  }
                },
              ),
              SizedBox(height: 15),
              Text(
                'Interview Address:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: venueController,
                style: TextStyle(fontSize: 18),
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter interview address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: _pickFile,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.fileUpload),
                        SizedBox(width: 5),
                        Text('Choose File', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  filePath != null
                      ? Text(
                    'File: $filePath',
                    style: TextStyle(fontSize: 18),
                  )
                      : Container(),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _postJob();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FontAwesomeIcons.paperPlane),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Post Job', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return result.files.single.path;
    }
    return null;
  }

  Future<String?> _pickLogo() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    }
    return null;
  }

  Future<void> _postJob() async {
    // Validate all fields
    if (_validateFields()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dialog dismissal with tap
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text("Posting Job..."),
                ],
              ),
            ),
          );
        },
      );

      // Simulate a 2-second processing delay
      await Future.delayed(Duration(seconds: 2));

      // Hide loading indicator
      Navigator.of(context).pop();

      // Implement your logic for posting the job
      JobPostModel postJobModel = JobPostModel(
        jobId: 0,
        companyName: companyNameController.text,
        companyDetails: companyDetailsController.text,
        requiredSkills: skillsController.text,
        historyOfArrears: arrearsHistoryController.text,
        jobName: JobDetailsController.text,
        jobDescription: JobDetailsController.text,
        campusMode: onOffCampusController.text,
        eligible10ThMark: double.parse(tenthMarkController.text),
        eligible12ThMark: double.parse(twelveController.text),
        eligibleCgpaMark: double.parse(cgpaController.text),
        venue: venueController.text,
        interviewDate: dateController.text,
        interviewTime: timeController.text,
      );

      bool res = await JobRequest.postTheJob(widget.token, postJobModel);

      if (res == true) {
        _showSuccessDialog();
      } else {
        print("ERROR");
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.green,
                  size: 50,
                ),
                SizedBox(height: 16),
                Text(
                  "Job Successfully Posted!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.green,
                  ),
                  child: Text("OK"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _validateFields() {
    List<TextEditingController> controllers = [
      companyNameController,
      JobDetailsController,
      skillsController,
      arrearsHistoryController,
      companyDetailsController,
      onOffCampusController,
      tenthMarkController,
      twelveController,
      cgpaController,
      dateController,
      timeController,
      venueController,
    ];

    for (TextEditingController controller in controllers) {
      if (controller.text.isEmpty) {
        _showErrorDialog("Please fill in all fields.");
        return false;
      }
    }

    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    companyNameController.dispose();
    JobDetailsController.dispose();
    skillsController.dispose();
    arrearsHistoryController.dispose();
    companyDetailsController.dispose();
    onOffCampusController.dispose();
    tenthMarkController.dispose();
    twelveController.dispose();
    cgpaController.dispose();
    dateController.dispose();
    timeController.dispose();
    venueController.dispose();
    super.dispose();
  }
}