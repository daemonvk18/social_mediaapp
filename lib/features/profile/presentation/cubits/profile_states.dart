/*

PROFILE STATES 


*/

import 'package:social_mediaapp/features/profile/domain/entities/profile_user.dart';

abstract class ProfileStates {}

//initial state
class ProfileInitial extends ProfileStates {}

//laoding state
class ProfileLoading extends ProfileStates {}

//laoded state
class ProfileLoaded extends ProfileStates {
  final ProfileUser user;
  ProfileLoaded({required this.user});
}

//error state
class ProfileError extends ProfileStates {
  final String? message;
  ProfileError({this.message});
}
