/*

AUTH PAGE: this page determines which page to open(login or register)

*/

import 'package:flutter/material.dart';
import 'package:social_mediaapp/features/auth/presentation/pages/login_page.dart';
import 'package:social_mediaapp/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //intially show login page
  bool showLoginPage = true;
  //toggle between pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: () {
          togglePages();
        },
      );
    } else {
      return RegisterPage(
        onTap: () {
          togglePages();
        },
      );
    }
  }
}
