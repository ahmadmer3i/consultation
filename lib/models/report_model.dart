import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  String? reportDetails;
  String? seekerId;
  String? providerId;
  int? status;
  String? reportId;
  Timestamp? reportDate;
  String? reason;

  ReportModel.fromDatabase(Map<String, dynamic> json) {
    reportDetails = json["reportDetails"];
    seekerId = json["seekerId"];
    providerId = json["providerId"];
    status = json["status"];
    reportId = json["reportId"];
    reportDate = json["reportDate"];
    reason = json["reason"];
  }
}
