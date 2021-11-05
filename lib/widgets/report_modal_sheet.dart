import 'package:consultation/seeker/seeker_send_report.dart';
import 'package:flutter/material.dart';

void reportModalSheet(context,
    {required String userId,
    required String reportCollection,
    required String sender,
    required String receiver}) {
  showModalBottomSheet(
    isDismissible: false,
    context: context,
    builder: (context) {
      return Container(
        height: 200,
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 120,
                    vertical: 10,
                  ),
                ),
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                elevation: MaterialStateProperty.all<double>(0),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SeekerSendReportScreen(
                      receiver: receiver,
                      sender: sender,
                      reportCollection: reportCollection,
                      userId: userId,
                    ),
                  ),
                );
              },
              child: const Text(
                "رفع البلاغ",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 120,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                  ),
                  primary: Colors.white,
                  backgroundColor: const Color(0xFF6B705C)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "تراجع",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      );
    },
  );
}
