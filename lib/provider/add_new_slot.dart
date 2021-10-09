import 'package:consultation/components.dart';
import 'package:flutter/material.dart';

class AddNewSlot extends StatefulWidget {
  const AddNewSlot({Key? key}) : super(key: key);

  @override
  _AddNewSlotState createState() => _AddNewSlotState();
}

class _AddNewSlotState extends State<AddNewSlot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  "إضافة وقت جديد",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: const Color(0xffCB997E)),
                )),
            Container(
                padding: const EdgeInsets.all(10),
                child: MyTextFieldDark(
                  label: "تاريخ",
                  iconButton: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101),
                      );
                    },
                  ),
                )),
            Container(
                padding: const EdgeInsets.all(10),
                child: MyTextFieldDark(
                  label: "الوقت",
                  iconButton: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () {
                      showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                    },
                  ),
                )),
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "إضافة",
                  style: TextStyle(color: Color(0xffFFE8D6)),
                ))
          ],
        ),
      ),
      bottomNavigationBar: const MyProviderBottomNavigationBar(),
    );
  }
}