/*

appuser_repo------basically outlines the auth operations of this application

*/

import 'package:social_mediaapp/features/auth/domain/models/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> logininWithemailPassword(String email, String password);
  Future<AppUser?> registerWithemailPassword(
      String email, String password, String username);
  Future<void> logout();
  //lets for the future use also create a function of the current user
  Future<AppUser?> getCurrentUser();
}
