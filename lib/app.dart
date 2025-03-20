/*

app.dart - this is the root level of our app

-------------------------------------------------------------

Repositories for the database - firebase

Bloc Providers - state managmenet
-auth
-profile
-post
-search
-theme

check the auth state:

unauthenticated - we will move to the auth page
authenticated - we will move to the home page

*/

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_mediaapp/features/auth/data/firebase_auth_repo.dart';
import 'package:social_mediaapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_mediaapp/features/auth/presentation/cubits/auth_states.dart';
import 'package:social_mediaapp/features/auth/presentation/pages/auth_page.dart';
import 'package:social_mediaapp/features/home/presentation/pages/homepage.dart';
import 'package:social_mediaapp/features/profile/data/firebase_profile_user.dart';
import 'package:social_mediaapp/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_mediaapp/themes/light_mode_theme.dart';

class MyApp extends StatelessWidget {
  final authrepo = FirebaseAuthRepo();
  final profilerepo = ProfileUserImpl();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //auth cubit
        BlocProvider(
            create: (context) =>
                AuthCubit(authRepo: authrepo)..checkAuthenticated()),
        //profile cubit
        BlocProvider(
            create: (context) => ProfileCubit(profileRepo: profilerepo))
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: lighttheme,
        home:
            BlocConsumer<AuthCubit, AuthStates>(builder: (context, authstate) {
          print(authstate);
          //return widget based on the bloc state

          //if we are unauthenticated return authpage
          if (authstate is Authunauthenticated) {
            return const AuthPage();
          }
          //if we are -> authenticated
          if (authstate is Authauthenticated) {
            return HomePage();
          }

          //loading state
          else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }, listener: (context, authstate) {
          //do stuff here based on the authstate
          if (authstate is Autherrors) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(authstate.meesage.toString())));
          }
        }),
      ),
    );
  }
}
