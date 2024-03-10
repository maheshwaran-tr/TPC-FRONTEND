import 'package:flutter/material.dart';

import '../../../backend/models/staff_model.dart';
import '../../../backend/models/student_model.dart';
import '../../backend/requests/staff_request.dart';
import '../../backend/requests/student_request.dart';

class StudentApprovalClass {
  Student theStudent;
  bool isApproved;

  StudentApprovalClass({
    required this.theStudent,
    this.isApproved = true,
  });
}

Future<String> getStaffDept(String token) async {
  Staff staff = await StaffRequest.getStaffProfile(token);
  return staff.department;
}

class ApprovalPage extends StatefulWidget {
  final token;

  const ApprovalPage({super.key, required this.token});

  @override
  _ApprovalPageState createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  Map<String, String> studentsWithApprovalStatus = {};
  List<StudentApprovalClass> students = [];
  String? staffDept;

  String selectedSection = 'All';
  int selectedBatch = 0;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Load students data when the widget is initialized
    _loadStaffDept();
  }

  void _loadStaffDept() async {
    try {
      staffDept = await getStaffDept(widget.token);
      print(staffDept);
      // If staffDept is not null, load students data
      if (staffDept != null) {
        _loadStudentsData();
      } else {
        print("Error: Staff department is null.");
      }
    } catch (e) {
      print("Error loading staff department: $e");
    }
  }

  Future<void> _loadStudentsData() async {
    try {
      // Replace 'your_token' and 'your_department' with the actual values
      print(widget.token);
      print(staffDept);

      List<Student>? allStudents = await StudentRequest.getAllStudents(widget.token);
      List<Student> fetchedStudents = allStudents!.where((student) => student.department == staffDept).toList();

      // Populate the map with students' roll numbers and default approval status
      studentsWithApprovalStatus = Map.fromIterable(
        fetchedStudents,
        key: (student) => student.rollNo!,
        value: (student) => student.placementWilling == "yes" ? "yes" : "no",
      );

      setState(() {
        students = fetchedStudents
            .map((student) => StudentApprovalClass(
          theStudent: student,
          isApproved: student.placementWilling == "yes",
        ))
            .toList();
      });
    } catch (e) {
      print("Error loading students data: $e");
    }
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    await _loadStudentsData();
  }


  @override
  Widget build(BuildContext context) {
    List<StudentApprovalClass> filteredStudents = students
        .where((student) =>
    (selectedSection == 'All' ||
        student.theStudent.section == selectedSection) &&
        (selectedBatch == 0 || student.theStudent.batch == selectedBatch) &&
        (searchQuery.isEmpty ||
            student.theStudent.studentName!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())))
        .toList();

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        hintColor: Colors.amberAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
          title: Text(
            'Student List',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Column(
            children: [
              _buildEnhancedContainer(),
              _buildSearchBar(),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredStudents.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: ListTile(
                        leading: Checkbox(
                          value: filteredStudents[index].isApproved,
                          onChanged: (value) {
                            setState(() {
                              filteredStudents[index].isApproved = value!;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                        title: Text(
                            filteredStudents[index].theStudent.studentName ??
                                "N/A"),
                        subtitle: Text(
                            'Section: ${filteredStudents[index].theStudent.section} - Batch: ${filteredStudents[index].theStudent.batch}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit,
                                  color: Theme.of(context).hintColor),
                              onPressed: () {
                                _editStudentDetails(filteredStudents[index]);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.visibility,
                                  color: Theme.of(context).hintColor),
                              onPressed: () {
                                _viewStudentDetails(filteredStudents[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedContainer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDropdownButton(selectedSection, ['All', 'A', 'B', 'C'],
                  (String? newValue) {
                setState(() {
                  selectedSection = newValue!;
                });
              }),
          _buildDropdownButton<int>(selectedBatch, [0, 2023, 2024, 2025, 2026],
                  (int? newValue) {
                setState(() {
                  selectedBatch = newValue!;
                });
              }),
          ElevatedButton(
            onPressed: () {
              _showApprovalDialog(context);
            },
            child: Text(
              'Approve',
              style: TextStyle(fontSize: 16.0),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).hintColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownButton<T>(
      T value, List<T> items, ValueChanged<T?> onChanged) {
    return DropdownButton<T>(
      value: value,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            item.toString(),
            style: TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      style: TextStyle(color: Colors.white),
      dropdownColor: Theme.of(context).primaryColor,
      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
      color: Colors.transparent,
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          hintText: 'Search by name...',
          hintStyle: TextStyle(color: Colors.blueGrey),
          prefixIcon: Icon(Icons.search, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> _showApprovalDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Processing...',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10.0),
              Text(
                'Approving students',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          backgroundColor: Colors.white,
        );
      },
    );

    // Simulate a 2-second delay for processing (replace with your actual approval logic)
    await Future.delayed(Duration(seconds: 2), () async {
      // Update the approval status in the map
      setState(() {
        studentsWithApprovalStatus.forEach((rollNo, _) {
          StudentApprovalClass student =
          students.firstWhere((s) => s.theStudent.rollNo == rollNo);
          studentsWithApprovalStatus[rollNo] =
          student.isApproved ? "yes" : "no";
        });
      });

      // You can perform any additional logic here after the approval is done
      // For example, you can call an API to update the approval status on the server
      // Replace 'your_approval_api' with the actual API endpoint
      // await YourApi.updateApprovalStatus(studentsWithApprovalStatus);
      bool res = await StudentRequest.updatePlacementWilling(widget.token, studentsWithApprovalStatus);
      if(res == true){
        Navigator.of(context).pop(); // Close the dialog after 2 seconds
        _showSuccessDialog(context,true);
      }else{
        _showSuccessDialog(context,false);
      }
      // Optionally, show a success dialog after approval
    });
  }

  void _showSuccessDialog(BuildContext context,bool res) {

    String title = "";
    String msg = "";
    if(res){
      title = 'Approval Successful';
      msg = 'Students have been approved successfully!';
    }else{
      title = 'Approval Failed';
      msg = 'Students Approval Failed';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50.0,
              ),
              SizedBox(height: 10.0),
              Text(
                msg,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.lightBlue,
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          backgroundColor: Colors.white,
        );
      },
    );
  }

  void _editStudentDetails(StudentApprovalClass student) {
    print('Editing details for ${student.theStudent.studentName}');
  }

  void _viewStudentDetails(StudentApprovalClass student) {
    print('Viewing details for ${student.theStudent.studentName}');
  }
}