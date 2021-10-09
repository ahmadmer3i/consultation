import 'package:consultation/components.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:consultation/view_model/get_provider_offer.dart';
import 'package:consultation/view_model/get_request_data.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_rating/flutter_rating.dart';

class Offers extends StatefulWidget {
  final List<Map<String, dynamic>> providerData;
  final String docId;
  const Offers({
    Key? key,
    required this.providerData,
    required this.docId,
  }) : super(key: key);

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
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: widget.providerData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (_) => MyBottomSheet(
                          price: double.parse(
                              (widget.providerData[index]["price"]!)),
                          onPressed: () {
                            Navigator.pop(context);
                            setPayment(
                              context,
                              providerData: widget.providerData[index],
                              providerId: widget.providerData[index]
                                  ["consultId"],
                              docId: widget.docId,
                              price: double.parse(
                                  widget.providerData[index]["price"]),
                              payment: selectedPaymentMethod == 0
                                  ? "Apple Pay"
                                  : "STC Pay",
                            );
                          },
                        ),
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
                                    FutureBuilder(builder: (context, snapshot) {
                                      Future<ProviderData>? getData =
                                          getProviderOffer(
                                              id: widget.providerData[index]
                                                  ["consultId"]);
                                      return FutureBuilder(
                                          future: getData,
                                          builder: (context,
                                              AsyncSnapshot<ProviderData>
                                                  snapshot) {
                                            print(snapshot.error);
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              print(snapshot.data?.name);
                                              return Text(
                                                "${snapshot.data?.name}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              );
                                            } else {
                                              return const CircularProgressIndicator();
                                            }
                                          });
                                    }),
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
                                    double.parse(
                                            widget.providerData[index]["price"])
                                        .toStringAsFixed(2),
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
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
