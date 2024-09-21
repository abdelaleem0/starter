import 'package:starter/common/domain/repositories/biometric_repository.dart';

class SetBiometricUseCase {
  final BiometricRepository _biometricRepository;

  SetBiometricUseCase(this._biometricRepository);

  Future<void> execute(bool isBiometric) async {
    await _biometricRepository.setBiometric(isBiometric);
  }
}