import 'package:equatable/equatable.dart';

class LoginDetailsInput extends Equatable {
  final String? deviceName;
  final String fcmToken;

  const LoginDetailsInput.initial()
      : this(deviceName: "Iphone 14 pro max",fcmToken: '');
  const LoginDetailsInput({this.deviceName,required this.fcmToken});

  LoginDetailsInput modify({
    String? deviceName,
    String? fcmToken,

  }) {
    return LoginDetailsInput(
      deviceName: deviceName ?? this.deviceName,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  @override
  List<Object?> get props => [deviceName,fcmToken];
}
