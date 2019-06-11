import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TutorialPageState();
  }
}

class _TutorialPageState extends State<TutorialPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applaudio!: Uitleg'),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          Container(
            child: Text('Page 1'),
            color: Colors.red,
          ),
          Container(
            child: Text('Page 2'),
            color: Colors.white,
          ),
          Container(
            child: Text('Page 3'),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
