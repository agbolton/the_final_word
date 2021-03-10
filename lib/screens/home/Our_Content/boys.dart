import 'package:flutter/material.dart';
import 'package:the_final_word/components/loading.dart';
import '../../../services/database.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BoysOurContent extends StatefulWidget {
  @override
  _BoysOurContentState createState() => _BoysOurContentState();
}

class _BoysOurContentState extends State<BoysOurContent> {
  final formKey = GlobalKey<FormState>();
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
      //load actual profile off user
      stream: DatabaseService(uid: user.uid).profile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Profile profile = snapshot.data;
          // check if a connection exists
          if (profile.connected_to != "") {
            // load connection profile
            return StreamBuilder<Profile>(
                stream: DatabaseService(uid: profile.connected_to).profile,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Profile friendProfile = snapshot.data;
                    // Create a new list of shared names
                    List<String> nameSets = [];
                    profile.boys_names.forEach((element) {
                      if (friendProfile.boys_names.contains(element)) {
                        nameSets.add(element);
                      }
                    });

                    // Do the reserve of an connected to add
                    if (friendProfile.connected_to != profile.uid) {
                      addConnectionID(friendProfile, profile.uid);
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'You are connected with ${friendProfile.first_name} ${friendProfile.last_name}'),
                        Expanded(
                          child: ListView.builder(
                            itemCount: nameSets.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('${nameSets[index]}'),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  } else {
                    return Loading();
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
                     Text('In order to begin comparing content, please enter your partner\'s code below.',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center),
                      SizedBox(height: 20),
                      Text('Your code can be generated in My Content by clicking the \'+\'',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center),
                      SizedBox(height: 20),
                      TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Enter Your Partner\'s code here',
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
