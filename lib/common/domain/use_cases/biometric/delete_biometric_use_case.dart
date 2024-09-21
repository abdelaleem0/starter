import 'package:starter/common/domain/repositories/biometric_repository.dart';

class DeleteBiometricUseCase {
  final BiometricRepository _biometricRepository;

  DeleteBiometricUseCase(this._biometricRepository);

  Future<void> execute() async {
    await _biometricRepository.deleteBiometric();
  }
}