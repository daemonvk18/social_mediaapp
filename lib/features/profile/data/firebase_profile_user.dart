import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_mediaapp/features/profile/domain/entities/profile_user.dart';
import 'package:social_mediaapp/features/profile/domain/repository/profile_user_repo.dart';

class ProfileUserImpl implements ProfileUserRepo {
  //intialize the firebase and get the current user
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      final userDoc =
          await firebaseFirestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          return ProfileUser(
              uId: uid,
              email: userData['email'],
              username: userData['name'],
              bio: userData['bio'] ?? "",
              profileImageUrl: userData['profileImageUrl'].toString());
        }
      }
      return null;
    } catch (e) {
      throw Exception('$e');
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updateprofile) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(updateprofile.uId)
          .update({
        'bio': updateprofile.bio,
        'profileImageUrl': updateprofile.profileImageUrl,
      });
    } catch (e) {
      throw Exception('$e');
    }
  }
}
