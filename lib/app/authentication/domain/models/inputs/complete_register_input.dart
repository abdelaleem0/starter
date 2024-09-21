import 'package:starter/common/utils/media_utils/src/domain/models/attachment_entity.dart';
import 'package:equatable/equatable.dart';

class CompleteRegisterInput extends Equatable {
  final String? userName;
  final String? firstName;
  final String? fcmToken;
  final Attachment? profilePicture;

  const CompleteRegisterInput({
    this.userName,
    this.fcmToken,
    this.firstName,
    this.profilePicture,
  });

  CompleteRegisterInput modify({
    String? userName,
    String? firstName,
    String? fcmToken,
    String? password,
    Attachment? profilePicture,
  }) {
    return CompleteRegisterInput(
      userName: userName ?? this.userName,
      firstName: firstName ?? this.firstName,
      fcmToken: fcmToken ?? this.fcmToken,
      profilePicture: profilePicture,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        userName,
        fcmToken,
        profilePicture,
      ];
}
