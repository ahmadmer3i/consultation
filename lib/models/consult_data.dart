import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultData {
  String uid;
  String topic;
  String detail;
  Timestamp date;
  String docId;
  bool isDeleted;
  ConsultData({
    required this.uid,
    required this.topic,
    required this.detail,
    required this.date,
    required this.docId,
    this.isDeleted = false,
  });
}
