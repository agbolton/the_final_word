import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class ProfileTile extends StatelessWidget {
  final Profile profile;

  ProfileTile({this.profile});

  @override
  Widget build(BuildContext context) {
    final CollectionReference userCodes =
        FirebaseFirestore.instance.collection('user_codes');

    final CollectionReference userProfile =
        FirebaseFirestore.instance.collection('profiles');

    var random = new Random();
    var randomCodeNum = random.nextInt(900000) + 100000;
    var randomCode = randomCodeNum.toString();

    Future<void> generateCodetoDB() {
      return userCodes
          .doc(randomCode)
          .set({'user_id': profile.uid})
          .then((value) => print('Code Generate'))
          .catchError((onError) => print('Failed to add'));
    }

    Future<void> addCodetoProfile() {
      return userProfile
          .doc(profile.uid)
          .update({'access_code': randomCode})
          .then((value) => print('Code Added to profile'))
          .catchError((onError) => print('Failed to add'));
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              // leading: CircleAvatar(
              //   radius: 25.0,
              //   backgroundColor: Colors.blue,
              // ),
              title: Text('${profile.first_name} ${profile.last_name}'),
              subtitle: Text('Code to Link (click + to generate): ${profile.access_code}'),
              trailing: FloatingActionButton(
                onPressed: () async {
                  await generateCodetoDB();
                  await addCodetoProfile();
                },
                child: Icon(Icons.add),
              ))),
    );
  }
}
