part of 'time_cubit.dart';

@immutable
abstract class TimeState {}

class TimeInitial extends TimeState {}

class TimeGetDataSuccess extends TimeState {}

class TimeGetDateCalenderSuccess extends TimeState {}