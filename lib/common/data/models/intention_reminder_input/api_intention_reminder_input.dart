import 'package:starter/common/domain/inputs/filter_intention_reminder_input.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_intention_reminder_input.g.dart';

@JsonSerializable()
class ApiIntentionReminderInput {
  final FilterIntentionReminderInputType? type;
  ApiIntentionReminderInput({this.type});

  factory ApiIntentionReminderInput.fromInput(
      FilterIntentionReminderInput filterIntentionReminderInput) {
    return ApiIntentionReminderInput(type: filterIntentionReminderInput.intentionReminderEnum == IntentionReminderEnum.weeklyPlanner ? FilterIntentionReminderInputType.WEEKLY_PLANNER : FilterIntentionReminderInputType.GOAL);
  }

  factory ApiIntentionReminderInput.fromJson(Map<String, dynamic> json) =>
      _$ApiIntentionReminderInputFromJson(json);


  Map<String, dynamic> toJson() => _$ApiIntentionReminderInputToJson(this);

}

enum FilterIntentionReminderInputType{
  GOAL,
  WEEKLY_PLANNER
}