/*

AUTH CUBIT - state management

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_mediaapp/features/auth/domain/models/app_user.dart';
import 'package:social_mediaapp/features/auth/domain/repository/appuser_repo.dart';
import 'package:social_mediaapp/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;
  AppUser? _currentUser;
  //in the super section we need to mention the intial state-AuthInitial
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  //check if the user is already authenticated
  void checkAuthenticated() async {
    final AppUser? appuser = await authRepo.getCurrentUser();
    if (appuser != null) {
      _currentUser = appuser;
      emit(Authauthenticated(appuser: appuser));
    } else {
      emit(Authunauthenticated());
    }
  }

  //get the current user
  AppUser? get currentUser => _currentUser;

  //login with email+pw
  Future<void> loginmethod(String email, String pw) async {
    try {
      //intially in the loading state
      emit(AuthLoading());
      final user = await authRepo.logininWithemailPassword(email, pw);
      if (user != null) {
        _currentUser = user;
        emit(Authauthenticated(appuser: user));
      } else {
        emit(Authunauthenticated());
      }
    } catch (e) {
      emit(Autherrors(meesage: e.toString()));
      emit(Authunauthenticated());
    }
  }

  //register with email+pw+username
  Future<void> register(String email, String pw, String username) async {
    try {
      emit(AuthLoading());
      final user =
          await authRepo.registerWithemailPassword(email, pw, username);
      if (user != null) {
        _currentUser = user;
        emit(Authauthenticated(appuser: user));
      } else {
        emit(Authunauthenticated());
      }
    } catch (e) {
      emit(Autherrors(meesage: e.toString()));
      emit(Authunauthenticated());
    }
  }

  //logout
  Future<void> logout() async {
    authRepo.logout();
    emit(Authunauthenticated());
  }
}
