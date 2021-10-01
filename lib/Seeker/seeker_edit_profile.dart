import 'package:consultation/Components.dart';
import 'package:consultation/Provider/provider_registration_one.dart';
import 'package:consultation/Provider/provider_registration_one.dart';
import 'package:flutter/material.dart';

class SeekerProfileEdit extends StatefulWidget {
  const SeekerProfileEdit({ Key? key }) : super(key: key);

  @override
  SeekerProfileEditState createState() => SeekerProfileEditState();
}

class SeekerProfileEditState extends State<SeekerProfileEdit> {
  int selectedGender=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "تحديث الملف",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Color(0xffCB997E)),
                  )),
                  Container(margin: EdgeInsets.only(bottom: 10),child: MyTextFieldDark(label: "الاسم بالكامل*")),
                  Container(margin: EdgeInsets.only(bottom: 10),child: MyTextFieldDark(label: "البريد الإلكتروني*")),
                  Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "جنس*",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: Colors.black,
                                      ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: DropdownButton(
                                hint: Text(
                                  "جنس*",
                                  style: TextStyle(color: Color(0xffFFE8D6),decoration: TextDecoration.none),
                                ),
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                                focusColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                value: selectedGender,
                                dropdownColor: Colors.white,
                                isExpanded: true,
                                items: const [
                                  DropdownMenuItem(
                                      value: 0,
                                      child: Text(
                                        "ذكر",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  DropdownMenuItem(
                                      value: 1,
                                      child: Text(
                                        "أنثى",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                ]),
                          ),
                  Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: MyTextFieldDark(
                                label: "تاريخ الميلاد*",
                                iconButton: IconButton(
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2015, 8),
                                      lastDate: DateTime(2101),
                                    );
                                  },
                                  icon: Icon(Icons.calendar_today,
                                      color: Colors.black),
                                ),
                              )),
                              Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: MyTextFieldDark(
                                isOsbcure: true,
                                minHeight: 1,
                                maxLines: 1,
                                label: "كلمة المرور",
                                iconButton: IconButton(
                                  onPressed: () {
                                    
                                  },
                                  icon: Icon(Icons.remove_red_eye,
                                      ),
                                ),
                              )),
                              Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: MyTextFieldDark(
                                isOsbcure: true,
                                minHeight: 1,
                                maxLines: 1,
                                label: "تأكيد كلمة المرور*",
                                iconButton: IconButton(
                                  onPressed: () {
                                    
                                  },
                                  icon: Icon(Icons.remove_red_eye,
                                      ),
                                ),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProviderRegisterationOne()));
                              },
                              child: Text(
                                "تحديث",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Color(0xffFFE8D6)),
                              )),
        
                  
            ],
          ),
        ),
        ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}