import 'package:flutter/material.dart';
import 'package:the_final_word/components/loading.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../components/profile_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyContent extends StatefulWidget {
  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> {
  bool _view;

  void initState() {
    super.initState();
    initView();
  }

  void initView() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _view = prefs.getBool('view') ?? true;
    });
    print(_view);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser>(context);

    return StreamBuilder<Profile>(
        stream: DatabaseService(uid: user.uid).profile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Profile profile = snapshot.data;
            if (_view) {
              return girlsNames(context, profile);
            } else {
              return boysNames(context, profile);
            }
          } else {
            return Loading();
          }
        });
  }

  Widget girlsNames(BuildContext context, Profile profile) {
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
