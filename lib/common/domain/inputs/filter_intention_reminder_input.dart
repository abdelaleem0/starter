import 'package:equatable/equatable.dart';

class FilterIntentionReminderInput extends Equatable{
  final IntentionReminderEnum intentionReminderEnum;

  const FilterIntentionReminderInput({required this.intentionReminderEnum});

  @override
  List<Object?> get props => [intentionReminderEnum];
}

enum IntentionReminderEnum{
  goal,
  weeklyPlanner
}