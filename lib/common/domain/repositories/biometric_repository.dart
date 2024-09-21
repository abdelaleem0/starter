abstract class BiometricRepository{
  Future<void> setBiometric(bool isBiometric);
  Future<void> deleteBiometric();
  Future<bool> isBiometricEnabled();
}