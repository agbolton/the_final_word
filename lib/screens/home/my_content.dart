import 'package:flutter/material.dart';
import 'package:the_final_word/components/loading.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../components/profile_tile.dart';

class MyContent extends StatefulWidget {

  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<NewUser>(context);

    return StreamBuilder<Profile>(
      stream: DatabaseService(uid: user.uid).profile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Profile profile = snapshot.data;
          return ProfileTile(profile: profile);
        } else {
          return Loading();
        }
      }
    );
  }
}