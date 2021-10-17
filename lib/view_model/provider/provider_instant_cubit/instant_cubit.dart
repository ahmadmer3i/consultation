import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:consultation/models/seeker_data.dart';
import 'package:consultation/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'instant_state.dart';

class InstantCubit extends Cubit<InstantState> {
  InstantCubit() : super(InstantInitial());

  ProviderData? providerData1;
  SeekerData? seekerData1;

  static InstantCubit get(context) => BlocProvider.of(context);
  final _firebase = FirebaseFirestore.instance;

  List<ConsultData> consultData = [];
  List<ProviderConsult> consultProvider = [];
  void getProviderData() {
    emit(InstantProviderLoadingState());
    _firebase
        .collection("provider")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      // instead of using async and await
      (value) {
        providerData1 = ProviderData.fromJson(value.data()!);
      },
    ).then((value) {
      _firebase
          .collection("consults")
          .orderBy("date", descending: true)
          .snapshots()
          .listen(
        // monitor the changes on the upcoming data
        (event) {
          consultProvider = [];
          consultData = [];
          for (var e in event.docs) {
            emit(InstantInstantDataLoadingState());
            if (e.data()["isDeletedProvider"] == false) {
              if (providerData1!.topics!.contains(e.data()["topic"])) {
                if ((e.data()["status"] != "ended" &&
                        e.data()["status"] == "active" &&
                        e.data()["providerId"] ==
                            FirebaseAuth.instance.currentUser!.uid) ||
                    e.data()["providerId"] == null ||
                    e.data()["providerId"] ==
                        FirebaseAuth.instance.currentUser!.uid) {
                  for (var data in e.data()["providers"]) {
                    if (data["consultId"] ==
                            FirebaseAuth.instance.currentUser!.uid &&
                        data != null) {
                      consultProvider.add(ProviderConsult.fromDatabase(data));
                      consultData.add(ConsultData(
                        // == fromJson custom constructor
                        consultId: e.data()["consultId"],
                        isActive: e.data()["isActive"],
                        uid: e.data()["uid"],
                        topic: e.data()["topic"],
                        detail: e.data()["details"],
                        date: e.data()["date"],
                        docId: e.data()["consultId"],
                        status: e.data()["status"],
                        price: double.parse(e.data()["price"].toString()),
                        providers: consultProvider,
                        payment: e.data()["payment"],
                        isPaid: e.data()["isPaid"],
                      ));
                      emit(InstantInstantDataSuccess());
                    }
                  }
                }
              }
            }
          }
        },
      );
      emit(InstantProviderDataSuccess());
    });
  }

  void deletedItemProvider(BuildContext ctx, {required String docId}) {
    emit(InstantProviderDataDeleteLoading());
    MessageDialog.showWaitingDialog(ctx, message: "يرجى الانتظار");

    FirebaseFirestore.instance.collection("consults").doc(docId).set(
      {
        "isDeletedProvider": true,
      },
      SetOptions(merge: true),
    ).then((value) {});
    Navigator.pop(ctx);
    emit(InstantProviderDataDeletedSuccess());
  }
}
