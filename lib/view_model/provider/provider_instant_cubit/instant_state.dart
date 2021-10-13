part of 'instant_cubit.dart';

@immutable
abstract class InstantState {}

class InstantInitial extends InstantState {}

class InstantGetSuccess extends InstantState {}

class InstantProviderLoadingState extends InstantState {}

class InstantProviderDataSuccess extends InstantState {}

class InstantInstantDataLoadingState extends InstantState {}

class InstantInstantDataSuccess extends InstantState {}

class InstantSeekerDataSuccess extends InstantState {}
