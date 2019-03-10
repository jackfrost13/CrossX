import 'package:flutter/material.dart';
import 'place_card.dart';
import 'places_details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Indian Heritage"),
        backgroundColor: Colors.transparent,elevation: 0.01,
      ),
      body: bodyWidget(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            places.shuffle();
          });
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.refresh,
          color: Colors.green,
        ),
      ),
    );
  }
}

Widget bodyWidget(BuildContext context) {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      Image.network(
        'https://images.mapsofindia.com/my-india/2014/07/top-10-world-heritage-sites-in-india.jpg',
        fit: BoxFit.cover,
      ),
      GridView.count(
        crossAxisCount: 2,
        children: places
            .map((place) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlaceCard(
                                    place: place,
                                  )));
                    },
                    child: Hero(
                      tag: place.img1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                foregroundDecoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.black87,
                                        Colors.transparent
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter),
                                ),
                                child: Image.asset(
                                  place.img1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  place.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    wordSpacing: 1.5,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    ],
  );
}