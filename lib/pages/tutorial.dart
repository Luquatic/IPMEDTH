import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:Applaudio/themes/applaudio.dart' as Theme;

class TutorialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TutorialPageState();
  }
}

class _TutorialPageState extends State<TutorialPage> {
  int _currentIndexPage;
  int _pageLength;
  final PageController _pageController = PageController();

  @override
  void initState() {
    _currentIndexPage = 0;
    _pageLength = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        PageView(
          children: <Widget>[
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.white,
            ),
            Container(
              color: Colors.blue,
            ),
          ],
          onPageChanged: (value) {
            setState(() => _currentIndexPage = value);
          },
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.7,
          // left: MediaQuery.of(context).size.width * 0.35,
          child: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.35),
            child: Align(
              alignment: Alignment.centerRight,
              child: DotsIndicator(
                dotsCount: _pageLength,
                position: _currentIndexPage,
                decorator: DotsDecorator(
                  activeColor: Theme.ApplaudioColors.lichtGroen[500],
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
