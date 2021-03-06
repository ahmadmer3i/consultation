import 'package:consultation/Provider/calendar_management.dart';
import 'package:consultation/Provider/view_my_profile.dart';
import 'package:consultation/components.dart';
import 'package:consultation/provider/provider_reports.dart';
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
      appBar: MyAppBar(
        autoLeading: false,
      ),
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
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ViewMyProfile(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffFFE8D6),
                ),
                height: 50,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Icon(
                        Icons.person_outlined,
                        size: 30,
                        color: Color(0xff6B705C),
                      ),
                    ),
                    Text(
                      "???????? ????????????",
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CalendarManagement(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffFFE8D6),
                ),
                height: 50,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Icon(
                        Icons.calendar_today,
                        size: 30,
                        color: Color(0xff6B705C),
                      ),
                    ),
                    Text(
                      "?????????? ?????????????? ",
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProviderReports()));
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
                      ),
                    ),
                    Text(
                      "?????????????? ",
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
                  color: const Color(0xffFFE8D6),
                ),
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
                        },
                      ),
                    ),
                    Text(
                      "????????",
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
