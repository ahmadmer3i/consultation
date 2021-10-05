import 'package:consultation/Provider/calendar_management.dart';
import 'package:consultation/Provider/provider_edit_profile.dart';
import 'package:consultation/Seeker/seeker_reports.dart';
import 'package:consultation/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProviderProfile extends StatefulWidget {
  const ProviderProfile({Key? key}) : super(key: key);

  @override
  _ProviderProfileState createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(20),
                child: const Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 70,
                    ))),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProviderProfileEdit(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFFE8D6)),
                height: 50,
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Icon(
                          Icons.person_outlined,
                          size: 30,
                          color: Color(0xff6B705C),
                        )),
                    Text(
                      "ملفي الشخصي",
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CalendarManagement()));
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFFE8D6)),
                height: 50,
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Icon(
                          Icons.calendar_today,
                          size: 30,
                          color: Color(0xff6B705C),
                        )),
                    Text(
                      "إدارة التقويم ",
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SeekerReports()));
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFFE8D6)),
                height: 50,
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Icon(
                          Icons.report_outlined,
                          size: 30,
                          color: Color(0xff6B705C),
                        )),
                    Text(
                      "بلاغاتي ",
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/LoginSeeker', (route) => route.isFirst);
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFFE8D6)),
                height: 50,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                          icon: const Icon(
                            Icons.logout_outlined,
                            size: 30,
                            color: Color(0xff6B705C),
                          ),
                          onPressed: () {
                            instance.signOut();
                          }),
                    ),
                    Text(
                      "خروج",
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MyProviderBottomNavigationBar(),
    );
  }
}
