import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit() : super(ScheduleInitialState());

  static ScheduleCubit get(context) => BlocProvider.of(context);

  final _firebase = FirebaseFirestore.instance;

  List<ProviderData> providers = [];

  getScheduleData({required String topic}) {
    _firebase
        .collection("provider")
        .where("scheduled", isEqualTo: true)
        .where("topics", arrayContains: topic)
        .get()
        .then((value) {
      providers = [];
      for (var doc in value.docs) {
        print(doc.data()["gender"]);
        providers.add(ProviderData.fromJson(doc.data()));
      }
      emit(ScheduleProviderDataSuccessState());
    }).catchError((err) => print(err));
  }
}
