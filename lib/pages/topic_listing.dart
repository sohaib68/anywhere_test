import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_cubit.dart';
import 'topics_model.dart';

class TopicsListing extends StatelessWidget {
  const TopicsListing({
    super.key,
    required this.topicSelectedCallback,
    required this.topics,
    required this.selectedTopic,
  });

  final ValueChanged<Topic> topicSelectedCallback;
  final List<Topic> topics;
  final Topic selectedTopic;

  @override
  Widget build(BuildContext context) {
    final homePageCbit = context.read<HomePageCubit>();
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        final topics = state.filteredTopics?.data;
        return ListView.builder(
          itemCount: topics?.length,
          itemBuilder: (context, index) {
            final topic = state.topics?.data[index];
            return ListTile(
              title: Text(homePageCbit.getName(topic ?? Topic())),
              trailing: const Icon(Icons.arrow_right),
              onTap: () => topicSelectedCallback(topic ?? Topic()),
            );
          },
        );
      },
    );
  }
}
