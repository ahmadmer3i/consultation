part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchTextState extends SearchState {}

class SearchEmptyState extends SearchState {}

class SearchNotEmptyState extends SearchState {}

class SearchDoneState extends SearchState {}
