import 'package:consultation/Components.dart';
import 'package:consultation/Provider/provider_registration_one.dart';
import 'package:flutter/material.dart';

class ProviderProfileEdit extends StatefulWidget {
  const ProviderProfileEdit({Key? key}) : super(key: key);

  @override
  ProviderProfileEditState createState() => ProviderProfileEditState();
}

class ProviderProfileEditState extends State<ProviderProfileEdit> {
  int selectedGender = 0;
  bool instant=true;
  bool scheduled=true;
  int selectedBank=0;
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
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: MyTextFieldDark(label: "الاسم بالكامل*")),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: MyTextFieldDark(label: "البريد الإلكتروني*")),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "جنس*",
                  style: Theme.of(context).textTheme.caption!.copyWith(
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
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: DropdownButton(
                    hint: Text(
                      "جنس*",
                      style: TextStyle(
                          color: Color(0xffFFE8D6),
                          decoration: TextDecoration.none),
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
                      icon: Icon(Icons.calendar_today, color: Colors.black),
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.remove_red_eye,
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.remove_red_eye,
                      ),
                    ),
                  )),
              MyTextFieldDark(
                label: "تكلم لنا عن خبراتك*",
                showHint: false,
                minHeight: 6,
                maxLength: 400,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "الشهادات*",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.all(2),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                         
                        ),
                      child: Stack(children: [
                        Image.network("https://picsum.photos/200"),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: CircleBorder(),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.all(2),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                         color: Colors.black87,
                        ),
                       
                      
                      
                      child: IconButton(icon:Icon(Icons.add,color: Colors.white,),onPressed: (){},)
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "مجالات الأستشارة *",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              CategoriesSelector(),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "نوع الاستشارة*",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                              Row(children: [
                                Text("فوري"),
                                Checkbox(value: instant, onChanged: (value){setState(() {
                                  instant=value!;
                                });})
                              ],),Row(children: [
                                Text("المقرر"),
                                Checkbox(value: scheduled, onChanged: (value){setState(() {
                                  scheduled=value!;
                                });})
                              ],)
                            ],),
              ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: MyTextFieldDark(label: "رسوم الاستشارة / الساعة*",Suffix: Text("ریال"),)),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "حدد البنك*",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Colors.black,
                                        ),
                              ),
                            ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: DropdownButton(
                                    
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedBank = value!;
                                      });
                                    },
                                    focusColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    value: selectedBank,
                                    
                                    dropdownColor: Colors.white,
                                    isExpanded: true,
                                    items: const [
                                      DropdownMenuItem(
                                          value: 0,
                                          child: Text(
                                            "بنك الرياض",
                                            style: TextStyle(color: Colors.black),
                                          )),
                                      DropdownMenuItem(
                                          value: 1,
                                          child: Text(
                                            "بنك الجزيرة",
                                            style: TextStyle(color: Colors.black),
                                          )),
                                    ]),
                              ),
                              
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: MyTextFieldDark(label: "رقم الآيبان*")),
              ElevatedButton(
                  onPressed: () {
                    
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
      bottomNavigationBar: MyProviderBottomNavigationBar(),
    );
  }
}
