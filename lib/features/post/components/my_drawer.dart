import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_mediaapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_mediaapp/features/post/components/my_drawer_tile.dart';
import 'package:social_mediaapp/features/post/presentation/pages/homepage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            //lets leave some space on the top
            const SizedBox(
              height: 50,
            ),
            //lets put  a app logo here
            Icon(
              Icons.person,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),

            //leave some space here
            const SizedBox(
              height: 40,
            ),

            //home tile
            DrawerTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                title: 'H O M E',
                icon: Icons.home),

            //profile tile
            DrawerTile(
                onTap: () {}, title: 'P R O F I L E', icon: Icons.person),

            //search tile
            DrawerTile(onTap: () {}, title: 'S E A R C H', icon: Icons.search),

            //settings tile
            DrawerTile(
                onTap: () {}, title: 'S E T T I N G S', icon: Icons.settings),

            //logout tile
            DrawerTile(
                onTap: () {
                  context.read<AuthCubit>().logout();
                },
                title: 'L O G O U T',
                icon: Icons.logout)
          ],
        ),
      ),
    );
  }
}
