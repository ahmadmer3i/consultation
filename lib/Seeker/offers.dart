import 'package:consultation/Components.dart';
import 'package:consultation/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  "عروض",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Color(0xffCB997E)),
                )),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                        ),
  context: context,
  builder: (_) => MyBottomSheet(),
);
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: Color(0xffFFE8D6),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "خالد عبدالله",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("3.0"),
                                        StarRating(
                                          rating: 1,
                                          size: 20,
                                          borderColor: Color(0xff6B705C),
                                          color: Color(0xff6B705C),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(children: [
                            Column(
                              children: [
                                Text("15.00",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w700,color: Color(0xff6B705C)),),
                                Text(" ريال / الساعة"),
                              ],
                            ),
                            Icon(Icons.arrow_right,color: Color(0xff6B705C),size: 30,)
                          ],)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
