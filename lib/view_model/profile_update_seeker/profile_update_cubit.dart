import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/seeker_data.dart';
import 'package:consultation/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'profile_update_state.dart';

class ProfileUpdateCubit extends Cubit<ProfileUpdateState> {
  ProfileUpdateCubit() : super(ProfileUpdateInitial());

  static ProfileUpdateCubit get(context) => BlocProvider.of(context);

  final _auth = FirebaseAuth.instance;
  final _firebase = FirebaseFirestore.instance;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bodController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  String gender = "";

  var seekerData = SeekerData(
      email: "",
      gender: "",
      date: "",
      name: "",
      uid: "",
      username: "",
      password: "");

  void getDate() {
    _firebase
        .collection("seeker")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      seekerData = SeekerData.fromJson(value.data()!);
    }).then((value) {
      nameController.text = seekerData.name!;
      emailController.text = seekerData.email!;
      bodController.text = seekerData.date!;
      gender = seekerData.gender!;
      emit(ProfileUpdateGetDataSuccess());
    });
  }

  updateData(context) {
    emit(ProfileUpdateLoadingState());
    _firebase.collection("seeker").doc(_auth.currentUser!.uid).update({
      "gender": gender,
      "dateOfBirth": bodController.text,
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    }).then((value) async {
      try {
        await _auth.currentUser!.updateEmail(emailController.text);
        if (passwordController.text.isNotEmpty) {
          await _auth.currentUser!.updatePassword(passwordController.text);
        }
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == "requires-recent-login") {
          MessageDialog.showSnackBar(
              "يرجى اعادة الدخول لتعيين كلمة السر", context);
        }
      }
      emit(ProfileUpdateUpdateSuccessState());
    });
  }
}
