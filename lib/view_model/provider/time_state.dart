part of 'time_cubit.dart';

@immutable
abstract class TimeState {}

class TimeInitial extends TimeState {}

class TimeGetDataSuccess extends TimeState {}

class TimeGetDateCalenderSuccess extends TimeState {}

class TimeAvailableTimeGetSuccess extends TimeState {}

class TimeChangeSelectedDate extends TimeState {}

class TimeGetDateCalenderSeekerSuccess extends TimeState {}

class TimeGetDataSeekerSuccess extends TimeState {}

class TimeGetSelectedTimeSeekerSuccess extends TimeState {}

class TimeSelectedTimeToggleSeekerSuccess extends TimeState {}

class TimeRemoveReservedTimeSuccess extends TimeState {}

class TimeSetReservedTimeSuccess extends TimeState {}

class TimeSetReservedDaySuccess extends TimeState {}

class TimeResetReservedDaySuccess extends TimeState {}

class TimeSetEventSeekerSuccess extends TimeState {}

class TimeSeekerSetSuccess extends TimeState {}
