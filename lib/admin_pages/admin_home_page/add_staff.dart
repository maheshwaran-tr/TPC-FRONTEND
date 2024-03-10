import 'package:flutter/material.dart';

import '../../backend/models/staff_model.dart';
import '../../backend/requests/staff_request.dart';




class AddStaffPage extends StatefulWidget {

  final token;

  const AddStaffPage({super.key,required this.token});


  @override
  _AddStaffPageState createState() => _AddStaffPageState();
}

class _AddStaffPageState extends State<AddStaffPage> {
  TextEditingController staffIdController = TextEditingController();
  TextEditingController staffNameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController presentAddressController = TextEditingController();

  String errorMessage = "";
  bool isProcessing = false;

  void validateAndSubmit() {
    if (staffIdController.text.isEmpty ||
        staffNameController.text.isEmpty ||
        departmentController.text.isEmpty ||
        dobController.text.isEmpty ||
        genderController.text.isEmpty ||
        placeOfBirthController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        permanentAddressController.text.isEmpty ||
        presentAddressController.text.isEmpty) {
      setState(() {
        errorMessage = "Please fill in all fields";
      });
    } else {
      // Show processing state
      setState(() {
        errorMessage = "";
        isProcessing = true;
      });

      // Perform your submission logic here
      Staff staff = Staff(
        staffDbid: 0, // Assuming id is not entered here and should be handled on the server side (auto-generated).
        staffId: staffIdController.text,
        staffName: staffNameController.text,
        department: departmentController.text,
        dob: dobController.text,
        gender: genderController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text
      );



      // You can use the values from the controllers

      Future.delayed(Duration(seconds: 2), () async {
        // Reset processing state
        setState(() {
          isProcessing = false;
        });

        bool response = await StaffRequest.addStaff(widget.token, staff);

        if(response){
          // Show a success popup
          showSuccessDialog();

          // Clear text fields
          staffIdController.clear();
          staffNameController.clear();
          departmentController.clear();
          dobController.clear();
          genderController.clear();
          placeOfBirthController.clear();
          emailController.clear();
          phoneNumberController.clear();
          permanentAddressController.clear();
          presentAddressController.clear();
        }
      });
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Success',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('Staff details submitted successfully!'),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.person_add),
            SizedBox(width: 8.0),
            Text('Add Staff'),
          ],
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              // Add your help functionality here
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextField("Staff ID", Icons.badge, staffIdController),
                      buildTextField("Staff Name", Icons.person, staffNameController),
                      buildTextField("Department", Icons.work, departmentController),
                      buildTextField("Date of Birth", Icons.calendar_today, dobController),
                      buildTextField("Gender", Icons.transgender, genderController),
                      buildTextField("Place of Birth", Icons.location_on, placeOfBirthController),
                      buildTextField("Email", Icons.email, emailController),
                      buildTextField("Phone Number", Icons.phone, phoneNumberController),
                      buildTextField("Permanent Address", Icons.home, permanentAddressController),
                      buildTextField("Present Address", Icons.location_city, presentAddressController),

                      // Display error message if there is any
                      Text(
                        errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 16.0),
                      // Submit button with circular loading indicator
                      Center(
                        child: ElevatedButton(
                          onPressed: isProcessing ? null : validateAndSubmit,
                          child: isProcessing
                              ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                              : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.send),
                              SizedBox(width: 8.0),
                              Text('Submit'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isProcessing) buildLoadingOverlay(),
        ],
      ),
    );
  }

  Widget buildTextField(String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(icon),
            ],
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoadingOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}