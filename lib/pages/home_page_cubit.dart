import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/dom.dart' as d;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import '../app_config.dart';

import 'topics_model.dart';
part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageState());

  Future<void> getData() async {
    try {
      final response = await http.get(Uri.parse(AppConfig.shared.baseUrl));
      final jsonData = json.decode(response.body);
      final topics = Topics.fromJson(jsonData);
      emit(state.copyWith(topics: topics, filteredTopics: applyFilter(state.filter, topics)));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void updateFilter(String searchTerm) {
    emit(state.copyWith(filteredTopics: applyFilter(searchTerm, state.topics!), filter: searchTerm));
  }

  Topics applyFilter(String? searchTerm, Topics topics) {
    if (searchTerm == null || searchTerm == "") {
      return topics;
    }
    return Topics(
        data: topics.data.where((topic) {
      String searchText = searchTerm.toLowerCase();
      String name = getName(topic);
      bool match = name.contains(RegExp(searchText));
      return match;
    }).toList());
  }

  String getName(Topic topic) {
    String htmlString = topic.result;
    d.Document document = parse(htmlString);
    var anchorTag = document.querySelector('a');
    return anchorTag?.text ?? '';
  }
}
