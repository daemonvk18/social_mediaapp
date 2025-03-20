import 'package:social_mediaapp/features/auth/domain/models/app_user.dart';

class ProfileUser extends AppUser {
  final String? bio;
  final String? profileImageUrl;

  ProfileUser(
      {required super.uId,
      required super.email,
      required super.username,
      required this.bio,
      required this.profileImageUrl});
  //for creating a new object with slight modifications lets use copywith function
  ProfileUser copyWith({String? bio, String? profileImageUrl}) {
    return ProfileUser(
        uId: uId,
        email: email,
        username: username,
        bio: bio ?? "",
        profileImageUrl: profileImageUrl ?? "");
  }

//convert profileuser ---> json data
  Map<String, dynamic> toJsondata(ProfileUser profileuser) {
    return {
      'uid': profileuser.uId,
      'email': profileuser.email,
      'name': profileuser.username,
      'bio': profileuser.bio,
      'profileImageUrl': profileuser.profileImageUrl
    };
  }

//convert jsondata -----> profileuser
  factory ProfileUser.fromJson(Map<String, dynamic> jsondata) {
    return ProfileUser(
        uId: jsondata['uId'],
        email: jsondata['email'],
        username: jsondata['name'],
        bio: jsondata['bio'] ?? "",
        profileImageUrl: jsondata['profileImageUrl'] ?? "");
  }
}
