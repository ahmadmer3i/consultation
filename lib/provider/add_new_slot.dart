import 'package:consultation/components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewSlot extends StatefulWidget {
  const AddNewSlot({Key? key}) : super(key: key);

  @override
  _AddNewSlotState createState() => _AddNewSlotState();
}

class _AddNewSlotState extends State<AddNewSlot> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
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
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: MyTextFieldDark(
                textController: dateController,
                isReadOnly: true,
                label: "تاريخ",
                iconButton: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    ).then((value) {
                      print(value);
                      setState(() {
                        dateController.text = value != null
                            ? DateFormat.yMMMd('ar').format(value)
                            : "";
                        print(dateController.text);
                      });
                    });
                  },
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(10),
                child: MyTextFieldDark(
                  textController: timeController,
                  isReadOnly: true,
                  label: "الوقت",
                  iconButton: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () async {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then(
                        (value) {
                          setState(
                            () {
                              timeController.text = value != null
                                  ? DateFormat.jm('ar').format(
                                      DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day,
                                          value.hour,
                                          value.minute),
                                    )
                                  : "";
                            },
                          );
                        },
                      );
                    },
                  ),
                )),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "إضافة",
                style: TextStyle(color: Color(0xffFFE8D6)),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MyProviderBottomNavigationBar(),
    );
  }
}
