library media_utils;

import 'dart:async';
import 'dart:io';
import 'package:starter/common/domain/exceptions/exceptions.dart';
import 'package:starter/common/domain/exceptions/status_codes.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/constants.dart';
import 'package:starter/common/utils/exceptions.dart';
import 'package:starter/common/utils/extensions/extensions.dart';
import 'package:starter/common/utils/extensions/string.dart';
import 'package:starter/common/utils/media_utils/src/domain/models/attachment_entity.dart';
import 'package:starter/common/utils/media_utils/src/domain/use_case/compress/compressors/image_compression_use_case.dart';
import 'package:starter/common/utils/parse_utils.dart';
import 'package:starter/data/utils/graphql_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mime/mime.dart';
import 'package:image/image.dart' as im;
import 'package:pdfx/pdfx.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

import '../chain_of_tasks/chain_of_tasks.dart';
import 'src/data/models/attachment/api_attachment_input.dart';
import 'src/data/models/upload/api_upload_file_input.dart';
import 'src/data/models/upload/api_upload_result.dart';

part 'src/media_picker_utils/file_validation.dart';
part 'src/media_picker_utils/image_cropper_utils.dart';


part 'src/domain/models/video_source_input.dart';
part 'src/domain/models/upload/upload_input.dart';
part 'src/domain/models/upload/file_model_enum.dart';
part 'src/domain/models/picker_video_properties.dart';
part "src/domain/use_case/upload/upload_file_use_case.dart";
part "src/domain/use_case/upload/upload_attachment_use_case.dart";
part "src/domain/use_case/thumbnail/get_thumbnail/get_file_thumbnail_use_case.dart";
part "src/domain/use_case/compress/compressors/video_compression_use_case.dart";
part "src/domain/use_case/compress/attachment_compressor.dart";
part 'src/domain/use_case/thumbnail/get_thumbnail/get_video_thumbnail_use_case.dart';
part 'src/domain/use_case/thumbnail/attachment_thumbnail_grabber.dart';
part 'src/domain/use_case/get_file_page_number_use_case.dart';
part 'src/domain/repository/media_utils_repository.dart';

part 'src/manger/attachment_cache_manager.dart';

part 'src/data/models/attachment/api_attachment_type_enum.dart';
part 'src/data/models/attachment/api_attachment_result.dart';
part 'src/data/mapper/api_attachment_mapper.dart';
part 'src/data/repository/media_utils_repository_imp.dart';
part 'src/data/models/upload/api_file_model_enum.dart';
part 'src/data/graphql/media_utils_requests.dart';
