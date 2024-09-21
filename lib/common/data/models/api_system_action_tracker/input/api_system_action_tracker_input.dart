import 'package:starter/common/domain/inputs/system_action_tracker_input.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_system_action_tracker_input.g.dart';

@JsonSerializable()
class ApiSystemActionTrackerInput {
  final String entityId;
  final String entityType;

  ApiSystemActionTrackerInput({
    required this.entityId,
    required this.entityType
  });

  factory ApiSystemActionTrackerInput.fromInput(
      SystemActionTrackerInput systemActionTrackerInput) {
    final entityType =
        systemActionTrackerInput.connectionType == ConnectionTypeEnum.articles
            ? "ARTICLES"
            : systemActionTrackerInput.connectionType ==
                    ConnectionTypeEnum.challenges
                ? "CHALLENGES"
                : "EVENTS";
    return ApiSystemActionTrackerInput(
        entityId: systemActionTrackerInput.entityId,
        entityType: entityType);
  }

  factory ApiSystemActionTrackerInput.fromJson(Map<String, dynamic> json) =>
      _$ApiSystemActionTrackerInputFromJson(json);

  Map<String, dynamic> toJson() => _$ApiSystemActionTrackerInputToJson(this);

}
