import 'package:consultation/components.dart';
import 'package:consultation/Seeker/provider_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListConsultants extends StatefulWidget {
  const ListConsultants({ Key? key }) : super(key: key);

  @override
  _ListConsultantsState createState() => _ListConsultantsState();
}

class _ListConsultantsState extends State<ListConsultants> {
    List<String> list=["تصميم غرافيك","تكنولوجيا المعلومات","إحصاء","كيمياء","اللغة والترجمة","تسويق","تصميم غرافيك","تكنولوجيا المعلومات","إحصاء","كيمياء","اللغة والترجمة","تسويق"];
    Map<String,String> map=new Map<String,String>();
    

  @override
  Widget build(BuildContext context) {
    map["تسويق"]="illustrationn5.png";
    map["اللغة والترجمة"]="illustrationn3.png";
    map["كيمياء"]="illustrationn4.png";
    map["إحصاء"]="illustrationn6.png";
    map["تكنولوجيا المعلومات"]="illustrationn2.png";
    map["تصميم غرافيك"]="illustrationn1.png";
    
    return Scaffold(
      appBar:MyAppBar(autoLeading: true,),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            
            MyTextFieldDark(label: "ابحث باسم المستشار",radius: 50,),
            
            
            Expanded(
             child: Container(
               margin: EdgeInsets.only(top:5),
               child: ListView.builder(
                 itemCount: 10,
                 itemBuilder: (context,int index){
                 
                 return GestureDetector(
                   onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProviderProfileSchedule()));
                   },
                   child: Container(
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Color(0xffFFE8D6),),
                     margin: EdgeInsets.only(top: 10),
                     height: 150,
                     child: Column(
                       
                       children: [
                         Expanded(flex: 1,child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             GestureDetector(
                               onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProviderProfileSchedule(canProceed: false,)));
                               },
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   CircleAvatar(),
                                   Container(
                                     padding: EdgeInsets.all(5),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                       Text("خالد عبدالله",style: Theme.of(context).textTheme.headline6!.copyWith(height: 1),),
                                       Text(" 15.00 ريال / الساعة",style: Theme.of(context).textTheme.subtitle2),
                                     ],),
                                   ),
                                 ],
                               ),
                             ),
                             Row(
                               children: [
                                 Text("3.0"),
                                 StarRating(rating: 1,size: 20,borderColor: Color(0xff6B705C),color:Color(0xff6B705C) ,),
                               ],
                             )
                             
                           ],
                         ),),
                         Expanded(flex:1,child:Text("خريج جامعة الملك سعود عام 2022 م صاحب البرنامج الاستشاري وحاصل على الشهادة الدولية للمسابقة الحائز على الميدالية الذهبية على مستوى المملكة في الذكاء الاصطناعي.",
                         style: Theme.of(context).textTheme.subtitle2!.copyWith(height: 1.2)),),
                       ],
                     ),
                     
                   ),
                 );
               }),
             ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndex: 0)
      
    );
  }
}