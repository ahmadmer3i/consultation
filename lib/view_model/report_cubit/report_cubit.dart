import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/report_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  static ReportCubit get(context) => BlocProvider.of(context);

  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var reportId = const Uuid().v1();

  List<ReportModel> reportData = [];

  void sendReport({
    required String reportCollection,
    required String reportDetails,
    required String receiverId,
    required String sender,
    required String receiver,
  }) async {
    await _firebase.collection(reportCollection).doc(reportId).set(
      {
        "reportDate": DateTime.now(),
        "reportDetails": reportDetails,
        receiver: receiverId,
        "reportId": reportId,
        "status": 0,
        sender: _auth.currentUser!.uid,
      },
    );
    reportId = const Uuid().v1();
    emit(ReportSendSuccessState());
  }

  void getReports(
      {required String userType, required String reportCollection}) async {
    emit(ReportGetDataLoadingState());
    _firebase
        .collection(reportCollection)
        .where(userType, isEqualTo: _auth.currentUser!.uid)
        .orderBy("reportDate", descending: true)
        .get()
        .then((value) {
      reportData = [];
      for (var doc in value.docs) {
        reportData.add(ReportModel.fromDatabase(doc.data()));
        emit(ReportGetDataSuccessState());
      }
    });
  }
}
