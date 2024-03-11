class Urls {

    // static const baseurl = "http://52.62.210.139/sit";  // LIVE
  static const baseurl = "http://10.0.2.2:7070/sit";    // TEST
  // static const baseurl = "http://192.168.0.13:7070/sit";    // TEST


  // Auth Urls
  static const String loginUser = "$baseurl/auth/login";
  static const String registerUser = "$baseurl/auth/register";
  static const String logoutUser = "$baseurl/auth/logout";
  static const String refreshToken = "$baseurl/auth/refresh-token";

  // Student Urls
  static const String allStudents = "$baseurl/students/all";
  static const String addStudents = "$baseurl/students/add";
  static const String updateStudents = "$baseurl/students/update";
  static const String deleteStudents = "$baseurl/students/delete";
  static const String studentByToken = "$baseurl/students/profile";
  static const String studentsByDept = "$baseurl/students/dept";
  static const String studentsByPlacementWilling = "$baseurl/students/get-placement-willing-list";
  static const String applyJob = "$baseurl/students/apply-job";
  static const String updatePlacementWilling = "$baseurl/students/update-placement-willing";
  static const String appliedJobsByStudent = "$baseurl/students/get-applied-jobs";

  // Staff Urls
  static const String allStaffs = "$baseurl/staffs/all";
  static const String addStaffs = "$baseurl/staffs/add";
  static const String updateStaffs = "$baseurl/staffs/update";
  static const String deleteStaffs = "$baseurl/staffs/delete";
  static const String staffByToken = "$baseurl/staffs/profile";
  static const String studentsByDeptAndStatus = "$baseurl/staffs/get-student-by-dept-sts";
  static const String approveAppliedStudents = "$baseurl/staffs/approve-applied-students";


  // Job Urls
  static const String allJobs = "$baseurl/jobs/all";
  static const String addJobs = "$baseurl/jobs/add";
  static const String updateJobs = "$baseurl/jobs/update";
  static const String deleteJobs = "$baseurl/jobs/delete";

  // Admin Urls
  static const String getApprovedStudentsAdmin = "$baseurl/admin/get-student-by-dept-sts";
  static const String getAllApplications = "$baseurl/admin/get-all-applications";

  // Image Urls
  static const String uploadImage = "$baseurl/images/upload-img";
  static const String getImageByUsername = "$baseurl/images/img";

  // Job Application Urls
  static const String findAllJobApplications = "$baseurl/applications/all";
}
