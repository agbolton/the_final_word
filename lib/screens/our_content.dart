import 'package:flutter/material.dart';

class OurContent extends StatefulWidget {
  OurContent({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OurContentState createState() => _OurContentState();
}

class _OurContentState extends State<OurContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Our Content', style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
    );
  }
}