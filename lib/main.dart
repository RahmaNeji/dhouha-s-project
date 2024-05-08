import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/app/splash_screen/splash_screen.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter_app/provider/provider.dart';
import 'package:provider/provider.dart';



Future <void> main() async  {

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions (
          apiKey: "AIzaSyArye7_sKXtsblBCqOgnx3hJkxH5A61fJw",
          appId: "1:217434296077:android:5637a0c2d3b253f1aa6a44",
          messagingSenderId: "217434296077",
          projectId: "flutteryarabbiyemchi",),
    );
  }else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)  => UiProvider()..init() ,
      child: Consumer <UiProvider>(
        builder: (context , UiProvider notifier, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              themeMode: notifier.isDark? ThemeMode.dark : ThemeMode.light,
              darkTheme: notifier.isDark? notifier.darkTheme : notifier.lightTheme ,
              home: SplashScreen(
                child : LoginPage() ,
              )
      
          );
        }
      ),
    );
  }
}
