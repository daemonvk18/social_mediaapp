import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_mediaapp/features/auth/presentation/components/my_textfield.dart';
import 'package:social_mediaapp/features/profile/domain/entities/profile_user.dart';
import 'package:social_mediaapp/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_mediaapp/features/profile/presentation/cubits/profile_states.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //bio textfiled controller
  final TextEditingController bioTextController = TextEditingController();

  //update profile function...
  void updateProfile() async {
    //get the profile cubit first...
    final profilecubit = context.read<ProfileCubit>();
    if (bioTextController.text.isNotEmpty) {
      profilecubit.updateprofile(
          uid: widget.user.uId, newBio: bioTextController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(builder: (context, state) {
      //loading state
      if (state is ProfileLoading) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //text
                Text(
                  'Uploading....',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                )
              ],
            ),
          ),
        );
      }

      //loaded state
      return buildEditPage();
    }, listener: (context, state) {
      //if state is loaded then pop out of the page....
      if (state is ProfileLoaded) {
        Navigator.pop(context);
      }
    });
  }

  //build the edit page
  Widget buildEditPage({double uploadProgress = 0.0}) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              CupertinoIcons.back,
              color: Theme.of(context).colorScheme.primary,
            )),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          //save button
          IconButton(
              onPressed: updateProfile,
              icon: Icon(
                CupertinoIcons.cloud_upload,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: Column(
        children: [
          //profile picture....

          //bio....
          const Text('Bio...'),
          const SizedBox(
            height: 25,
          ),
          //bio textfiled...
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MyTextField(
                hintText: 'enter your bio...',
                obscureText: false,
                textController: bioTextController),
          )
        ],
      ),
    );
  }
}
