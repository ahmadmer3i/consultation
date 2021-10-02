// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/Provider/provider_chat.dart';
import 'package:consultation/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SeekerChatOpen extends StatefulWidget {
  final bool IsClosed;
  const SeekerChatOpen({ Key? key, this.IsClosed=false}) : super(key: key);

  @override
  _SeekerChatOpenState createState() => _SeekerChatOpenState();
}

class _SeekerChatOpenState extends State<SeekerChatOpen> {
  bool? isclosed=false;
  var rating = 0.0;
  @override
  void initState() {
    isclosed=widget.IsClosed;
    print(isclosed);

    super.initState();
    
  }
  @override

  //build screen
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: MyAppBar(onPressed: !isclosed!?(){setState(() { //build app bar
        isclosed=true;
      });}:(){
      showDialog(context: context, builder: (context) {
         return Dialog(
           backgroundColor: Colors.white,
           child: Container(
             height: MediaQuery.of(context).size.height * 0.4, //media query ابعاد الجهاز اخذت ٤٠٪ من الشاشه
             width:MediaQuery.of(context).size.width * 0.4,
             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), //زوايا الكونتينر نفسه و اللون
             child: Center( // new widget so i need child its under container
               child: Directionality( //convert from left to right
                 textDirection: TextDirection.ltr, //property
                 child: Column( // اذا ابي فوق او تحت بعض استخدم كولم
                   children: [  //list collection of widgets
                     SmoothStarRating(
                          allowHalfRating: true, // 0.5 star
                          onRated: (v) {
                            setState(() { // go back to build widget each time the rate of stars change
                              rating = v;
                            });
                          },
                          starCount: 5,
                          rating: rating,
                          size: 40.0,
                          isReadOnly: false,
                          filledIconData: Icons.star_outlined,
                          halfFilledIconData: Icons.star_half,
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
                          spacing: 0.0
                      ),
                     ElevatedButton(onPressed: () async{ //future function we used async and await when the data is filled in firebase (ex:bad connection)

                       // continue this
                      
                       await FirebaseFirestore.instance.collection("seeker").doc("0Gw0BElTEnZPdtTLGO3K").collection("ratings").doc("hana").set(
                           {  "rating":rating }); // ?= variable is optional may be null
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>ProviderChat()), (route) => false);
                     }, child: Text("إرسال"))
                   ],
                 ),
               ),
             ),
           ),
         );},
      );},),
      body:Column(
        
        children: [
          Expanded(
            
            child:Container(
              padding:EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  
                  
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 300
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                          color: Color(0xffFFE0BE),
                      
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            )
                          ),
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Text("السلام عليكم",style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1),)),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text("12:06 مساءً",textAlign: TextAlign.end,style: Theme.of(context).textTheme.caption!.copyWith(height: 1),)),
                            ],
                          ),
                        ),
                      ),
                    ),

                     Align(
                      alignment: Alignment.topLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 300
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                          color: Color(0xffF3F3F3),
                      
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            )
                          ),
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Text("وعليكم السلام",style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1),)),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text("12:06 مساءً",textAlign: TextAlign.start,style: Theme.of(context).textTheme.caption!.copyWith(height: 1),)),
                            ],
                          ),
                        ),
                      ),
                    ),
                     
                  ],
                ),
              ),
            ),
          ),
          !isclosed!?Container(
            color: Color(0xffFFE0BE),
            height: 60,
            padding: EdgeInsets.all(5),
            child:Row(
            children: [
              IconButton(onPressed: (){},icon: Icon(Icons.more_horiz),),
              Expanded(child: MyTextFieldDark(backgroundColor:Colors.white, label: "",showLabel: false,radius: 30,iconButton: IconButton(padding: EdgeInsets.all(0),onPressed: (){},icon: Icon(Icons.attachment,size: 20,),),)),
              IconButton(onPressed: (){},icon: Icon(Icons.camera_alt),),
              IconButton(onPressed: (){},icon: Icon(Icons.send,)),

            ],
          ),):Container()
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      
    );
  }
}


