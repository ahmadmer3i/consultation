




import 'package:consultation/Seeker/seeker_reports.dart';
import 'package:consultation/components.dart';
import 'package:consultation/Seeker/seeker_edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SeekerProfile extends StatefulWidget {
  const SeekerProfile({ Key? key }) : super(key: key);

  @override
  _SeekerProfileState createState() => _SeekerProfileState();
}

class _SeekerProfileState extends State<SeekerProfile> {
  FirebaseAuth instance=FirebaseAuth.instance ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(

          children: [
            Container(
                padding: EdgeInsets.all(20),
                child: Align(alignment: Alignment.center,child: CircleAvatar(radius: 70,))),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SeekerProfileEdit()));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffFFE8D6)
                ),
                height: 50,
                child: Row(children: [
                  Container(padding: EdgeInsets.symmetric(horizontal: 10),child: Icon(Icons.person_outlined,size: 30,color: Color(0xff6B705C),)),
                  Text("ملفي الشخصي",style: Theme.of(context).textTheme.headline6,)
                ],),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SeekerReports()));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffFFE8D6)
                ),
                height: 50,
                child: Row(children: [
                  Container(padding: EdgeInsets.symmetric(horizontal: 10),child: Icon(Icons.report_outlined,size: 30,color: Color(0xff6B705C),)),
                  Text("بلاغاتي ",style: Theme.of(context).textTheme.headline6,)
                ],),
              ),
            ),GestureDetector(
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, '/LoginSeeker', (route) => route.isFirst);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffFFE8D6)
                ),
                height: 50,
                child: Row(children: [
                  Container(padding: EdgeInsets.symmetric(horizontal: 10),child: IconButton(icon:Icon(Icons.logout_outlined,size: 30,color: Color(0xff6B705C),),onPressed:(){
                    instance.signOut();
                  }),),
                  Text("خروج",style: Theme.of(context).textTheme.headline6,)
                ],),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}