import 'package:flutter/material.dart';
import 'package:the_final_word/models/profile.dart';
import 'package:provider/provider.dart';
import 'profile_tile.dart';

class ProfileData extends StatefulWidget {
  @override
  _ProfileDataState createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  @override
  Widget build(BuildContext context) {

    final profiles = Provider.of<List<Profile>>(context);

    return ListView.builder(
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        return ProfileTile(profile: profiles[index]);
      }
    );
  }
}