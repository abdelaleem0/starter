import 'package:equatable/equatable.dart';

class AppCountry extends Equatable {
  final String isoCode;
  final String name;

  const AppCountry(this.isoCode, this.name);

  @override
  List<Object?> get props => [isoCode];
}