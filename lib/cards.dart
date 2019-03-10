import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String title, img, site, data;

  double parallaxPercent;

  Cards(
      {Key key,
      this.title,
      this.img,
      this.site,
      this.data,
      this.parallaxPercent = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FractionalTranslation(
              translation: Offset(parallaxPercent * 2, 0.0),
              child: OverflowBox(
                maxWidth: double.infinity,
                child: Container(
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter),
                  ),
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  (site),
                  style: TextStyle(
                    fontFamily: 'petita',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    fontSize: 40.0,
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 34.0,
                    fontFamily: 'petita',
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: new Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                  child: new Container(
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(30.0),
                      border: new Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: new Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          data,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: 'petita',
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
