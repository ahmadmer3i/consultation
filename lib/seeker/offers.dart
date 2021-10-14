import 'package:consultation/components.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:consultation/view_model/get_provider_offer.dart';
import 'package:consultation/view_model/get_request_data.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_rating/flutter_rating.dart';

class Offers extends StatefulWidget {
  final List<ProviderConsult> providerData;
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
                              (widget.providerData[index].price).toString()),
                          onPressed: () {
                            Navigator.pop(context);
                            setPayment(
                              context,
                              providerData: widget.providerData[index],
                              providerId: widget.providerData[index].consultId!,
                              docId: widget.docId,
                              price: double.parse(
                                  widget.providerData[index].price!.toString()),
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
                                child: FutureBuilder(
                                  future: getProviderOffer(
                                      id: widget
                                          .providerData[index].consultId!),
                                  builder: (context,
                                      AsyncSnapshot<ProviderData> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data?.name}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                snapshot.data!.rate!
                                                    .toStringAsFixed(1),
                                              ),
                                              StarRating(
                                                rating: snapshot.data!.rate,
                                                size: 20,
                                                borderColor:
                                                    const Color(0xff6B705C),
                                                color: const Color(0xff6B705C),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    double.parse(widget
                                            .providerData[index].price!
                                            .toString())
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
