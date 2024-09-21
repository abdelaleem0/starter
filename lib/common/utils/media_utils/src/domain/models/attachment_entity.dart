import 'package:starter/common/utils/real_time_timer_service.dart';
import 'package:starter/di/app_injector.dart';

class Attachment {
  final String id;
  String url;
  String? thumbnail;
  int? durationInSec;
  AttachmentType? type;

  Attachment({
    required this.id,
    required this.url,
    this.thumbnail,
    this.durationInSec,
    this.type,
  });

  Attachment modify({
    String? url,
    String? thumbnail,
    int? durationInSec,
    AttachmentType? type,
    String? id
  }) {
    return Attachment(
        url: url ?? this.url,
        thumbnail: thumbnail ?? this.thumbnail,
        durationInSec: durationInSec ?? this.durationInSec,
        type: type ?? this.type,
        id: id ?? this.id
    );
  }

  @override
  String toString() {
    return 'Attachment{url: $url, thumbnail: $thumbnail, durationInSec: $durationInSec, type: $type}';
  }

  static String get generateId => injector<RealTimeTimer>().getCurrentDateTime().microsecondsSinceEpoch.toString();
}

// ignore: constant_identifier_names
enum AttachmentType { DOCUMENT, VIDEO, PHOTO, SOUND, EMPTY }
