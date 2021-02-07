import 'package:flutter/material.dart';

class OurContent extends StatefulWidget {

  const OurContent({Key key}) : super(key: key);
  @override
  _OurContentState createState() => _OurContentState();
}

class _OurContentState extends State<OurContent> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Text('Our Content Page', 
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black)),
        
      ])
    );
  }
}