part of 'schedule_cubit.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitialState extends ScheduleState {}

class ScheduleProviderDataSuccessState extends ScheduleState {}

class ScheduledProviderDataGetSucceedState extends ScheduleState {}

class ScheduledGetChatSuccessState extends ScheduleState {}

class ScheduledSearchState extends ScheduleState {}

class ScheduleSearchEmptyState extends ScheduleState {}
