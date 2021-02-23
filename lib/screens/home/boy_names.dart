import 'package:flutter/material.dart';
import '../../services/get_name.dart';


class MyBoy extends StatefulWidget {
  @override
  _MyBoyState createState() => _MyBoyState();
}

class _MyBoyState extends State<MyBoy> {
  @override
  Widget build(BuildContext context) {
    //return _buildBody(context);
return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 220.0),
            child: returnBoyName(context)
          ),
          Padding(
            padding: EdgeInsets.only(top: 175.0),
            child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.stop_circle_outlined),
                    color: Colors.red,
                    iconSize: 80,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.help),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.check_box),
                    color: Colors.green,
                    iconSize: 80,
                    onPressed: () {},
                  )
                  ])
            )
        ])
      );
  }
}