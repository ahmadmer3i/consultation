import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  final _firebase = FirebaseFirestore.instance;
  final searchController = TextEditingController();
  bool isSearchEmpty = true;
  List<ProviderData> providerData = [];
  List<ProviderData> searchResult = [];

  getAllProviders() {
    _firebase.collection(providerCollection).get().then((value) {
      providerData = [];
      for (var doc in value.docs) {
        providerData.add(ProviderData.fromJson(doc.data()));
      }
    });
    emit(SearchTextState());
  }

  checkSearch() {
    if (searchController.text.length > 3) {
      isSearchEmpty = false;
      emit(SearchEmptyState());
      searchResult = [];
      for (var provider in providerData) {
        if (provider.name!.contains(searchController.text)) {
          searchResult.add(provider);
        }
      }
      emit((SearchDoneState()));
    } else {
      isSearchEmpty = true;
      emit(SearchNotEmptyState());
    }
  }

  getSearch() {}
}
