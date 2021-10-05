import 'package:consultation/Components.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "عروض",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: const Color(0xffCB997E),
                    ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (_) => const MyBottomSheet(),
                      );
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFE8D6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(),
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "خالد عبدالله",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("3.0"),
                                        StarRating(
                                          rating: 1,
                                          size: 20,
                                          borderColor: const Color(0xff6B705C),
                                          color: const Color(0xff6B705C),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "15.00",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff6B705C),
                                        ),
                                  ),
                                  const Text(" ريال / الساعة"),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_right,
                                color: Color(0xff6B705C),
                                size: 30,
                              ),
                            ],
                          )
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
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
