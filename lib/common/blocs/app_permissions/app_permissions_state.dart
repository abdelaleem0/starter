import 'package:equatable/equatable.dart';

class AppPermissionsState extends Equatable {
  final String? errorMessage;
  const AppPermissionsState(this.errorMessage);

  const AppPermissionsState.initial() : this(null);

  AppPermissionsState reduce({
    String? errorMessage
  }) {
    return AppPermissionsState(errorMessage);
  }

  @override
  List<Object?> get props => [errorMessage];
}
