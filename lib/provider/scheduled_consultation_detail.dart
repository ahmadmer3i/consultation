import 'package:consultation/Components.dart';
import 'package:consultation/Provider/provider_chat_open.dart';
import 'package:consultation/Provider/seeker_profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduledConsultationDetail extends StatefulWidget {
  final String name;
  final String details;
  final String topic;
  final String time;
  final DateTime date;
  final String seekerId;

  const ScheduledConsultationDetail({
    Key? key,
    required this.name,
    required this.details,
    required this.topic,
    required this.time,
    required this.date,
    required this.seekerId,
  }) : super(key: key);

  @override
  _ScheduledConsultationDetailState createState() =>
      _ScheduledConsultationDetailState();
}

class _ScheduledConsultationDetailState
    extends State<ScheduledConsultationDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color(0xffFFE8D6),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SeekerProfile()));
                  },
                  child: Row(
                    children: [
                      const CircleAvatar(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.name,
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: const Color(0xffCB997E)),
                        ),
                      )
                    ],
                  ),
                ),
                Text(widget.topic,
                    style: Theme.of(context).textTheme.button!.copyWith()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat.yMMMd('ar').format(widget.date),
                        style: Theme.of(context).textTheme.button!.copyWith()),
                    Text(widget.time,
                        style: Theme.of(context).textTheme.button!.copyWith()),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    ":تفاصيل",
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: const Color(0xffCB997E),
                        ),
                  ),
                ),
                Text(
                  widget.details,
                  style: Theme.of(context).textTheme.button!.copyWith(),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProviderChatOpen(
                        consultId: "",
                        seekerId: "",
                        providerId: "",
                      ),
                    ),
                  );
                },
                child: const Text(
                  "قبول العرض",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyProviderBottomNavigationBar(),
    );
  }
}
