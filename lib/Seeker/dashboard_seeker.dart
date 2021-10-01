import 'package:consultation/components.dart';
import 'package:consultation/Seeker/list_consultants.dart';
import 'package:flutter/material.dart';

class DashboardSeeker extends StatefulWidget {
  const DashboardSeeker({ Key? key }) : super(key: key);

  @override
  _DashboardSeekerState createState() => _DashboardSeekerState();
}

class _DashboardSeekerState extends State<DashboardSeeker> {
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
      appBar:MyAppBar(autoLeading: false,),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(alignment: Alignment.centerRight,child: Text("أهلاً علي",style: Theme.of(context).textTheme.headline5!.copyWith(color: Color(0xffCB997E)))),
            MyTextFieldDark(label: "ابحث باسم المستشار",radius: 50,),
            Align(alignment: Alignment.center,child: Text("ماهي نوع استشارتك التي تود طلبها ؟",style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Color(0xff6B705C)))),
            Align(alignment: Alignment.centerRight,child: Text("المجالات",style: Theme.of(context).textTheme.headline6!.copyWith(color: Color(0xffCB997E)))),
            Expanded(
              child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemCount: map.entries.length,
            itemBuilder: (BuildContext ctx, index) {
              
              
              return GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      backgroundColor: Color(0xffFFE8D6),
                      title: Align(alignment: Alignment.center,child: Text("حدد نوع الاستشارة")),
                      content: Container(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ListConsultants()));

                            }, child: Text("مجدولة",style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),)),
                            ElevatedButton(onPressed: (){}, child: Text("فورية",style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),)),
                            
                          ],
                        ),
                      ),
                    );
                  });
                },
                child: Container(
                  child: Column(
                    children: [
                    Container(padding: EdgeInsets.all(20),child: Align(alignment: Alignment.centerRight,child: Text(map.keys.elementAt(index),style: Theme.of(context).textTheme.headline6!.copyWith(color: Color(0xff6B705C),height: 1.2)))),
                    Expanded(
                      child: Container(
                        child: Image.asset("Assets/${map.values.elementAt(index)}"),
                      ),
                    )
              
                    ],
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xffFFE8D6),
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            }),
            )



          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndex: 4,)
      
    );
  }
}