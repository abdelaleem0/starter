// ignore: depend_on_referenced_packages
// ignore_for_file: constant_identifier_names

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show MultipartFile;
import 'package:json_annotation/json_annotation.dart';

import '../../../../media_utils.dart';

part 'api_upload_file_input.g.dart';

@JsonSerializable()
class ApiUploadFileInput {
  @MultipartJsonConverter()
  final MultipartFile file;

  final ApiFileModelEnum model;

  factory ApiUploadFileInput.fromJson(Map<String, dynamic> json) =>
      _$ApiUploadFileInputFromJson(json);

  ApiUploadFileInput(this.file, this.model);

  Map<String, dynamic> toJson() => _$ApiUploadFileInputToJson(this);
}

class MultipartJsonConverter implements JsonConverter<MultipartFile, dynamic> {
  const MultipartJsonConverter();

  @override
  MultipartFile fromJson(json) {
    throw "";
  }

  @override
  toJson(MultipartFile object) {
    return object;
  }
}
