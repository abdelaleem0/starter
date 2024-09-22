import 'package:starter/common/domain/use_cases/add_to_calender_usecase.dart';
import 'package:starter/common/domain/use_cases/delete_account_use_case.dart';
import 'package:starter/common/domain/use_cases/download_image_use_case.dart';
import 'package:starter/common/domain/use_cases/download_pdf_use_case.dart';
import 'package:starter/common/data/common_repository_imp.dart';
import 'package:starter/common/domain/repositories/common_repository.dart';
import 'package:starter/common/domain/use_cases/cached_user_data/delete_cached_user_data_use_case.dart';
import 'package:starter/common/domain/use_cases/cached_user_data/get_cached_user_data_use_case.dart';
import 'package:starter/common/domain/use_cases/cached_user_data/set_cached_user_data_use_case.dart';
import 'package:starter/common/domain/use_cases/delete_token_use_case.dart';
import 'package:starter/common/domain/use_cases/fcm_token_use_case.dart';
import 'package:starter/common/domain/use_cases/get_device_info_use_case.dart';
import 'package:starter/common/domain/use_cases/get_local_preferences_use_case.dart';
import 'package:starter/common/domain/use_cases/open_calendar_use_case.dart';
import 'package:starter/common/domain/use_cases/update_fcm_token_use_case.dart';
import 'package:starter/common/domain/use_cases/update_profile_picture_use_case.dart';
import 'package:starter/common/domain/use_cases/user/my_contact_info_use_case.dart';
import 'package:starter/common/utils/network_info.dart';

import 'package:starter/di/app_injector.dart';

class CommonDi {
  CommonDi._();

  static Future<void> initialize() async {
    injector.registerLazySingleton<CommonRepository>(
            () => CommonRepositoryImp(injector()));
    injector.registerFactory(() => GetLocalPreferencesUseCase(injector()));
    // injector.registerFactory(
    //         () => SetLocalPreferencesUseCase(injector(), injector()));
    // injector.registerFactory(() => WatermarkUseCase());

    injector.registerFactory(() => DeleteCachedUserUseCase(injector()));


    injector.registerFactory(() => FcmTokenUseCase());
    injector.registerFactory(() => UpdateFcmTokenUseCase(injector()));
    injector.registerFactory(() => MyContactInfoUseCase());

    injector.registerFactory(() => DeleteAccountUseCase(injector(), injector()));

    // cached user data
    injector.registerFactory(() => GetCachedUserDataUseCase(injector()));
    injector.registerFactory(() => SetCachedUserDataUseCase(injector()));
    injector.registerFactory(() => DeleteCachedUserDataUseCase(injector()));
    injector.registerFactory(() => GetDeviceInfoUseCase(injector()));
    injector.registerFactory(() => DownloadPdfUseCase(injector()));
    injector.registerFactory(() => DownloadImageUseCase(injector()));
    injector.registerFactory(() => UpdateProfilePictureUseCase(injector(), injector()));

    injector.registerFactory<NetworkInfo>(() => NetworkInfoImpl(injector()));

    //Singleton cuz just one instance can do it many times
    injector.registerLazySingleton(() => AddEventToCalenderUseCase());
    injector.registerLazySingleton(() => OpenCalendarUseCase());

  }
}

