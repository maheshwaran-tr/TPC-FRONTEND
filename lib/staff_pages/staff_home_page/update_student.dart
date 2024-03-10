import 'package:flutter/material.dart';
import 'package:sit_placement_app/backend/requests/student_request.dart';

import '../../backend/models/student_model.dart';

class UpdateStudentPage extends StatefulWidget {
  final token;
  final Student student;

  const UpdateStudentPage({super.key, required this.student,required this.token});

  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {

  TextEditingController studentNameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
  TextEditingController cgpaController = TextEditingController();
  TextEditingController standingArrearController = TextEditingController();
  TextEditingController historyOfArrearController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController presentAddressController = TextEditingController();
  TextEditingController communityController = TextEditingController();
  TextEditingController fathernameController = TextEditingController();
  TextEditingController fatheroccupationController = TextEditingController();
  TextEditingController mothernameController = TextEditingController();
  TextEditingController motheroccupationController = TextEditingController();
  TextEditingController score10thController = TextEditingController();
  TextEditingController board10thController = TextEditingController();
  TextEditingController yearofpassing10thController = TextEditingController();
  TextEditingController score12thController = TextEditingController();
  TextEditingController board12thController = TextEditingController();
  TextEditingController yearofpassing12thController = TextEditingController();
  TextEditingController scorediplomaController = TextEditingController();
  TextEditingController branchdiplomaController = TextEditingController();
  TextEditingController yearofpassingdiplomaController = TextEditingController();
  TextEditingController parentphnoController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController placementwillingController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController currentsemController = TextEditingController();
  TextEditingController sem1gpaController = TextEditingController();
  TextEditingController sem2gpaController = TextEditingController();
  TextEditingController sem3gpaController = TextEditingController();
  TextEditingController sem4gpaController = TextEditingController();
  TextEditingController sem5gpaController = TextEditingController();
  TextEditingController sem6gpaController = TextEditingController();
  TextEditingController sem7gpaController = TextEditingController();
  TextEditingController sem8gpaController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentNameController.text = widget.student.studentName;
    rollNoController.text = widget.student.rollNo;
    regNoController.text = widget.student.regNo;
    cgpaController.text = widget.student.cgpa.toString();
    standingArrearController.text = widget.student.standingArrears.toString();
    historyOfArrearController.text = widget.student.historyOfArrears.toString();
    departmentController.text = widget.student.department;
    sectionController.text = widget.student.section;
    dobController.text = widget.student.dateOfBirth;
    genderController.text = widget.student.gender;
    placeOfBirthController.text = widget.student.placeOfBirth;
    emailController.text = widget.student.email;
    phoneNumberController.text = widget.student.phoneNumber;
    permanentAddressController.text = widget.student.permanentAddress;
    presentAddressController.text = widget.student.presentAddress;
    communityController.text = widget.student.community;
    fathernameController.text = widget.student.fatherName;
    fatheroccupationController.text = widget.student.fatherOccupation;
    mothernameController.text = widget.student.motherName;
    motheroccupationController.text = widget.student.motherOccupation;
    score10thController.text = widget.student.score10Th.toString();
    board10thController.text = widget.student.board10Th;
    yearofpassing10thController.text = widget.student.yearOfPassing10Th;
    score12thController.text = widget.student.score12Th.toString();
    board12thController.text = widget.student.board12Th;
    yearofpassing12thController.text = widget.student.yearOfPassing12Th;
    scorediplomaController.text = widget.student.scoreDiploma;
    branchdiplomaController.text = widget.student.branchDiploma;
    yearofpassingdiplomaController.text = widget.student.yearOfPassingDiploma;
    parentphnoController.text = widget.student.parentPhoneNumber;
    aadharController.text = widget.student.aadhar;
    placementwillingController.text = widget.student.placementWilling;
    batchController.text = widget.student.batch.toString();
    currentsemController.text = widget.student.currentSem.toString();
    sem1gpaController.text = widget.student.i;
    sem2gpaController.text = widget.student.ii;
    sem3gpaController.text = widget.student.iii;
    sem4gpaController.text = widget.student.iv;
    sem5gpaController.text = widget.student.v;
    sem6gpaController.text = widget.student.vi;
    sem7gpaController.text = widget.student.vii;
    sem8gpaController.text = widget.student.viii;
  }

