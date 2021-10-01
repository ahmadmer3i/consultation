import 'package:consultation/components.dart';
import 'package:flutter/material.dart';

class SeekerReports extends StatefulWidget {
  const SeekerReports({ Key? key }) : super(key: key);

  @override
  _SeekerReportsState createState() => _SeekerReportsState();
}

class _SeekerReportsState extends State<SeekerReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        child: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  "بلاغاتي",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Color(0xffCB997E)),
                )),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffFFE8D6),),
                      child: Column(
                        children: [
                          Text(" 17 سبتمبر 2021 - 12:06 مساءً",style: Theme.of(context).textTheme.caption,),
                          Text("لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة، ولكن بفضل هؤلاء الأشخاص الذين لا يدركون بأن السعادة لا بد أن نستشعرها بصورة أكثر عقلانية ومنطقية فيعرضهم هذا لمواجهة الظروف الأليمة، وأكرر بأنه لا يوجد من يرغب في الحب ونيل المنال ويتلذذ بالآلام، الألم هو الألم ولكن نتيجة لظروف ما قد تكمن السعاده فيما نتحمله من كد وأسي.",style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 1.5),),
                          Text("تم الإبلاغ عن الملف الشخصي",style: Theme.of(context).textTheme.headline6!.copyWith(color: Color(0xff6B705C)),),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Container(padding: EdgeInsets.all(5),child: CircleAvatar()),Text("عمر صالح",style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),),],),
                            Align(alignment: Alignment.centerRight,child: Text("حالۃ البلاغ",style: Theme.of(context).textTheme.headline6!.copyWith(color: Color(0xffCB997E)),)),
                            Container(
                              height: 50,
                              child: ReportStatus(selectedIndex:1),
                              
                            )
                        ],
                      ),
                      
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffFFE8D6),),
                      child: Column(
                        children: [
                          Text(" 17 سبتمبر 2021 - 12:06 مساءً",style: Theme.of(context).textTheme.caption,),
                          Text("لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة، ولكن بفضل هؤلاء الأشخاص الذين لا يدركون بأن السعادة لا بد أن نستشعرها بصورة أكثر عقلانية ومنطقية فيعرضهم هذا لمواجهة الظروف الأليمة، وأكرر بأنه لا يوجد من يرغب في الحب ونيل المنال ويتلذذ بالآلام، الألم هو الألم ولكن نتيجة لظروف ما قد تكمن السعاده فيما نتحمله من كد وأسي.",style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 1.5),),
                          Text("تم الإبلاغ عن الملف الشخصي",style: Theme.of(context).textTheme.headline6!.copyWith(color: Color(0xff6B705C)),),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Container(padding: EdgeInsets.all(5),child: CircleAvatar()),Text("عمر صالح",style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),),],),
                            Align(alignment: Alignment.centerRight,child: Text("حالۃ البلاغ",style: Theme.of(context).textTheme.headline6!.copyWith(color: Color(0xffCB997E)),)),
                            Container(
                              height: 50,
                              child: ReportStatus(selectedIndex:0),
                              
                            )
                        ],
                      ),
                      
                      ),
                      ]
                  ),
                )
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}