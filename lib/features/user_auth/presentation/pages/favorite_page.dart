import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/user_auth/presentation/widgets/drawer.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Stream<List<DocumentSnapshot>> favoritePlacesStream = Stream.value([]);

  @override
  void initState() {
    super.initState();
    loadFavoritePlaces();
  }

  void loadFavoritePlaces() {
    List<DocumentSnapshot> favoritePlaces = [];

    List<String> collectionNames = [
      'Tunis',
      'Tozeur',
      'Sousse',
      'Nabeul',
      'Mahdia',
      'Bizerte'
    ];

    collectionNames.forEach((collection) {
      FirebaseFirestore.instance
          .collection(collection)
          .where('Favorite', isEqualTo: true)
          .get()
          .then((querySnapshot) {
        favoritePlaces.addAll(querySnapshot.docs);

        setState(() {
          favoritePlacesStream = Stream.value(favoritePlaces);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Favorite Places'),
      ),
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: favoritePlacesStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> favoritePlaces = snapshot.data!;
            if (favoritePlaces.isNotEmpty) {
              return ListView.builder(
                itemCount: favoritePlaces.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot place = favoritePlaces[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(place['Image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place['Name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                place['Description'],
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No favorite places found.'),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