  String errorMessage = "";
  bool isProcessing = false;

  Future<void> validateAndSubmit() async {
    if (studentNameController.text.isEmpty ||
        rollNoController.text.isEmpty||
        regNoController.text.isEmpty||
        cgpaController.text.isEmpty||
        standingArrearController.text.isEmpty||
        historyOfArrearController.text.isEmpty||
        departmentController.text.isEmpty ||
        sectionController.text.isEmpty ||
        dobController.text.isEmpty ||
        genderController.text.isEmpty ||
        emailController.text.isEmpty ||
        communityController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        score10thController.text.isEmpty ||
        board10thController.text.isEmpty ||
        yearofpassing12thController.text.isEmpty ||
        placementwillingController.text.isEmpty ||
        batchController.text.isEmpty
    ) {
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
      Student updatedStudent = Student(
        studentId: widget.student.studentId,
        studentName: studentNameController.text,
        department: departmentController.text,
        section: sectionController.text,
        dateOfBirth: dobController.text,
        gender: genderController.text,
        placeOfBirth: placeOfBirthController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        permanentAddress: permanentAddressController.text,
        presentAddress: presentAddressController.text,
        currentSem: int.parse(currentsemController.text),
        community: communityController.text,
        fatherName: fathernameController.text,
        fatherOccupation: fatheroccupationController.text,
        motherName: mothernameController.text,
        motherOccupation: motheroccupationController.text,
        score10Th: double.parse(score10thController.text),
        board10Th: board10thController.text,
        yearOfPassing10Th: yearofpassing10thController.text,
        score12Th: double.parse(score12thController.text),
        board12Th: board12thController.text,
        yearOfPassing12Th: yearofpassing12thController.text,
        scoreDiploma: scorediplomaController.text,
        branchDiploma: branchdiplomaController.text,
        yearOfPassingDiploma: yearofpassingdiplomaController.text,
        parentPhoneNumber: parentphnoController.text,
        aadhar: aadharController.text,
        placementWilling: placementwillingController.text,
        batch: int.parse(batchController.text),
        i: sem1gpaController.text,
        ii: sem2gpaController.text,
        iii: sem3gpaController.text,
        iv: sem4gpaController.text,
        v: sem5gpaController.text,
        vi: sem6gpaController.text,
        vii: sem7gpaController.text,
        viii: sem8gpaController.text,
        rollNo: rollNoController.text,
        regNo: regNoController.text,
        cgpa: double.parse(cgpaController.text),
        skills: widget.student.skills,
        standingArrears: int.parse(standingArrearController.text),
        historyOfArrears: int.parse(historyOfArrearController.text),
      );

      bool isUpdated = await StudentRequest.updateStudent(widget.token,updatedStudent);


      // Reset processing state
      setState(() {
        isProcessing = false;
      });


      if(isUpdated){
        // Show a success popup
        showSuccessDialog("Success","Student Updated Successfully",Icons.check_circle,Colors.green);
        // Clear text fields
        studentNameController.clear();
        departmentController.clear();
        sectionController.clear();
        dobController.clear();
        genderController.clear();
        placeOfBirthController.clear();
        emailController.clear();
        phoneNumberController.clear();
        permanentAddressController.clear();
        presentAddressController.clear();
        currentsemController.clear();
        communityController.clear();
        fathernameController.clear();
        fatheroccupationController.clear();
        mothernameController.clear();
        motheroccupationController.clear();
        score10thController.clear();
        board10thController.clear();
        yearofpassing12thController.clear();
        scorediplomaController.clear();
        branchdiplomaController.clear();
        yearofpassingdiplomaController.clear();
        parentphnoController.clear();
        aadharController.clear();
        placementwillingController.clear();
        batchController.clear();
        sem2gpaController.clear();
        sem1gpaController.clear();
        sem3gpaController.clear();
        sem4gpaController.clear();
        sem5gpaController.clear();
        sem6gpaController.clear();
        sem7gpaController.clear();
        sem8gpaController.clear();
      }
      else{
        showSuccessDialog("Failure","Student Not updated",Icons.close_rounded,Colors.red);
      }
    }
  }

