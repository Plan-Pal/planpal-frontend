import 'package:planpal_frontend/models/schedule_model/sumarized_schedule_model.dart';

class AllScheduleListModel {
  late int scheduleCount;
  late List<SummarizedScheduleModel> schedules;

  AllScheduleListModel({required this.scheduleCount, required this.schedules});

  AllScheduleListModel.fromJson(Map<String, dynamic> map) {
    scheduleCount = map['result']['schedule_count'];
    schedules = (map['result']['schedules'] as List)
        .map((item) => SummarizedScheduleModel.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'result': {
        'schedule_count': scheduleCount,
        'schedules': schedules.map((item) => item.toJson()).toList(),
      },
    };
  }
}
