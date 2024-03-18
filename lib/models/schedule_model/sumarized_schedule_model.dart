class SummarizedScheduleModel {
  late int scheduleId;
  late String shortTitle;
  late String title;
  late DateTime appointedTime;
  late String place;

  SummarizedScheduleModel(
      {required this.scheduleId,
      required this.shortTitle,
      required this.title,
      required this.appointedTime,
      required this.place});

  SummarizedScheduleModel.fromJson(Map<String, dynamic> map) {
    scheduleId = map['schedule_id'];
    shortTitle = map['short_title'];
    title = map['title'];
    appointedTime = DateTime.parse(map['appointed_time']);
    place = map['place'];
  }

  Map<String, dynamic> toJson() {
    return {
      'schedule_id': scheduleId,
      'short_title': shortTitle,
      'title': title,
      'appointed_time': appointedTime.toIso8601String(),
      'place': place,
    };
  }
}
