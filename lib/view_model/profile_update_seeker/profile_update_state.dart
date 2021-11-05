part of 'profile_update_cubit.dart';

@immutable
abstract class ProfileUpdateState {}

class ProfileUpdateInitial extends ProfileUpdateState {}

class ProfileUpdateGetDataSuccess extends ProfileUpdateState {}

class ProfileUpdateUpdateSuccessState extends ProfileUpdateState {}

class ProfileUpdateLoadingState extends ProfileUpdateState {}

class ProfileUpdateErrorState extends ProfileUpdateState {}
