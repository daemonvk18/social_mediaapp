import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_mediaapp/features/auth/presentation/components/my_login_button.dart';
import 'package:social_mediaapp/features/auth/presentation/components/my_textfield.dart';
import 'package:social_mediaapp/features/auth/presentation/cubits/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailTextController = TextEditingController();
  final pwController = TextEditingController();
  final confirmpwController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailTextController.dispose();
    pwController.dispose();
    confirmpwController.dispose();
  }

  //register method
  void register() {
    //first get the email.pw,confirmpw
    final String username = usernameController.text;
    final String email = emailTextController.text;
    final pw = pwController.text;
    final cnfrmpw = confirmpwController.text;

    //get the authcubit
    final authcubit = context.read<AuthCubit>();

    //now check whether the email,pw,cnfrmpw are not empty
    if (username.isNotEmpty &&
        email.isNotEmpty &&
        pw.isNotEmpty &&
        cnfrmpw.isNotEmpty) {
      //check if the pw and cnfrmpwa are equal or not
      if (pw == cnfrmpw) {
        //then we can register
        authcubit.register(email, pw, usernameController.text);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("your password doesn't match with confirm password")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("failed to Signup")));
    }
  }

//BUILD UI
  @override
  Widget build(BuildContext context) {
    //get the height and widht of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    final screenWidth = MediaQuery.of(context).size.width;
    //return SCAFFOLD
    return Scaffold(
        //BODY
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //lets give some space up here
              SizedBox(
                height: screenHeight * 0.05,
              ),
              //lets start of with a icon
              Icon(
                Icons.lock_open_rounded,
                size: screenHeight * 0.13,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              //welcome msg
              Text(
                "Let's create an account for you!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),

              SizedBox(
                height: screenHeight * 0.02,
              ),
              //couple of textfields for username,email,pw
              MyTextField(
                  hintText: 'username',
                  obscureText: false,
                  textController: usernameController),
              MyTextField(
                  hintText: 'email',
                  obscureText: false,
                  textController: emailTextController),

              MyTextField(
                  hintText: 'password',
                  obscureText: true,
                  textController: pwController),
              MyTextField(
                  hintText: 'confirm passsord',
                  obscureText: true,
                  textController: confirmpwController),

              SizedBox(
                height: screenHeight * 0.04,
              ),
              //login button
              LoginButton(
                  text: 'Signup',
                  onTap: () {
                    register();
                  }),

              SizedBox(
                height: screenHeight * 0.02,
              ),
              //not a member? go to register page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      ' Signin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
