
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Setting',
            style: TextStyle(
              color: Colors.white, // Couleur du texte en blanc
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(
                  Icons.settings, // Icône pour les paramètres
                  color: Colors.white, // Couleur de l'icône en blanc
                ),
              );
            },
          ),
          backgroundColor: Color.fromARGB(255, 5, 120, 120),
        ),
        //drawer: CustomDrawer(),
      body: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.dark_mode,
                  color: Colors.black,
                ),
                title: const Text("Dark theme"),
                trailing: Switch(
                  value: notifier.isDark,
                  onChanged: (value) => notifier.changeTheme(),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}