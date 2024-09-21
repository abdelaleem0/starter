import 'package:starter/app/authentication/domain/models/inputs/complete_register_input.dart';
import 'package:starter/app/authentication/domain/use_case/complete_register_use_case.dart';
import 'package:starter/app/authentication/ui/complete_register/profile_picture/profile_picture_state.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/common/utils/media_utils/media_utils.dart';
import 'package:starter/common/utils/media_utils/src/domain/models/attachment_entity.dart';
import 'package:starter/di/app_injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePictureCubit extends Cubit<ProfilePictureState> {
  ProfilePictureCubit() : super(const ProfilePictureState.initial()) {
    _loadInjector();
  }

  late final CompleteRegisterUseCase _completeRegisterUseCase;
  late final UploadAttachmentUseCase _uploadAttachmentUseCase;

  void _loadInjector() {
    _completeRegisterUseCase = injector();
    _uploadAttachmentUseCase = injector();
  }

  Future<void> completeRegister(
      CompleteRegisterInput completeRegisterInput) async {
    emit(state.reduce(completeRegisterState: const Async.loading()));
    await collect(
      task: () async {
         List<Attachment>? uploadedAttachments;
        if(completeRegisterInput.profilePicture != null){
          uploadedAttachments  = await _uploadAttachmentUseCase.execute(
            input: [completeRegisterInput.profilePicture!],
            uploadedFileModel: UploadFileModelEnum.postAttachment,
          );
          completeRegisterInput = completeRegisterInput.modify(
            profilePicture: uploadedAttachments.first,
          );
        }
        final appUserModel =
            await _completeRegisterUseCase.execute(completeRegisterInput);
        emit(state.reduce(completeRegisterState: Async.success(appUserModel)));
      },
      onError: (errorMessage) {
        emit(state.reduce(completeRegisterState: Async.failure(errorMessage)));
      },
      catchError: (p0) {},
    );
    emit(state.reduce(completeRegisterState: const Async.initial()));
  }

  @override
  void emit(ProfilePictureState state) {
    if(!isClosed) {
      super.emit(state);
    }
  }
}
