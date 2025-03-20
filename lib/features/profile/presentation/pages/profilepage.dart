import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_mediaapp/features/auth/domain/models/app_user.dart';
import 'package:social_mediaapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_mediaapp/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_mediaapp/features/profile/presentation/cubits/profile_states.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //cubits
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  //current user
  late AppUser? appuser = authCubit.currentUser;

  //on start up
  @override
  void initState() {
    super.initState();
    profileCubit.fetchProfile(widget.uid);
  }

  //BUID UI
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(builder: (context, state) {
      if (state is ProfileLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      } else if (state is ProfileLoaded) {
        //get the current user
        final user = state.user;
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(CupertinoIcons.back)),
            title: Text(user.username),
          ),

          //BODY
          body: Center(
            child: Text('profile found....'),
          ),
        );
      } else {
        return const Center(
          child: Text('profile not found...'),
        );
      }
    });
  }
}
