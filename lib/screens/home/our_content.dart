import 'package:flutter/material.dart';
import 'package:the_final_word/components/loading.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OurContent extends StatefulWidget {
  const OurContent({Key key}) : super(key: key);
  @override
  _OurContentState createState() => _OurContentState();
}

class _OurContentState extends State<OurContent> {
  final formKey = GlobalKey<FormState>();
  var isConnected = false;
  final CollectionReference userProfile =
      FirebaseFirestore.instance.collection('profiles');
  String code;
  Profile profile = Profile();
  Profile friendProfile = Profile();

  void addConnectionID(Profile profile, String uid) async {
    return userProfile
        .doc(profile.uid)
        .update({'connected_to': uid})
        .then((value) => print('Code Added to profile'))
        .catchError((onError) => print('Failed to add'));
  }

  Future<void> loadCode(String code, Profile profile) async {
    final CollectionReference codesCollection =
        FirebaseFirestore.instance.collection('user_codes');

    codesCollection.doc(code).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        addConnectionID(profile, documentSnapshot.data()['user_id']);
      }
    }).catchError((onError) => print("Code not found / problem"));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser>(context);
    return StreamBuilder<Profile>(
      stream: DatabaseService(uid: user.uid).profile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Profile profile = snapshot.data;
          if (profile.connected_to != "") {
            return StreamBuilder<Profile>(
                stream: DatabaseService(uid: profile.connected_to).profile,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Profile friendProfile = snapshot.data;
                    if (friendProfile.connected_to != profile.uid) {
                      addConnectionID(friendProfile, profile.uid);
                    }
                    return Container(
                        child:
                            Text('Friends Name: ${friendProfile.last_name}'));
                  }
                });
          } else {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            code = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a code to search';
                            } else {
                              return null;
                            }
                          }),
                      RaisedButton(
                          onPressed: () async {
                            formKey.currentState.save();
                            print(profile.uid);
                            loadCode(code, profile);
                          },
                          child: Text('Search Code'))
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return Loading();
        }
      },
    );
  }
}
