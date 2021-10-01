import 'package:consultation/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:intl/intl.dart';

import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:pinch_zoom/pinch_zoom.dart';



class SeekerProfile extends StatefulWidget {
  final bool canProceed;
  final double ratingEditor=0;

  const SeekerProfile({Key? key, this.canProceed=true}) : super(key: key);
  

  @override
  _SeekerProfileState createState() =>
      _SeekerProfileState();
}

class _SeekerProfileState extends State<SeekerProfile>
    with SingleTickerProviderStateMixin {
  int seletedIndex = 0;
  

  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                
                alignment: Alignment.center,
                height: 200,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                        ),
                        Text(
                          "محمد علی",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(height: 1, color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              showDialog(context: context, builder: (context){
                              return AlertDialog(
                                title: Align(alignment: Alignment.center,child: Text("قيم تجربتك",style: TextStyle(color: Color(0xffCB997E)),)),
                                content: RatingEditor(rating: widget.ratingEditor,),
                                //actionsAlignment: MainAxisAlignment.start,
                                actions: [
                                  ElevatedButton(onPressed: (){}, child: Text("إرسال",style: TextStyle(color: Colors.white),)),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                                    onPressed: (){}, child: Text("إلغاء",style: TextStyle(color: Colors.white),)),
                                ],
                                
                              );
                            });
                            });
                            
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("3.0"),
                              StarRating(
                                rating: widget.ratingEditor,
                                size: 20,
                                borderColor: Color(0xff6B705C),
                                color: Color(0xff6B705C),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("الجنس",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w900),),
                Text("ذكر",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w900),),
                
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("تاريخ الميلاد",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w900),),
                Text(" 1 أغسطس 1997",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w900),),
                
              ],)
              ],
          ),
        ),
      ),
      bottomNavigationBar: MyProviderBottomNavigationBar(
        selectedIndex: 0,
      ),
    );
  }
}
