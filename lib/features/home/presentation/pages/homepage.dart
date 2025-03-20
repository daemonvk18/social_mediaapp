import 'package:flutter/material.dart';
import 'package:social_mediaapp/features/home/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //scaffold
    return Scaffold(
      //appbar
      appBar: AppBar(
        title: Text('HOME'),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
      drawer: MyDrawer(),
    );
  }
}
