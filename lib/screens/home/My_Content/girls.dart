import 'package:flutter/material.dart';
import 'package:the_final_word/components/loading.dart';
import '../../../services/database.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';
import '../../../components/profile_tile.dart';

class GirlsMyContent extends StatefulWidget {
  @override
  _GirlsMyContentState createState() => _GirlsMyContentState();
}

class _GirlsMyContentState extends State<GirlsMyContent> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser>(context);
    return StreamBuilder<Profile>(
        stream: DatabaseService(uid: user.uid).profile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Profile profile = snapshot.data;
            return girlNames(context, profile);
          } else {
            return Loading();
          }
        });
  }

  Widget girlNames(BuildContext context, Profile profile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileTile(profile: profile),
        Expanded(
            child: Center(
          child: ListView.builder(
            itemCount: profile.girls_names.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${profile.girls_names[index]}'),
              );
            },
          ),
        ))
      ],
    );
  }
}
