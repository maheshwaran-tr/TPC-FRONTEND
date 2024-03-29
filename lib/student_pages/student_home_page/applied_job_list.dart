import 'package:flutter/material.dart';
import 'package:sit_placement_app/backend/models/applied_job_model.dart';
import 'package:sit_placement_app/backend/requests/job_request.dart';

import '../../backend/models/student_model.dart';
import 'new_upload_status.dart';

class StudentJobApplicationList extends StatefulWidget {

  final token;
  final Student student;

  const StudentJobApplicationList({super.key,required this.token,required this.student});

  @override
  State<StudentJobApplicationList> createState() => _StudentJobApplicationListState();
}

class _StudentJobApplicationListState extends State<StudentJobApplicationList> {
  List<JobAppliedModel>? jobApplications = [];
  List<String> jobNames = [];
  String searchText = '';
  var isLoaded = true;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    List<JobAppliedModel>? applicationList = await JobRequest.getAllApplications(widget.token);
    applicationList = applicationList.where((app)=>app.student.rollNo == widget.student.rollNo).toList();

    setState(() {
      for(var obj in applicationList!){
        jobNames.add(obj.jobPost.companyName);
      }
      jobApplications = applicationList;
    });
  }

  void filterStudentsByJobs(String selectedCompany) {
    final List<JobAppliedModel> thisJobAppliedStudents = jobApplications!
        .where((ja) => ja.jobPost.companyName == selectedCompany)
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadJobStatus(
          theJob: thisJobAppliedStudents[0],
          token: widget.token,
        ),
      ),
    );
  }

  List<String> getFilteredJobs() {
    if (searchText.isEmpty) {
      return jobNames;
    } else {
      return jobNames
          .where(
              (jobname) => jobname!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF536DFE), Color(0xFF1E88E5)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.white,

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 60, 24, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Jobs',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.grey[600]),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        searchText = value;
                                      });
                                    },
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: 'Search Jobs...',
                                      hintStyle:
                                      TextStyle(color: Colors.grey[600]),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: getFilteredJobs().length,
                        itemBuilder: (context, index) {
                          final department = getFilteredJobs()[index];
                          return GestureDetector(
                            onTap: () {
                              filterStudentsByJobs(department!);
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      department!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_ios, size: 18),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



}
