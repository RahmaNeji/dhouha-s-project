import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/curved_navigation_bar.dart';
import 'package:flutter_app/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter_app/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter_app/global/common/toast.dart';
import 'package:flutter_app/provider/provider.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
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
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Image.asset('images/TunisiaApp.jpg'),

                      const SizedBox(
                        height: 18,
                      ),
                      FormContainerWidget(
                        controller: _usernameController,
                        hintText: "User Name",
                        isPasswordField: false,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      FormContainerWidget(
                        controller: _emailController,
                        hintText: "Email",
                        isPasswordField: false,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      FormContainerWidget(
                        controller: _passwordController,
                        hintText: "Password",
                        isPasswordField: true,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      GestureDetector(
                        onTap: _signUp,
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 44, 147, 202),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          const SizedBox(
                            width: 5,
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              " Login ",
                              style: TextStyle(
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ));
    });
  }

  void _signUp() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Vérifier si tous les champs sont remplis
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      showToast(message: "Veuillez remplir tous les champs.");
      return;
    }

    // Vérifier si l'email est valide
    if (!isValidEmail(email)) {
      showToast(message: "Veuillez saisir une adresse e-mail valide.");
      return;
    }

    // Vérifier si le mot de passe est suffisamment long
    if (password.length < 6) {
      showToast(
          message: "Le mot de passe doit contenir au moins 6 caractères.");
      return;
    }

    // Appeler la méthode signUpWithEmailAndPassword
    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      showToast(message: "Utilisateur créé avec succès");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      showToast(
          message:
              "Une erreur s'est produite lors de la création de l'utilisateur.");
    }
  }

  bool isValidEmail(String email) {
    // Utiliser une expression régulière pour valider l'adresse e-mail
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
