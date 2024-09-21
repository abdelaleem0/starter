import 'package:starter/common/domain/repositories/biometric_repository.dart';

class IsBiometricEnabledUseCase{
  final BiometricRepository _biometricRepository;

  IsBiometricEnabledUseCase(this._biometricRepository);

  Future<bool> execute() async {
    return await _biometricRepository.isBiometricEnabled();
  }
}