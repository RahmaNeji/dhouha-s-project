import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/about_page.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/profile_page.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 5, 120, 120),
            ),
            child: Image.asset(
              'images/TunisiaApp.jpg',
              width: 1500,
              height: 1500,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SettingsPage())),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfilePage())),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AboutPage())),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await _auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
