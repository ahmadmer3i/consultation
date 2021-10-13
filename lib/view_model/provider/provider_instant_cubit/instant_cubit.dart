import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:consultation/models/seeker_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      (value) {
        providerData1 = ProviderData.fromJson(value.data()!);
      },
    ).then((value) {
      _firebase
          .collection("consults")
          .orderBy("date", descending: true)
          .snapshots()
          .listen(
        (event) {
          consultProvider = [];
          consultData = [];
          for (var e in event.docs) {
            emit(InstantInstantDataLoadingState());
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
                    consultProvider.add(ProviderConsult.fromJson(data));
                    print(data["status"]);
                    consultData.add(ConsultData(
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

                    print(consultProvider.length);
                    emit(InstantInstantDataSuccess());
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

  void getConsultData() {
    emit(InstantInstantDataLoadingState());
    getProviderData();

    if (providerData1 == null) {
      emit(InstantInstantDataLoadingState());
    }
    _firebase
        .collection("consults")
        .orderBy("date", descending: false)
        .snapshots()
        .listen(
      (event) {
        consultProvider = [];
        consultData = [];
        for (var e in event.docs) {
          emit(InstantInstantDataLoadingState());
          if (providerData1!.topics!.contains(e.data()["topic"])) {
            if (e.data()["status"] != "ended" ||
                e.data()["providerId"] == null ||
                e.data()["providerId"] ==
                    FirebaseAuth.instance.currentUser!.uid) {
              for (var data in e.data()["providers"]) {
                if (data["consultId"] ==
                        FirebaseAuth.instance.currentUser!.uid &&
                    data != null) {
                  consultProvider.add(ProviderConsult.fromJson(data));

                  print(data["status"]);
                  consultData.add(ConsultData(
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
                  print(consultProvider.length);
                }
              }
            }
          }
        }
      },
    );
    emit(InstantInstantDataSuccess());
  }

  void getSeekerDataPerInstant({
    required String seekerId,
  }) {
    var _firebase = FirebaseFirestore.instance; // Firebase Connection instant;
    _firebase.collection("seeker").doc(seekerId).get().then((value) =>
        seekerData1 = SeekerData(
          email: value["email"],
          gender: value["gender"],
          date: value["dateOfBirth"],
          name: value["name"],
          uid: value["uid"],
          username: value["username"],
          password: value["password"],
        )); //get all data from the collection "seeker" and store it in snapshot

    emit(InstantSeekerDataSuccess());
    // loop over all docs in the collection seeker and add it to data list
  }
}
