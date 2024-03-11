import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sit_placement_app/backend/requests/job_application_request.dart';

import '../../backend/models/applied_job_model.dart';
import '../../backend/requests/staff_request.dart';

class JobAppliedListPage extends StatefulWidget {
  final token;

  const JobAppliedListPage({super.key, required this.token});

  @override
  _JobAppliedListPageState createState() => _JobAppliedListPageState();
}

class _JobAppliedListPageState extends State<JobAppliedListPage> {
  List<JobAppliedModel> jobAppliedStudents = [];
  String department = "";

  List<StudentAppliedPermit> studentApplication = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    await initData();
  }

  Future<void> initData() async {

    // getting department of staff
    department = await StaffRequest.getStaffDept(widget.token);

    // getting all job applications
    List<JobAppliedModel>? allJobApplications =
        await JobApplicationRequest.findAll(widget.token);

    // filtering applications based on department and status code
    List<JobAppliedModel>? filteredApplications =
        allJobApplications.where((application) {
      return application.student.department == department &&
          application.status.statusId == 1;
    }).toList();


    setState(() {
      jobAppliedStudents = filteredApplications;
      for (var application in jobAppliedStudents) {
        studentApplication.add(StudentAppliedPermit(jobApplication: application));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          'Job Applied List',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Icon(
                            Icons.work,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          studentApplication[index]
                              .jobApplication
                              .student
                              .studentName,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Applied to: ${studentApplication[index].jobApplication.jobPost.companyName}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        trailing: Checkbox(
                          value: studentApplication[index].isApproved,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              studentApplication[index].isApproved = value!;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemCount: studentApplication.length,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: ElevatedButton.icon(
                  onPressed: isAnyStudentSelected()
                      ? () => showApprovalMessage(context)
                      : null,
                  icon: Icon(
                    Icons.check,
                    size: 24,
                  ),
                  label: Text(
                    'Approve Selected',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isAnyStudentSelected() {
    return studentApplication.any((student) => student.isApproved);
  }

  void showApprovalMessage(BuildContext context) async {
    String msg = 'Selected students approved successfully!';
    IconData iconToSet = Icons.check_circle;
    MaterialColor clr = Colors.green;

    List<JobAppliedModel> selectedApplications = studentApplication
        .where((student) => student.isApproved)
        .map((student) => student.jobApplication)
        .toList();

    bool approvalResult = await StaffRequest.approveAppliedStudents(
        widget.token, selectedApplications);

    if (!approvalResult) {
      msg = 'Student Approval failed';
      iconToSet = Icons.cancel;
      clr = Colors.red;
    }

    // Create a GlobalKey for the overlay
    GlobalKey<State> overlayKey = GlobalKey<State>();

    // Show overlay
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        bottom: 0.0,
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Delay for 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      // Remove overlay after delay
      overlayEntry.remove();

      // Show success message
      showDialog(
        context: context,
        builder: (context) => Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    iconToSet,
                    color: clr,
                    size: 50,
                  ),
                  SizedBox(height: 16),
                  Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Done"))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class StudentAppliedPermit {
  final JobAppliedModel jobApplication;
  bool isApproved;

  StudentAppliedPermit({required this.jobApplication, this.isApproved = true});
}