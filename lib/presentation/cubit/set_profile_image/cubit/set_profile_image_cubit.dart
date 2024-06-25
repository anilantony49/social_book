import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';

part 'set_profile_image_state.dart';

class SetProfileImageCubit extends Cubit<SetProfileImageState> {
  SetProfileImageCubit() : super(SetProfileImageInitial());
  void setProfileImage(List<AssetEntity> selectedImage) {
    emit(SetProfileImageSuccessState(selectedImage: selectedImage));
  }

  void resetState() {
    emit(SetProfileImageInitial());
  }
}
