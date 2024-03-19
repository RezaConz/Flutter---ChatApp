import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../services/auth/auth_service.dart';
import '../pages/setting_page.dart';

class DrawerMain extends StatelessWidget {
  const DrawerMain({super.key});

  logout() {
    final _authService = AuthService();
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListTile(
                  title: Text('H O M E'),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListTile(
                  title: Text('S E T T I N G'),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: ListTile(
              title: Text('L O G O U T'),
              leading: Icon(Icons.logout),
              onTap: () {
                logout();
              },
            ),
          )
        ],
      ),
    );
  }
}