  void showSuccessDialog(String status,String msg,IconData symbol,MaterialColor clr) {
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
                  symbol,
                  color: clr,
                  size: 60.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(msg),
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
  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
        title: Center(
          child: Text(
            "Update Student ",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Colors.white,


      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Stack(
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
                        buildTextField("Student Name", Icons.person, studentNameController),
                        buildTextField("Roll Number", Icons.person, rollNoController),
                        buildTextField("Register Number", Icons.person, regNoController),
                        buildTextField("Department", Icons.work, departmentController),
                        buildTextField("Section", Icons.abc_outlined, sectionController),
                        buildTextField("Date of Birth", Icons.calendar_today, dobController),
                        buildTextField("Gender", Icons.transgender, genderController),
                        buildTextField("Place of Birth", Icons.location_on, placeOfBirthController),
                        buildTextField("Email", Icons.email, emailController),
                        buildTextField("Phone Number", Icons.phone, phoneNumberController),
                        buildTextField("Permanent Address", Icons.home, permanentAddressController),
                        buildTextField("Present Address", Icons.location_city, presentAddressController),
                        buildTextField("Community", Icons.group, communityController),
                        buildTextField("Father's Name", Icons.person, fathernameController),
                        buildTextField("Father's Occupation", Icons.work, fatheroccupationController),
                        buildTextField("Mother's Name", Icons.person, mothernameController),
                        buildTextField("Mother's Occupation", Icons.work, motheroccupationController),
                        buildTextField("10th Score", Icons.score, score10thController),
                        buildTextField("10th Board", Icons.score, board10thController),
                        buildTextField("10th Year of Passing", Icons.calendar_today, yearofpassing10thController),
                        buildTextField("12th Score", Icons.score, score12thController),
                        buildTextField("12th Board", Icons.score, board12thController),
                        buildTextField("12th Year of Passing", Icons.calendar_today, yearofpassing12thController),
                        buildTextField("Diploma Score", Icons.score, scorediplomaController),
                        buildTextField("Diploma Branch", Icons.work, branchdiplomaController),
                        buildTextField("Diploma Year of Passing", Icons.calendar_today, yearofpassingdiplomaController),
                        buildTextField("Parent's Phone Number", Icons.phone, parentphnoController),
                        buildTextField("Aadhar Number", Icons.credit_card, aadharController),
                        buildTextField("Placement Willingness", Icons.work, placementwillingController),
                        buildTextField("Batch", Icons.date_range, batchController),
                        buildTextField("Current Semester", Icons.date_range, currentsemController),
                        buildTextField("CGPA", Icons.date_range, cgpaController),
                        buildTextField("Standing Arrears", Icons.date_range, standingArrearController),
                        buildTextField("History of Arrears", Icons.date_range, historyOfArrearController),
                        buildTextField("Semester 1 GPA", Icons.score, sem1gpaController),
                        buildTextField("Semester 2 GPA", Icons.score, sem2gpaController),
                        buildTextField("Semester 3 GPA", Icons.score, sem3gpaController),
                        buildTextField("Semester 4 GPA", Icons.score, sem4gpaController),
                        buildTextField("Semester 5 GPA", Icons.score, sem5gpaController),
                        buildTextField("Semester 6 GPA", Icons.score, sem6gpaController),
                        buildTextField("Semester 7 GPA", Icons.score, sem7gpaController),
                        buildTextField("Semester 8 GPA", Icons.score, sem8gpaController),

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