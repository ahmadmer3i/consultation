import 'package:cloud_firestore/cloud_firestore.dart';

class MessageData {
  String senderId = '';
  String receiverId = '';
  Timestamp dateTime = Timestamp.fromDate(DateTime.now());
  String message = '';

  MessageData({
    required this.message,
    required this.dateTime,
    required this.receiverId,
    required this.senderId,
  });

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "date": dateTime,
      "message": message,
    };
  }
}
