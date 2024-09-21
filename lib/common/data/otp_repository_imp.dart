import 'package:starter/common/domain/models/otp.dart';
import 'package:starter/common/domain/repositories/otp_repository.dart';
import 'package:starter/data/preferences/shared_preferences_helper.dart';

class OTPRepositoryImp implements OTPRepository{
  final ShardPreferencesHelper _shardPreferencesHelper;

  OTPRepositoryImp(this._shardPreferencesHelper);
  @override
  Future<void> setOTP(OTP otp) async{
    try{
      await _shardPreferencesHelper.setOTP(otp);
    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Future<OTP?> getOTP() async{
    try{
     return  await _shardPreferencesHelper.getOTP();
    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteOTP() async{
    try{
      await _shardPreferencesHelper.deleteOTP();
    }catch(e){
      throw Exception(e);
    }
  }
}