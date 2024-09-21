// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_intention_reminder_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiIntentionReminderInput _$ApiIntentionReminderInputFromJson(
        Map<String, dynamic> json) =>
    ApiIntentionReminderInput(
      type: $enumDecodeNullable(
          _$FilterIntentionReminderInputTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$ApiIntentionReminderInputToJson(
        ApiIntentionReminderInput instance) =>
    <String, dynamic>{
      'type': _$FilterIntentionReminderInputTypeEnumMap[instance.type],
    };

const _$FilterIntentionReminderInputTypeEnumMap = {
  FilterIntentionReminderInputType.GOAL: 'GOAL',
  FilterIntentionReminderInputType.WEEKLY_PLANNER: 'WEEKLY_PLANNER',
};
