import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_mediaapp/features/profile/data/firebase_profile_user.dart';
import 'package:social_mediaapp/features/profile/presentation/cubits/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileUserImpl profileRepo;
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  //fetch the current user profile data
  Future<void> fetchProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);
      if (user != null) {
        emit(ProfileLoaded(user: user));
      } else {
        emit(ProfileError(message: 'user not found'));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  //update the current user profile data
  Future<void> updateprofile({required String uid, String? newBio}) async {
    emit(ProfileLoading());
    try {
      //first get the current user
      final currentUser = await profileRepo.fetchUserProfile(uid);
      if (currentUser == null) {
        emit(ProfileError(message: 'no current user found'));
        //there is no current user return null
        return;
      }
      //profile picture update

      //update the profile
      final updatedProfile =
          await currentUser.copyWith(bio: newBio ?? currentUser.bio);

      //update the profile repo
      await profileRepo.updateProfile(updatedProfile);
      //now again re-fetch the updated profile
      await fetchProfile(uid);
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
