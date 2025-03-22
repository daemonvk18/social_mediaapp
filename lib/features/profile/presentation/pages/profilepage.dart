import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_mediaapp/features/auth/domain/models/app_user.dart';
import 'package:social_mediaapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_mediaapp/features/profile/presentation/components/bio_text_box.dart';
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
              centerTitle: true,
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    CupertinoIcons.back,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              actions: [
                //update profile button(settings)
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.settings,
                      color: Theme.of(context).colorScheme.primary,
                    ))
              ],
              title: Text(
                user.username,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),

            //BODY
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //email at the begining
                  Text(
                    user.email,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //showcase the profile picture
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12)),
                    height: 120,
                    width: 120,
                    padding: const EdgeInsets.all(25),
                    child: Icon(
                      Icons.person,
                      size: 72,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //show the container for bio
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        //bio text
                        Text(
                          'Bio',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //bio text box
                  BioTextBox(text: user.bio.toString()),
                  //posts section
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 25),
                    child: Row(
                      children: [
                        //bio text
                        Text(
                          'Posts',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      } else {
        return const Center(
          child: Text('profile not found...'),
        );
      }
    });
  }
}
