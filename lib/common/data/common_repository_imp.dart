import 'dart:io';
import 'package:starter/common/data/graphql/common_requests.dart';
import 'package:starter/common/data/models/api_update_profile_picture_result.dart';
import 'package:starter/common/data/models/update_fcm_token/api_update_fcm_token_result.dart';
import 'package:starter/common/domain/exceptions/exceptions.dart';
import 'package:starter/common/domain/exceptions/status_codes.dart';
import 'package:starter/common/domain/repositories/common_repository.dart';
import 'package:starter/common/utils/constants.dart';
import 'package:starter/data/utils/graphql_extensions.dart';
import 'package:starter/app/authentication/data/models/login/api_login_input.dart';
import 'package:starter/app/authentication/data/models/logout/api_logout_input.dart';
import 'package:starter/app/authentication/data/models/logout/api_logout_result.dart';
import 'package:dio/dio.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class CommonRepositoryImp implements CommonRepository {
  final GraphQLClient _graphQLClient;

  CommonRepositoryImp(this._graphQLClient);

  @override
  Future<void> logout() async {
    final result = await _graphQLClient.perform(
        mutation: logoutMutation,
        variables: ApiLogoutInput(getDeviceType()).toJson());
    if (result.hasException || result.data == null) {
      throw const ServerException();
    } else {
      final request = ApiLogoutData.fromJson(result.data!).logout;

      if (request?.code == StatusCodes.success) {
        return;
      } else {
        throw ApiRequestException(
            request?.code ?? StatusCodes.unknown, request?.message ?? "");
      }
    }
  }

/*  @override
  Future<String> uploadFile(UploadInput input) async {
    final result = await _graphQLClient.perform(
        mutation: uploadMutation,
        variables: (await input.map()).toJson()
    );
    if (result.hasException || result.data == null) {
      throw const ServerException();
    } else {
      final request = UploadFileResult.fromJson(result.data!).uploadFile;

      if (request?.code == StatusCodes.success) {
        return request?.data ?? "";
      } else {
        throw ApiRequestException(
            request?.code ?? StatusCodes.unknown,
            request?.message ?? ""
        );
      }
    }
  }*/

  @override
  Future<void> updateFcmToken(String fcmToken) async {
    final DeviceEnum device;
    if (Platform.isIOS) {
      device = DeviceEnum.IOS;
    } else {
      device = DeviceEnum.ANDROID;
    }
    final result = await _graphQLClient
        .perform(mutation: updateFcmTokenMutation, variables: {
      "fcmToken": fcmToken,
      "device": device.name,
    });
    if (result.hasException || result.data == null) {
      throw const ServerException();
    } else {
      final request =
          UpdateFcmTokenResult.fromJson(result.data!).updateFcmToken;

      if (request?.code == StatusCodes.success) {
        return;
      } else {
        throw ApiRequestException(
          request?.code ?? StatusCodes.unknown,
          request?.message ?? "",
        );
      }
    }
  }

  @override
  Future<void> downloadImage(String sketchIdentifier, String id) async {
    var appTemDir = await getTemporaryDirectory();

    String savePath = "${appTemDir.path}/$sketchIdentifier${"/temp"}.png";

    final response = await Dio()
        .download(Constants.baseUrl + sketchIdentifier + (id), savePath);
    if (response.statusCode == StatusCodes.success) {
      final pngFile = File(savePath);
      if (pngFile.existsSync()) {
        await ImageGallerySaver.saveFile(savePath, name:"${id==''?const Uuid().v4():id}.png");

        // await DocumentFileSavePlus().saveFile(
        //     await pngFile.readAsBytes(), "${id==''?const Uuid().v4():id}.png", "application/png");
      }
    } else {
      throw ApiRequestException(response.statusCode ?? StatusCodes.unknown,
          "Failed to download image"); //Todo(Add Localization)
    }
  }

  @override
  Future<void> downloadPdf(String sketchIdentifier, String id) async {
    var appTemDir = await getTemporaryDirectory();

    String savePath = "${appTemDir.path}/$sketchIdentifier${"/temp"}.pdf";

    final response = await Dio()
        .download(Constants.baseUrl + sketchIdentifier + (id), savePath);
    if (response.statusCode == StatusCodes.success) {
      final pdfFile = File(savePath);
      if (pdfFile.existsSync()) {
        await DocumentFileSavePlus().saveFile(
            await pdfFile.readAsBytes(), "${id==''?const Uuid().v4():id}.pdf", "application/pdf");
      }
    } else {
      throw ApiRequestException(response.statusCode ?? StatusCodes.unknown,
          "Failed to download pdf"); //Todo(Add Localization)
    }
  }

  @override
  Future<void> deleteAccount() async {
    final request = await _graphQLClient.perform(
      mutation: deleteAccountMutation,
    );
    if (request.hasException || request.data == null) {
      throw const ServerException();
    } else if (request.data?['deleteAccount']['code'] != StatusCodes.success) {
      throw ApiRequestException(
          request.data?['deleteAccount']['code'] ?? StatusCodes.unknown,
          request.data?['deleteAccount']['message'] ?? "");
    }
    return;
  }

  @override
  Future<String> updateProfilePicture(String? profilePicture) async {
    final request = await _graphQLClient
        .fetch(query: updateProfilePictureMutation, variables: {
      "input": {"profilePicture": profilePicture}
    });
    if (request.hasException || request.data == null) {
      throw const ServerException();
    } else {
      final result = ApiUpdateProfilePictureResult.fromJson(request.data!)
          .updateProfilePicture;
      if (result?.code == StatusCodes.success && result?.data != null) {
        final updatedImage= result?.data?.profilePicture ?? '';
        return (updatedImage=='') ? "": Constants.concatWithBaseUrl(updatedImage);
      } else {
        throw ApiRequestException(
            result?.code ?? StatusCodes.unknown, result?.message ?? "");
      }
    }
  }




}