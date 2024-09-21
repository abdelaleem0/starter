import 'package:starter/common/domain/repositories/biometric_repository.dart';
import 'package:starter/data/preferences/preferences_helper.dart';

class BiometricRepositoryImpl implements BiometricRepository{
  final PreferencesHelper _preferencesHelper;

  BiometricRepositoryImpl(this._preferencesHelper);

  @override
  Future<void> deleteBiometric() async {
    await _preferencesHelper.deleteBiometric();
  }

  @override
  Future<void> setBiometric(bool canUseBiometric) async {
    await _preferencesHelper.setBiometric(canUseBiometric);
  }

  @override
  Future<bool> isBiometricEnabled() async {
    if(await _preferencesHelper.getBiometric()=="true"){
      return true;
    }else{
      return false;
    }
  }

}