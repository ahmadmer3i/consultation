import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultData {
  String uid;
  String topic;
  String detail;
  Timestamp date;
  String docId;
  bool isDeleted;
  String status;
  String payment;
  bool isPaid;
  double price;
  String providerId;
  ConsultData({
    required this.uid,
    required this.topic,
    required this.detail,
    required this.date,
    required this.docId,
    this.isDeleted = false,
    required this.status,
    required this.price,
    required this.providerId,
    required this.isPaid,
    required this.payment,
  });
}
