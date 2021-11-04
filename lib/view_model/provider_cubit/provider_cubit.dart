import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'provider_state.dart';

class ProviderCubit extends Cubit<ProviderState> {
  ProviderCubit() : super(ProviderInitial());

  static ProviderCubit get(context) => BlocProvider.of(context);

  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  ProviderData providerData = ProviderData(
    password: "",
    email: "",
    name: "",
    uid: "",
    birthOfDate: "",
    isApproved: false,
    price: 0,
  );

  getProviderData({required String providerId}) {
    _firebase
        .collection(providerCollection)
        .where("uid", isEqualTo: providerId)
        .get()
        .then(
          (value) => providerData = ProviderData.fromJson(
            value.docs.first.data(),
          ),
        );
    emit(ProviderGetDataSuccessState());
  }
}
