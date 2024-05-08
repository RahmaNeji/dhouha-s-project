import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Welcome to Tunisia Link ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "images/TunisiaApp.jpg",
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Welcome to our mobile app, where users can immerse themselves in the vibrant beauty of Tunisia. Explore stunning images of Tunisia's landscapes, culture, and heritage, or share your own experiences by posting additional photos. Join our community in celebrating this captivating country.",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
