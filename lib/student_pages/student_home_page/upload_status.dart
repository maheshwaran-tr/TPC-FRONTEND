import 'dart:async';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../backend/models/applied_job_model.dart';

class UploadStatusPage extends StatefulWidget {
  final JobAppliedModel theJob;

  const UploadStatusPage({super.key,required this.theJob});
  @override
  _UploadStatusPageState createState() => _UploadStatusPageState();
}

class _UploadStatusPageState extends State<UploadStatusPage> {
  String companyName = '';
  String field = '';
  String date = '';
  String time = '';
  String venue = '';
  String? campusType;
  String? interviewStatus;
  String proof = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.theJob.jobPost.companyName);
  }
  final List<String> campusTypes = ['On Campus', 'Off Campus'];
  final List<String> interviewStatusOptions = ['Selected', 'Not Selected', 'Waiting for Result'];

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.deepPurple, // Your custom color
            hintColor: Colors.deepPurpleAccent, // Your custom color
            colorScheme: ColorScheme.light(primary: Colors.deepPurple),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        date = pickedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        time = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text('Upload Status',style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            icon: Icon(Icons.info,color: Colors.black,),
            onPressed: () {
              _showInfoDialog();
            },
          ),
        ],// Added app bar title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  icon: Icon(Icons.business),
                ),
                onChanged: (value) {
                  setState(() {
                    companyName = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Field',
                  icon: Icon(Icons.work),
                ),
                onChanged: (value) {
                  setState(() {
                    field = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Date',
                  icon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: _selectDate,
                controller: TextEditingController(text: date),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Time',
                  icon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: _selectTime,
                controller: TextEditingController(text: time),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Venue',
                  icon: Icon(Icons.location_on),
                ),
                onChanged: (value) {
                  setState(() {
                    venue = value;
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: campusType,
                items: campusTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Icon(Icons.location_city),
                        SizedBox(width: 8),
                        Text(value),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    campusType = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Campus Type'),
              ),
              SizedBox(height: 10),
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

                  if (value == 'Selected') {
                    _showProofUploadField();
                  } else {
                    _hideProofUploadField();
                  }
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
                        String? filePath = await FilePicker.platform.pickFiles().then((value) => value?.files.first.path);

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
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

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
                        content: Text('Please fill all fields before submitting.'),
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
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload Status Info'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fill in the details about your interview experience to share with others.'),
                SizedBox(height: 10),
                Text('The "Selected" status allows you to upload proof such as a file or image.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  bool _areAllFieldsFilled() {
    return companyName.isNotEmpty &&
        field.isNotEmpty &&
        date.isNotEmpty &&
        time.isNotEmpty &&
        venue.isNotEmpty &&
        campusType != null &&
        interviewStatus != null &&
        (interviewStatus != 'Selected' || proof.isNotEmpty);
  }

  void _handleSubmit() {
    print('Company Name: $companyName');
    print('Field: $field');
    print('Date: $date');
    print('Time: $time');
    print('Venue: $venue');
    print('Campus Type: $campusType');
    print('Interview Status: $interviewStatus');
    print('Proof: $proof');
    if (_areAllFieldsFilled()) {
      // Show a loading indicator while processing
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Processing...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      );

      // Simulate processing time (you can replace this with your actual processing logic)
      Timer(Duration(seconds: 3), () {
        // Close the loading indicator
        Navigator.of(context).pop();

        // Show the success dialog
        _showSuccessDialog();
      });
    } else {
      // Show a message if all fields are not filled
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields before submitting.'),
        ),
      );
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
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50,
                ),
                SizedBox(height: 16),
                Text(
                  'Upload Successful!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your status has been successfully uploaded.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showProofUploadField() {
    // Additional setup for showing the proof upload field
  }

  void _hideProofUploadField() {
    // Additional setup for hiding the proof upload field
  }
}
