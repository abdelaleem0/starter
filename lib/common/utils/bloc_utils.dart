import 'dart:async';
import 'package:starter/common/domain/exceptions/status_codes.dart';
import 'package:starter/common/utils/network_info.dart';
import 'package:starter/di/app_injector.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:starter/common/domain/exceptions/exceptions.dart';
import 'package:starter/common/utils/common.dart';
import 'localization/common_localizer.dart';

Future<void> collect<T>({
  required Future<void> Function() task,
  void Function(String)? onError,
  void Function(dynamic)? catchError,
}) async {
  try {
    if (!(await injector<NetworkInfo>().hasConnection)) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (onError != null) {
        onError(CommonLocalizer.networkError);
      }
      return;
    }
    await task();
  } on ApiRequestException catch (e) {
    if (e.statusCode == StatusCodes.unauthorizedCode) {
      return;
    }

    if (onError != null && e.errorMessage.isNotEmpty) {
      onError(e.errorMessage);
    }
    if (catchError != null) {
      catchError(e);
    }
  } on ServerException catch (e) {
    if (onError != null) {
      onError(CommonLocalizer.serverError);
    }
    if (catchError != null) {
      catchError(e);
    }
  } on PaymentRequiredException catch (e) {
    if (onError != null) {
      onError("You need to subscribe first");
    }
    if (catchError != null) {
      catchError(e);
    }

  } catch (e) {
    logDebug(e);
    if (onError != null) {
      onError(CommonLocalizer.unexpectedError);
    }
    if (catchError != null) {
      catchError(e);
    }
  }
}
