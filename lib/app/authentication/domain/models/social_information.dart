import 'package:equatable/equatable.dart';

class SocialInfo extends Equatable{
  final String socialName;
  final bool isCompleted;

  const SocialInfo(this.socialName, this.isCompleted);

  @override
  List<Object?> get props => [socialName, isCompleted];

}