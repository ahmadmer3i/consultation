import 'package:consultation/components.dart';
import 'package:flutter/material.dart';

class SeekerNotification extends StatefulWidget {
  const SeekerNotification({Key? key}) : super(key: key);

  @override
  _SeekerNotificationState createState() => _SeekerNotificationState();
}

class _SeekerNotificationState extends State<SeekerNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                "إشعارات",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: const Color(0xffCB997E)),
              )),
          Expanded(
              child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'تمت الموافقة على طلبك للحصول على استشارة مجدولة لـ "تصميم الجرافيك" مع "خالد عبد الله" للفتحة "17 سبتمبر 2021 - 12:00 - 2:00 ظهرًا"',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(height: 1.2),
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(' 16 سبتمبر 2021 - 12:03 مساءً')),
                  ],
                ),
                decoration: BoxDecoration(
                    color: const Color(0xffFFE8D6),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'لديك عرض جديد لطلب الاستشارة الفورية الخاص بك.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(height: 1.2),
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(' 16 سبتمبر 2021 - 12:03 مساءً')),
                  ],
                ),
                decoration: BoxDecoration(
                    color: const Color(0xffFFE8D6),
                    borderRadius: BorderRadius.circular(10)),
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        selectedIndex: 2,
      ),
    );
  }
}