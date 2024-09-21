import 'package:equatable/equatable.dart';

class OTP extends Equatable {
  final int numberOTPInHour;
  final DateTime firstOTPTime;
  final bool isBlocked;

  const OTP(
    this.numberOTPInHour,
    this.firstOTPTime,
    this.isBlocked,
  );

  @override
  List<Object?> get props => [
        numberOTPInHour,
        firstOTPTime,
        isBlocked,
      ];
}
