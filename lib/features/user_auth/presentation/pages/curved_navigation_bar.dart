import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/add_page.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/favorite_page.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/home_page.dart';
import 'package:provider/provider.dart';
import '../../../../provider/provider.dart';

class MainPage extends StatefulWidget {
  final String userId; 
  const MainPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
   late List<Widget> _pages;

  int _currentIndex = 0;

  get googleSignIn => null;

  @override
  void initState() {
   _pages = [
      HomePage(userId: widget.userId),
      AddPage(userId: widget.userId),
      FavoritePage(userId: widget.userId),
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(builder: (context, notifier, child) {
      return Scaffold(
        backgroundColor: notifier.isDark ? Colors.black : Colors.white,
        body: _pages[_currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color.fromARGB(255, 5, 120, 120),
          animationDuration: Duration(milliseconds: 300),
          items: [
            Icon(Icons.home),
            Icon(Icons.add),
            Icon(Icons.favorite),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      );
    });
  }
}
