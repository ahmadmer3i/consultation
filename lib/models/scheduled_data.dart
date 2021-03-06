import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduledData {
  Timestamp? scheduledDate;
  double? payment;
  String? scheduledDetails;
  List<dynamic>? scheduledTimes;
  String? seekerId;
  String? providerId;
  String? topic;
  String? scheduledId;
  bool? isApproved;
  bool? isOpened;

  ScheduledData.fromDatabase(Map<String, dynamic> json) {
    scheduledDate = json["scheduledDate"];
    payment = double.parse(json["payment"].toString());
    scheduledDetails = json["scheduledDetails"];
    scheduledTimes = json["scheduledTime"];
    seekerId = json["seekerId"];
    providerId = json["providerId"];
    topic = json["topic"];
    scheduledId = json["scheduledId"];
    isApproved = json["isApproved"] ?? false;
    isOpened = json["isOpened"] ?? false;
  }
}
