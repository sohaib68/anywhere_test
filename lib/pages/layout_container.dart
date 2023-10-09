import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_config.dart';
import '../common/animated_search_bar.dart';

import 'home_page_cubit.dart';
import 'topic_details.dart';
import 'topic_listing.dart';
import 'topics_model.dart';

class LayoutContainer extends StatefulWidget {
  const LayoutContainer({Key? key}) : super(key: key);

  @override
  State<LayoutContainer> createState() => _LayoutContainerState();
}

class _LayoutContainerState extends State<LayoutContainer> {
  final TextEditingController searchController = TextEditingController();
  Topic _selectedTopic = Topic();
  @override
  initState() {
    loadDate();
    searchController.addListener(() {
      context.read<HomePageCubit>().updateFilter(searchController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void loadDate() {
    final homePageCbit = context.read<HomePageCubit>();
    homePageCbit.getData();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      content = _buildMobileLayout();
    } else {
      content = _buildTabletLayout();
    }

    return Scaffold(
        appBar: AppBar(title: Text(AppConfig.shared.appName), actions: <Widget>[
          AnimatedSearchBar(
            width: MediaQuery.of(context).size.width,
            color: AppConfig.shared.primaryColor,
            autoFocus: true,
            closeSearchOnSuffixTap: true,
            textController: searchController,
            style: const TextStyle(fontSize: 20, color: Colors.white),
            helpText: 'Search',
            onSuffixTap: () {
              setState(() {
                searchController.clear();
              });
            },
          ),
        ]),
        body: content);
  }

  Widget _buildMobileLayout() {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        final topics = state.filteredTopics?.data;
        return TopicsListing(
          topics: topics ?? [],
          selectedTopic: _selectedTopic,
          topicSelectedCallback: (topic) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return TopicDetails(
                    isInTabletLayout: false,
                    topic: topic,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTabletLayout() {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        final topics = state.filteredTopics?.data;
        return Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Material(
                elevation: 4.0,
                child: TopicsListing(
                  topics: topics ?? [],
                  topicSelectedCallback: (topic) {
                    setState(() {
                      _selectedTopic = topic;
                    });
                  },
                  selectedTopic: _selectedTopic,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: TopicDetails(
                isInTabletLayout: true,
                topic: _selectedTopic,
              ),
            ),
          ],
        );
      },
    );
  }
}
