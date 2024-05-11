import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/user_auth/presentation/pages/details.dart';
import 'package:flutter_app/features/user_auth/presentation/widgets/drawer.dart';
import 'package:flutter_app/features/user_auth/service/database.dart';

class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool tunis = false,
      tozeur = false,
      sousse = false,
      nabeul = false,
      mahdia = false,
      bizerte = false,
      sidiBouzid = false,
      manouba = false;

  Stream? placeItemStream;
  onetheload() async {
    placeItemStream = await DatabaseMethods().getPlaceItem("Tunis");
    setState(() {});
  }

  @override
  void initState() {
    onetheload();
    super.initState();
  }

  Widget allItems() {
    return StreamBuilder(
      stream: placeItemStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Container(
                height: MediaQuery.of(context).size.height * .63,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details(
                                  documentId: ds.id,
                                  description: ds["Description"],
                                  image: ds["Image"],
                                  name: ds["Name"],
                                  favorite: ds["Favorite"],
                                ),
                              ),
                            );
                          },
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      ds["Image"],
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          ds["Name"],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(ds["Description"]),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          ds["Favorite"]
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: ds["Favorite"]
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onPressed: () async {
                                          await DatabaseMethods()
                                              .updateFavoriteStatus(
                                                  ds.id, !ds["Favorite"]);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        ),
                                        onPressed: () async {
                                          await DatabaseMethods()
                                              .deletePlaceItem(ds.id);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              )
            : CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Beautiful Tunisia ",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
      drawer: MyDrawer(),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "  Discover Great Place",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            showItem(),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            allItems()
          ],
        ),
      ),
    );
  }

  Widget showItem() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                tunis = true;
                tozeur = false;
                sousse = false;
                nabeul = false;
                mahdia = false;
                bizerte = false;
                manouba = false;
                sidiBouzid = false;
                placeItemStream = await DatabaseMethods().getPlaceItem("Tunis");
                setState(() {});
              },
              child: Material(
                color: Colors.transparent,
                elevation: 10,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration:
                      BoxDecoration(color: tunis ? Colors.grey : Colors.white),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "images/tunis.jpg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text("Tunis")
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                tunis = false;
                tozeur = true;
                sousse = false;
                nabeul = false;
                mahdia = false;
                bizerte = false;
                manouba = false;
                sidiBouzid = false;
                placeItemStream =
                    await DatabaseMethods().getPlaceItem("Tozeur");

                setState(() {});
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration:
                      BoxDecoration(color: tozeur ? Colors.grey : Colors.white),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "images/tozeur.jpg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text("Tozeur")
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                tunis = false;
                tozeur = false;
                sousse = true;
                nabeul = false;
                mahdia = false;
                bizerte = false;
                manouba = false;
                sidiBouzid = false;
                placeItemStream =
                    await DatabaseMethods().getPlaceItem("Sousse");
                setState(() {});
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration:
                      BoxDecoration(color: sousse ? Colors.grey : Colors.white),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "images/sousse.jpg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text("Sousse")
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                tunis = false;
                tozeur = false;
                sousse = false;
                nabeul = true;
                mahdia = false;
                bizerte = false;
                manouba = false;
                sidiBouzid = false;
                placeItemStream =
                    await DatabaseMethods().getPlaceItem("Nabeul");
                setState(() {});
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration:
                      BoxDecoration(color: nabeul ? Colors.grey : Colors.white),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "images/nabeul.jpg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text("Nabeul")
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                tunis = false;
                tozeur = false;
                sousse = false;
                nabeul = false;
                mahdia = true;
                bizerte = false;
                manouba = false;
                sidiBouzid = false;
                placeItemStream =
                    await DatabaseMethods().getPlaceItem("Mahdia");
                setState(() {});
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration:
                      BoxDecoration(color: mahdia ? Colors.grey : Colors.white),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "images/mahdia.jpg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text("Mahdia")
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                tunis = false;
                tozeur = false;
                sousse = false;
                nabeul = false;
                mahdia = false;
                bizerte = true;
                manouba = false;
                sidiBouzid = false;
                placeItemStream =
                    await DatabaseMethods().getPlaceItem("Bizerte");
                setState(() {});
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration: BoxDecoration(
                      color: bizerte ? Colors.grey : Colors.white),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "images/bizerte.jpg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text("Bizerte"),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                tunis = false;
                tozeur = false;
                sousse = false;
                nabeul = false;
                mahdia = false;
                bizerte = false;
                manouba = true;
                sidiBouzid = false;
                placeItemStream =
                    await DatabaseMethods().getPlaceItem("Manouba");
                setState(() {});
              },
              child: Material(
                color: Colors.transparent,
                elevation: 10,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration:
                      BoxDecoration(color: tunis ? Colors.grey : Colors.white),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "images/manouba.jpg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text("La Manouba")
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                tunis = false;
                tozeur = false;
                sousse = false;
                nabeul = false;
                mahdia = false;
                bizerte = false;
                manouba = false;
                sidiBouzid = true;
                placeItemStream =
                    await DatabaseMethods().getPlaceItem("SidiBouzid");
                setState(() {});
              },
              child: Material(
                color: Colors.transparent,
                elevation: 10,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration:
                      BoxDecoration(color: tunis ? Colors.grey : Colors.white),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "images/sidiBouzid.jpg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text("Sidi Bouzid")
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
