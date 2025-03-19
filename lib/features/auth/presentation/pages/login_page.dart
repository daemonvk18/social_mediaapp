/*

on this page the user can directly login using the email,pw

--------------------------------------------------------

once the user logins they will be directed to the home page

if the user doesnot have an account they can go to the  registerpage and register their account 

*/

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_mediaapp/features/auth/presentation/components/my_login_button.dart';
import 'package:social_mediaapp/features/auth/presentation/components/my_textfield.dart';
import 'package:social_mediaapp/features/auth/presentation/cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final pwController = TextEditingController();

//BUILD UI
  @override
  Widget build(BuildContext context) {
    //get the height and widht of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    final screenWidth = MediaQuery.of(context).size.width;

    //login method
    void loginmethod() {
      //first grab the email,pw
      final String email = emailTextController.text;
      final String pw = pwController.text;

      //grab the auth cubit
      final authcubit = context.read<AuthCubit>();

      //first ensure that the email,password fields are not empty
      if (email.isNotEmpty && pw.isNotEmpty) {
        //then we can login
        authcubit.loginmethod(email, pw);
      }
      //display errors if some errors is oocured
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('failed to login')));
      }
    }

    @override
    void dispose() {
      emailTextController.dispose();
      pwController.dispose();
      super.dispose();
    }

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
                height: screenHeight * 0.1,
              ),
              //lets start of with a icon
              Icon(
                Icons.lock_open_rounded,
                size: screenHeight * 0.15,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              //welcome msg
              Text(
                "Welcome back, you have been missed!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),

              SizedBox(
                height: screenHeight * 0.02,
              ),
              //couple of textfields for email,pw
              MyTextField(
                  hintText: 'email',
                  obscureText: false,
                  textController: emailTextController),

              MyTextField(
                  hintText: 'password',
                  obscureText: true,
                  textController: pwController),

              SizedBox(
                height: screenHeight * 0.04,
              ),
              //login button
              LoginButton(
                  text: 'Signin',
                  onTap: () {
                    loginmethod();
                  }),

              SizedBox(
                height: screenHeight * 0.02,
              ),
              //not a member? go to register page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      ' register now',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold),
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
