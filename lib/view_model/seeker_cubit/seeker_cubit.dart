import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/seeker_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'seeker_state.dart';

class SeekerCubit extends Cubit<SeekerState> {
  SeekerCubit() : super(SeekerInitial());

  static SeekerCubit get(context) => BlocProvider.of(context);

  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  SeekerData seekerData = SeekerData(
      email: "",
      gender: "",
      date: "",
      name: "",
      uid: "",
      username: "",
      password: "");

  void getSeekerData({required String seekerId}) {
    _firebase
        .collection(seekerCollection)
        .where("uid", isEqualTo: seekerId)
        .get()
        .then(
          (value) => seekerData = SeekerData.fromJson(
            value.docs.first.data(),
          ),
        );
    emit(
      SeekerDataSuccessState(),
    );
  }
}
