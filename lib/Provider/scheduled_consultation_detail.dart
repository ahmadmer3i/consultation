import 'package:consultation/Components.dart';
import 'package:consultation/Provider/provider_chat_open.dart';
import 'package:consultation/Provider/seeker_profile.dart';
import 'package:flutter/material.dart';

class ScheduledConsultationDetail extends StatefulWidget {
  const ScheduledConsultationDetail({Key? key}) : super(key: key);

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
                          "خالد عبدالله",
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: const Color(0xffCB997E)),
                        ),
                      )
                    ],
                  ),
                ),
                Text("تصميم غرافيك",
                    style: Theme.of(context).textTheme.button!.copyWith()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("17  سبتمبر 2021",
                        style: Theme.of(context).textTheme.button!.copyWith()),
                    Text("6:00 - 8:00 مساء  ",
                        style: Theme.of(context).textTheme.button!.copyWith()),
                  ],
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(":تفاصيل",
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: const Color(0xffCB997E)))),
                Text(
                    "عاجل تصميم شعار لمشروع تجاري في مجال الموضة حيث سيتم تطوي الهوية بعد نجاح المشروع سيكون شعارًا مميزًا ورسميًا يعكس جودة صناعتنا ويجذب المشتري لزيادة المبيعات",
                    style: Theme.of(context).textTheme.button!.copyWith()),
              ],
            ),
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProviderChatOpen()));
                    },
                    child: const Text(
                      "قبول العرض",
                      style: TextStyle(color: Colors.white),
                    )))
          ],
        ),
      ),
      bottomNavigationBar: const MyProviderBottomNavigationBar(),
    );
  }
}
