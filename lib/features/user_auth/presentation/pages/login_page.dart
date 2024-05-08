import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/curved_navigation_bar.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/forget_password_page.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:flutter_app/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter_app/global/common/toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../../../provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, UiProvider notifier, child) {
      return Scaffold(
        backgroundColor: notifier.isDark ? Colors.black : Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('images/TunisiaApp.png'),
                  FormContainerWidget(
                    controller: _emailController,
                    hintText: "Email",
                    isPasswordField: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormContainerWidget(
                    controller: _passwordController,
                    hintText: "Password",
                    isPasswordField: true,
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword()),
                              (route) => false,
                            );
                          },
                          child: Text(
                            "Forget Password ?",
                            style: TextStyle(color: Colors.grey),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: _signIn,
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 44, 147, 202),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: _signInWithGoogle,
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 250, 210, 30),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Sign In With Google",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Vérifier si tous les champs sont remplis
    if (email.isEmpty || password.isEmpty) {
      showToast(message: "Veuillez remplir tous les champs.");
      return;
    }

    // Vérifier si l'email est valide
    if (!isValidEmail(email)) {
      showToast(message: "Veuillez saisir une adresse e-mail valide.");
      return;
    }

    // Appeler la méthode signInWithEmailAndPassword
    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      showToast(message: "Utilisateur connecté avec succès");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      showToast(
          message:
              "Une erreur s'est produite lors de la connexion de l'utilisateur.");
    }
  }

  bool isValidEmail(String email) {
    // Utiliser une expression régulière pour valider l'adresse e-mail
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.signOut();
      }
      if (_googleSignIn.currentUser != null) {
        await _googleSignIn.disconnect();
      }
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      } else {}
    } catch (e) {
      showToast(message: "some error occured $e");
    }
  }
}
