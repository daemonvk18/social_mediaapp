/*

Firebase_auth_repo implements the possible auth operations here

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_mediaapp/features/auth/domain/models/app_user.dart';
import 'package:social_mediaapp/features/auth/domain/repository/appuser_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final FirebaseFirestore fireBaseFirestore = FirebaseFirestore.instance;
  @override
  Future<AppUser?> getCurrentUser() async {
    //get current user from the firebase auth
    final currentuser = firebaseauth.currentUser;
    //we need to check some conditions before returning the user
    // ignore: unnecessary_null_comparison
    if (currentuser == null) {
      return null;
    }
    //if user exists
    return AppUser(
        uId: currentuser.uid, email: currentuser.email!, username: "");
  }

  @override
  Future<AppUser?> logininWithemailPassword(
      String email, String password) async {
    try {
      //attempt the sign in
      UserCredential userCredential = await firebaseauth
          .signInWithEmailAndPassword(email: email, password: password);
      //once we have signed in we will create our user
      AppUser appUser =
          AppUser(uId: userCredential.user!.uid, email: email, username: '');
      //return the user
      return appUser;
    } catch (e) {
      throw Exception('login failed:$e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseauth.signOut();
    } catch (e) {
      throw Exception('log out failed: $e');
    }
  }

  @override
  Future<AppUser?> registerWithemailPassword(
      String email, String password, String username) async {
    try {
      //attempt to sign up
      UserCredential userCredential = await firebaseauth
          .createUserWithEmailAndPassword(email: email, password: password);
      //create user
      AppUser appUser = AppUser(
          uId: userCredential.user!.uid, email: email, username: username);

      //before returning the user lets save the data of the user
      await fireBaseFirestore
          .collection('users')
          .doc(appUser.uId)
          .set(appUser.toJson());
      //return user
      return appUser;
    } catch (e) {
      throw Exception('sign up failed: $e');
    }
  }
}
