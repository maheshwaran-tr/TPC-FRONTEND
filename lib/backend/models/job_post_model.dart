// To parse this JSON data, do
//
//     final jobPostModel = jobPostModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

JobPostModel jobPostModelFromJson(String str) => JobPostModel.fromJson(json.decode(str));

String jobPostModelToJson(JobPostModel data) => json.encode(data.toJson());

class JobPostModel {
  final dynamic createdAt;
  final dynamic lastModifiedAt;
  final int jobId;
  final String companyName;
  final String companyDetails;
  final String requiredSkills;
  final String historyOfArrears;
  final String jobName;
  final String jobDescription;
  final String campusMode;
  final double eligible10ThMark;
  final double eligible12ThMark;
  final double eligibleCgpaMark;
  final String venue;
  final String interviewDate;
  final String interviewTime;

  JobPostModel({
    this.createdAt,
    this.lastModifiedAt,
    required this.jobId,
    required this.companyName,
    required this.companyDetails,
    required this.requiredSkills,
    required this.historyOfArrears,
    required this.jobName,
    required this.jobDescription,
    required this.campusMode,
    required this.eligible10ThMark,
    required this.eligible12ThMark,
    required this.eligibleCgpaMark,
    required this.venue,
    required this.interviewDate,
    required this.interviewTime,
  });

  factory JobPostModel.fromJson(Map<String, dynamic> json) => JobPostModel(
    createdAt: json["createdAt"],
    lastModifiedAt: json["lastModifiedAt"],
    jobId: json["jobId"],
    companyName: json["companyName"],
    companyDetails: json["companyDetails"],
    requiredSkills: json["requiredSkills"],
    historyOfArrears: json["historyOfArrears"],
    jobName: json["jobName"],
    jobDescription: json["jobDescription"],
    campusMode: json["campusMode"],
    eligible10ThMark: json["eligible10thMark"],
    eligible12ThMark: json["eligible12thMark"],
    eligibleCgpaMark: json["eligibleCGPAMark"],
    venue: json["venue"],
    interviewDate: json["interviewDate"],
    interviewTime: json["interviewTime"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "lastModifiedAt": lastModifiedAt,
    "jobId": jobId,
    "companyName": companyName,
    "companyDetails": companyDetails,
    "requiredSkills": requiredSkills,
    "historyOfArrears": historyOfArrears,
    "jobName": jobName,
    "jobDescription": jobDescription,
    "campusMode": campusMode,
    "eligible10thMark": eligible10ThMark,
    "eligible12thMark": eligible12ThMark,
    "eligibleCGPAMark": eligibleCgpaMark,
    "venue": venue,
    "interviewDate": interviewDate,
    "interviewTime": interviewTime,
  };
}
