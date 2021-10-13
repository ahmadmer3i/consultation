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
  String? providerId;
  String consultId;
  bool isActive;
  List<ProviderConsult> providers;
  ConsultData({
    required this.isActive,
    required this.uid,
    required this.topic,
    required this.detail,
    required this.date,
    required this.docId,
    this.providerId,
    this.isDeleted = false,
    required this.status,
    required this.price,
    required this.providers,
    required this.isPaid,
    required this.payment,
    required this.consultId,
  });
}

class ProviderConsult {
  String? consultId;
  bool? isApproved;
  bool? isSent;
  double? price;
  String? status;

  ProviderConsult.fromJson(Map<String, dynamic> json) {
    consultId = json["consultId"];
    isApproved = json["isApproved"];
    isSent = json["isSent"];
    price = double.tryParse(json["price"].toString());
    status = json["status"];
  }
  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'isApproved': isApproved,
      'isSent': isSent,
      'consultId': consultId,
      'status': status,
    };
  }
}
