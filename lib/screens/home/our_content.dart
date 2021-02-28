import 'package:flutter/material.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';

class OurContent extends StatefulWidget {
  const OurContent({Key key}) : super(key: key);
  @override
  _OurContentState createState() => _OurContentState();
}

class _OurContentState extends State<OurContent> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser>(context);
    print(user.id);

    return Center(
        child: Column(children: [
      Text('Our Content Page',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black)),
    ]));
  }
}
