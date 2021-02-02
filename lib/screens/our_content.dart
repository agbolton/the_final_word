import 'package:flutter/material.dart';
import '../components/bottom_bar.dart';

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
      bottomNavigationBar: BottomBar()
    );
  }
}