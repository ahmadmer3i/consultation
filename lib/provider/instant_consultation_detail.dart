import 'package:consultation/Components.dart';
import 'package:consultation/Provider/seeker_profile.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/models/seeker_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InstantConsultationDetail extends StatefulWidget {
  final ConsultData consultData;
  final SeekerData seekerData;
  final Map data;
  const InstantConsultationDetail({
    Key? key,
    required this.consultData,
    required this.seekerData,
    required this.data,
  }) : super(key: key);

  @override
  _InstantConsultationDetailState createState() =>
      _InstantConsultationDetailState();
}

class _InstantConsultationDetailState extends State<InstantConsultationDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xffFFE8D6),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SeekerProfile(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      const CircleAvatar(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.seekerData.name!,
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: const Color(0xffCB997E),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.consultData.topic,
                  style: Theme.of(context).textTheme.button!.copyWith(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat.yMMMd('ar')
                          .format(widget.consultData.date.toDate()),
                      style: Theme.of(context).textTheme.button!.copyWith(),
                    ),
                    Text(
                      DateFormat.jm('ar').format(
                        widget.consultData.date.toDate(),
                      ),
                      style: Theme.of(context).textTheme.button!.copyWith(),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "التفاصيل:",
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: const Color(0xffCB997E),
                        ),
                  ),
                ),
                Text(
                  widget.consultData.detail,
                  style: Theme.of(context).textTheme.button!.copyWith(),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: widget.consultData.providerId !=
                          FirebaseAuth.instance.currentUser!.uid &&
                      widget.data["isSent"] == false
                  ? ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: (context) => MyOfferBottomSheet(
                            docId: widget.consultData.docId,
                            data: widget.data,
                          ),
                        );
                      },
                      child: const Text(
                        "قبول العرض",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyProviderBottomNavigationBar(),
    );
  }
}
