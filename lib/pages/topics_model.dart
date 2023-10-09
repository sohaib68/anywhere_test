class Topics {
  final List<Topic> data;

  Topics({
    required this.data,
  });

  factory Topics.fromJson(Map<String, dynamic> json) {
    final List<dynamic> topicsList = json['RelatedTopics'];
    final List<Topic> topics = topicsList.map((topicJson) => Topic.fromJson(topicJson)).toList();
    return Topics(data: topics);
  }
}

class Topic {
  String firstURL;
  String iconHeight;
  String iconURL;
  String iconWidth;
  String result;
  String detail;

  Topic(
      {this.firstURL = '',
      this.iconHeight = '',
      this.iconURL = '',
      this.iconWidth = '',
      this.result = '',
      this.detail = ''});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
        firstURL: json['FirstURL'],
        iconHeight: json['Icon']['Height'],
        iconURL: json['Icon']['URL'],
        iconWidth: json['Icon']['Width'],
        result: json['Result'],
        detail: json['Text']);
  }
}
