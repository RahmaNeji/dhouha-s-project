import 'package:flutter/material.dart';
import 'package:flutter_app/features/user_auth/service/database.dart';

class Details extends StatefulWidget {
  String image, name, description, documentId;
  bool favorite;
  Details({
    required this.documentId,
    required this.description,
    required this.image,
    required this.name,
    required this.favorite,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void _toggleFavoriteStatus() async {
    await DatabaseMethods().updateFavoriteStatus(
      widget.documentId,
      !widget.favorite,
    ); // Add userId here

    setState(() {
      widget.favorite = !widget.favorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                widget.image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "This is ${widget.name}",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            Text(
              "${widget.description}",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: _toggleFavoriteStatus,
              child: Text(
                  widget.favorite ? "Delete from Favorite" : "Add To Favorite"),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.favorite ? Colors.grey : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
