part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  const HomePageState({
    this.topics,
    this.filteredTopics,
    this.filter,
    this.errorMessage,
  });

  final Topics? topics;
  final Topics? filteredTopics;
  final String? filter;
  final String? errorMessage;

  @override
  List<Object?> get props => [topics, filteredTopics, filter];

  HomePageState copyWith({
    Topics? topics,
    Topics? filteredTopics,
    String? filter,
    String? errorMessage,
  }) {
    return HomePageState(
      topics: topics ?? this.topics,
      filteredTopics: filteredTopics ?? this.filteredTopics,
      filter: filter ?? this.filter,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
