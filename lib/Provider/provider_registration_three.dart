// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:adobe_xd/pinned.dart';
import 'package:consultation/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProviderRegisterationThree extends StatefulWidget {
  const ProviderRegisterationThree({ Key? key }) : super(key: key);

  @override
  _ProviderRegisterationThreeState createState() => _ProviderRegisterationThreeState();
}

class _ProviderRegisterationThreeState extends State<ProviderRegisterationThree> {
   bool instant=false;
   bool scheduled=false;
   int selectedBank=0;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      resizeToAvoidBottomInset: true,
   

      // ignore: prefer_const_constructors
      backgroundColor: Color(0xffFFE8D6),
      body: Stack(
        children: [
          Pinned.fromPins(
            Pin(size: 256.0, end: -100.0),
            Pin(size: 256.0, start: -100.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xff6B705C),
                border: Border.all(width: 1.0, color: const Color(0xff6B705C)),
              ),
            ),
          ),
          Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.only(top: 80,right: 50),
                  child: IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  },icon: Icon(Icons.arrow_back,color: Colors.white,)),
                ),
              ),
              Align(child: Text("أهلا بك! ",style: Theme.of(context).textTheme.headline6!.copyWith(height: 1),)),
              Text("محمد علی",style: Theme.of(context).textTheme.headline3!.copyWith(height: 2,fontWeight: FontWeight.bold)),
            
            Text(
              'نحتاج إلى بعض المعلومات الإضافية لإعداد حسابك',
              textAlign: TextAlign.center,
              
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(height: 1,color: Color(0xffCB997E)),
            ),
            Expanded(
                child: Stack(
              children: [
                Container(

                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              
                              padding: const EdgeInsets.all(10),
                              child: Align(alignment: Alignment.topCenter,child: Text("أخبرنا عن نفسك",style:Theme.of(context).textTheme.headline6!.copyWith(height: 2,color: Color(0xff21686C)))),
                              ),
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
                              DropdownButton(
                                  
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
                              
                              MyTextFieldDark(label: "رقم الآيبان*"),
                          ],
                        ),
                          
                          
                          
                         
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 100,vertical: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                  CircleAvatar(radius: 4,backgroundColor: Color(0xff8EC73F),),
                                  CircleAvatar(radius: 4,backgroundColor: Color(0xff8EC73F),),
                                  CircleAvatar(radius: 4,backgroundColor: Color(0xff6B705C),),
                                ],),
                              ),
                              ElevatedButton(onPressed: (){}, child: Text("التالي",style: TextStyle(color: Colors.white),)),
                            ],
                          )
                          
                      ],
                    ),
                  ),
                ),
                
                  
              ],
            ))
          ],
        ),
        ]
      ),
    );
  }
}