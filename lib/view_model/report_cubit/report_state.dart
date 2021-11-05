part of 'report_cubit.dart';

@immutable
abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportSendSuccessState extends ReportState {}

class ReportGetDataLoadingState extends ReportState {}

class ReportGetDataSuccessState extends ReportState {}
