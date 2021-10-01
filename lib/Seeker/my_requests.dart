import 'package:consultation/components.dart';
import 'package:consultation/Seeker/consultation_details_instant.dart';
import 'package:consultation/Seeker/offers.dart';
import 'package:consultation/Seeker/seeker_chat.dart';
import 'package:consultation/Seeker/seeker_chat_open.dart';
import 'package:flutter/material.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({ Key? key }) : super(key: key);

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  bool Request=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
           Align(
                alignment: Alignment.center,
                child: Text(
                  "طلباتي",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Color(0xffCB997E)),
                )),
                Container(padding: EdgeInsets.symmetric(horizontal: 10),child: Align(alignment: Alignment.centerLeft,child: IconButton(onPressed:(){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SeekerChat(tabIndex: 1,)));

                },icon: Icon(Icons.history,color: Colors.grey,)))),

            Expanded(
              child: Request?Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xffFFE8D6),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("تصميم غرافيك",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w700),),IconButton(onPressed: (){
                        setState(() {
                          Request=false;
                        });
                      },icon: Icon(Icons.delete_outline_outlined,color: Colors.grey,))],),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text(" 17 سبتمبر 2021",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w700)),Text("8:00 - 6:00 مساءً",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w700))],),
                      Container(padding: EdgeInsets.only(top: 20),child: Text("عاجل تصميم شعار لمشروع تجاري في مجال الموضة حيث سيتم تطوي الهوية بعد نجاح المشروع سيكون شعارًا مميزًا ورسميًا يعكس جودة صناعتنا ويجذب المشتري لزيادة المبيعات",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1.2))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("عروض : 5",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w700)),

                    ElevatedButton(onPressed: (){
                       Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Offers()));
                    }, child: Text("مشاهدة العروض",style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white))),
                    
                    
                  ],)
                ],),
              ):Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("لا یوجد استشارات",style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.grey),),
                  ElevatedButton(onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ConsultationDetailsInstant()));
                  }, child: Text("استشر الآن",style: TextStyle(color: Colors.white),))
                ],
              ),
            )
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndex: 1,),
    );
  }
}