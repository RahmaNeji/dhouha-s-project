import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/login_page.dart';

class ForgetPassword extends StatelessWidget{
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
     TextEditingController email= TextEditingController() ;
      final auth = FirebaseAuth.instance;

     return  Scaffold(
      body:Column(
        children: [
          Text("Forget Password") ,
          Form(child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller:email ,
                ),
              ) ,

            ],

          )) ,
          ElevatedButton(onPressed: () async {
            await auth.sendPasswordResetEmail(email: email.text) ;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
            ) ;
          }, child: Text("send Mail"))

         ],
      )
      ,
    );
  }
}
