//libraries
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:Applaudio/themes/applaudio.dart' as Theme;
import 'package:flutter/widgets.dart';

class TutorialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TutorialPageState();
  }
}

class _TutorialPageState extends State<TutorialPage> {
  int _currentIndexPage;
  int _pageLength;

  @override
  void initState() {
    _currentIndexPage = 0;
    _pageLength = 3;
    super.initState();
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: Text('Handleiding'),
      ),
      body: Stack(
        children: <Widget>[
          PageView(
            children: <Widget>[
              Container(), // Page 1
              Container(), // Page 2
              Container(
                //__Page3__//
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'res/images/app_drawer.png',
                        scale: 7,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "De handleiding is terug te vinden in het menu.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ],
            onPageChanged: (_value) {
              setState(() => _currentIndexPage = _value);
            },
          ),
          _buildDotsDecorator(context),
        ],
      ),
    );
  }

  Widget _buildDotsDecorator(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: DotsIndicator(
          dotsCount: _pageLength,
          position: _currentIndexPage,
          decorator: DotsDecorator(
            activeColor: Theme.ApplaudioColors.lichtGroen[500],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context);
  }
}
