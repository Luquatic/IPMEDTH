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
      body: Stack(
        children: <Widget>[
          PageView(
            children: <Widget>[
              Container(
                child: Column( //__Page1__//
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 40),
                      child: RaisedButton(
                        color: Colors.grey.shade300,
                        child: Text('X'),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                          },),
                    ),
                    Container(
                    ),
                  ],
                ),
              ),
              Container( //__Page2__//
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 40),
                      child: RaisedButton(
                        color: Colors.grey.shade300,
                        child: Text('X'),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },),
                    ),
                    Container(
                    ),
                  ],
                ),
              ),
              Container( //__Page3__//
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 40),
                      child: RaisedButton(
                        color: Colors.grey.shade300,
                        child: Text('X'),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },),
                    ),
                    Container(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Image.asset('res/images/app_drawer.png', scale: 7,),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(top: 10),
                      child: Text("Voor het teruglezen van de Handleiding \nkan je deze vinden in het menu."),
                      
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