import 'package:social_mediaapp/features/profile/domain/entities/profile_user.dart';

abstract class ProfileUserRepo {
  //we will have methods to getdata,update bio,update profileimage
  Future<ProfileUser?> fetchUserProfile(String uid);
  Future<void> updateProfile(ProfileUser updateprofile);
}
