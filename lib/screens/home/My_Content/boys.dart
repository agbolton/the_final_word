import 'package:flutter/material.dart';
import 'package:the_final_word/components/loading.dart';
import '../../../services/database.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';
import '../../../components/profile_tile.dart';

class BoysMyContent extends StatefulWidget {
  @override
  _BoysMyContentState createState() => _BoysMyContentState();
}

class _BoysMyContentState extends State<BoysMyContent> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser>(context);
    return StreamBuilder<Profile>(
        stream: DatabaseService(uid: user.uid).profile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Profile profile = snapshot.data;
            return boysNames(context, profile);
          } else {
            return Loading();
          }
        });
  }

  Widget boysNames(BuildContext context, Profile profile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileTile(profile: profile),
        Expanded(
            child: Center(
          child: ListView.builder(
            itemCount: profile.boys_names.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${profile.boys_names[index]}'),
              );
            },
          ),
        ))
      ],
    );
  }
}
