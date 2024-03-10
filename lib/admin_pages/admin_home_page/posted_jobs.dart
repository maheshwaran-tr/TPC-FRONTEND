import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sit_placement_app/ExcelService/student_excel_service/student_details_excel.dart';
import 'package:sit_placement_app/admin_pages/admin_home_page/update_job.dart';
import 'package:sit_placement_app/admin_pages/admin_home_page/view_job_details.dart';
import 'package:sit_placement_app/backend/requests/job_request.dart';

import '../../backend/models/job_post_model.dart';

class PostedJobsListPage extends StatefulWidget {
  final token;

  PostedJobsListPage({
    required this.token,
  });

  @override
  _PostedJobsListPageState createState() => _PostedJobsListPageState();
}

class _PostedJobsListPageState extends State<PostedJobsListPage> {
  List<JobPostModel> jobsList = [];
  List<JobPostModel> filteredJobsList = [];
  String searchText = '';
  var isLoaded = true;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    List<JobPostModel> tempJobsList = await JobRequest.getAllJobs(widget.token);
    setState(() {
      jobsList = tempJobsList;
      filteredJobsList = jobsList;
    });
  }

  void filterStudents() {
    setState(() {
      filteredJobsList = List.from(jobsList);

      if (searchText.isNotEmpty) {
        filteredJobsList = filteredJobsList.where((job) {
          return job.companyName!
              .toLowerCase()
              .contains(searchText.toLowerCase());
        }).toList();
      }
    });
  }

  void downloadData() async {
    // Implement download functionality here...
    // await StudentExcelService.createExcelFile(jobsList,"STUDENT-LIST");
  }

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
            'Posted Jobs',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: downloadData,
              icon: Icon(
                Icons.download,
                size: 24,
                color: Colors.black,
              ),
            ),
          ],
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            margin: EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                  filterStudents();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by company name',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            searchText = '';
                            filterStudents();
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredJobsList.length,
              itemBuilder: (context, index) {
                final job = filteredJobsList[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Company: ${job.companyName}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    // Handle edit action
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateJobPage(
                                                  token: widget.token,
                                                  job: job,
                                                )));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    // Handle delete action
                                    bool isDeleted = await JobRequest.deleteJob(
                                        widget.token, job.jobId);
                                    if (isDeleted) {
                                      print("DELETED");
                                    } else {
                                      print("ERROR DELETING");
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.visibility),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JobDetailsPage(
                                          job: job,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text('Job Role: ${job.jobName}',
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ]));
  }
}
