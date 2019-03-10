import 'dart:ui';
import 'cards.dart';
import 'package:flutter/material.dart';
import 'places_details.dart';

class PlaceCard extends StatefulWidget {
  final Details place;

  const PlaceCard({Key key, this.place}) : super(key: key);

  @override
  _PlaceCardState createState() => _PlaceCardState(place);
}

class _PlaceCardState extends State<PlaceCard> with TickerProviderStateMixin {
  final Details place;
  double scrollPercent = 0.0;
  double startDragPercentScroll = 0.0;
  Offset startDrag;
  double finishScrollStart;
  double finishScrollEnd;
  AnimationController finishScrollController;

  _PlaceCardState(this.place);

  Widget _buildCard(String data, String img, String title, int cardIndex,
      int cardCount, double scrollPercent) {
    final cardScrollPercent = scrollPercent / (1 / cardCount);
    final parallax = scrollPercent - (cardIndex / cardCount);
    return FractionalTranslation(
      translation: Offset(cardIndex - cardScrollPercent, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Cards(
          site: place.name,
          title: title,
          data: data,
          img: img,
          parallaxPercent: parallax,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      onHorizontalDragStart: _onHorizontalDragStart,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: <Widget>[
          _buildCard(place.about, place.img1, 'About', 0, 2, scrollPercent),
          _buildCard(place.hist, place.img2, 'History', 1, 2, scrollPercent),
        ],
      ),
    );
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    finishScrollStart = scrollPercent;
    finishScrollEnd = (scrollPercent * 2).round() / 2;
    finishScrollController.forward(from: 0.0);
    setState(() {
      startDragPercentScroll = null;
      startDrag = null;
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    final singleCardDragPercent = dragDistance / context.size.width;

    setState(() {
      scrollPercent = (startDragPercentScroll - singleCardDragPercent / 2)
          .clamp(0.0, 1.0 - (1 / 2));
    });
  }

  @override
  void initState() {
    super.initState();
    finishScrollController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 150))
      ..addListener(() {
        setState(() {
          scrollPercent = lerpDouble(
              finishScrollStart, finishScrollEnd, finishScrollController.value);
        });
      });
  }

  @override
  void dispose() {
    finishScrollController.dispose();
    super.dispose();
  }
}
