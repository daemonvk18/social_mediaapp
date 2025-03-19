/*

auth states -- declares authentication states 

*/

import 'package:social_mediaapp/features/auth/domain/models/app_user.dart';

abstract class AuthStates {}

//initial
class AuthInitial extends AuthStates {}

//loading......
class AuthLoading extends AuthStates {}

//authenticated
class Authauthenticated extends AuthStates {
  final AppUser? appuser;
  Authauthenticated({this.appuser});
}

//unathunticated
class Authunauthenticated extends AuthStates {}

//errors
class Autherrors extends AuthStates {
  final String? meesage;
  Autherrors({this.meesage});
}
