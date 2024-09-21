import 'package:starter/common/domain/repositories/common_repository.dart';
import 'package:starter/common/utils/media_utils/media_utils.dart';
import 'package:starter/common/utils/media_utils/src/domain/models/attachment_entity.dart';

class UpdateProfilePictureUseCase {
  final CommonRepository _repository;
  final UploadAttachmentUseCase _uploadAttachmentUseCase;

  UpdateProfilePictureUseCase(this._repository, this._uploadAttachmentUseCase);

  Future<String> execute(Attachment? profilePicture) async {
    if(profilePicture != null){
      final uploadedAttachments = await _uploadAttachmentUseCase.execute(
        input: [profilePicture],
        uploadedFileModel: UploadFileModelEnum.postAttachment,
      );
      return await _repository.updateProfilePicture(uploadedAttachments.first.url);
    }
    return await _repository.updateProfilePicture("");
  }
}
