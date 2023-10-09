import 'package:flutter/material.dart';

import 'topics_model.dart';

class TopicDetails extends StatefulWidget {
  const TopicDetails({
    super.key,
    required this.isInTabletLayout,
    required this.topic,
  });

  final bool isInTabletLayout;
  final Topic topic;

  @override
  State<TopicDetails> createState() => _TopicDetailsState();
}

class _TopicDetailsState extends State<TopicDetails> {
  String name = '';
  String details = '';

  @override
  Widget build(BuildContext context) {
    name = widget.topic.detail.split('-').first.trim();
    details = widget.topic.detail.split('-').last.trim();
    final Widget content = Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        if (widget.isInTabletLayout)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: (widget.topic.result != '')
                ? Text(name, style: const TextStyle(fontSize: 22))
                : Text('<< Please select a topic from the list.', style: const TextStyle(fontSize: 22)),
          ),
        if (widget.topic.result != '')
          Builder(builder: (context) {
            return (widget.topic.iconURL != '')
                ? Image.network('https://duckduckgo.com${widget.topic.iconURL}')
                : Image.asset('assets/images/no-image-found.jpg');
          }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(details),
        )
      ]),
    );

    if (widget.isInTabletLayout) {
      return Center(child: content);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(child: content),
    );
  }
}
