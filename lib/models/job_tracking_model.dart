import 'dart:convert';

class JobTrackingModel {
  List<String>? image;
  String title;
  String explanation;
  String corporation;
  String state;
  String jobId;
  JobTrackingModel({
    required this.image,
    required this.title,
    required this.explanation,
    required this.corporation,
    required this.state,
    required this.jobId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'image': image});
    result.addAll({'title': title});
    result.addAll({'explanation': explanation});
    result.addAll({'corporation': corporation});
    result.addAll({'state': state});

    return result;
  }

  // map te id ve verisini ayrı getiriyor.
  factory JobTrackingModel.fromMap(Map<String, dynamic> map, String? id) {
    return JobTrackingModel(
      image: List<String>.from(map['image']),
      title: map['title'] ?? '',
      explanation: map['explanation'] ?? '',
      corporation: map['corporation'] ?? '',
      state: map['state'] ?? '',
      jobId: id ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory JobTrackingModel.fromJson(String source) =>
      JobTrackingModel.fromMap(json.decode(source), null);
}
