import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultData {
  String uid;
  String topic;
  String detail;
  Timestamp date;
  ConsultData({
    required this.uid,
    required this.topic,
    required this.detail,
    required this.date,
  });
}
