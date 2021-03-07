import 'package:flutter/material.dart';
import '../../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/loading.dart';

class OurContent extends StatefulWidget {
  const OurContent({Key key}) : super(key: key);
  @override
  _OurContentState createState() => _OurContentState();
}

class _OurContentState extends State<OurContent> {
  final formKey = GlobalKey<FormState>();
  var isConnected = false;
  String code;
  Profile profile = Profile();
  Profile friendProfile = Profile();

  Profile _profileFromSnapshot(DocumentSnapshot snapshot, String uid) {
    return Profile(
        uid: uid,
        first_name: snapshot.data()['first_name'],
        last_name: snapshot.data()['last_name'],
        email: snapshot.data()['email'],
        access_code: snapshot.data()['access_code']);
  }

  Future<void> loadUser(String uid) async {
    final CollectionReference profilesCollection =
        FirebaseFirestore.instance.collection('profiles');

    profilesCollection.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        profile = _profileFromSnapshot(documentSnapshot, uid);
      }
    });

    print('Incoming Profile : ${profile.last_name}');
  }

  Future<void> loadConnectedUser(String uid) async {
    final CollectionReference profilesCollection =
        FirebaseFirestore.instance.collection('profiles');

    profilesCollection.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        friendProfile = _profileFromSnapshot(documentSnapshot, uid);
      }
    });

    setState(() {
      isConnected = true;
    });
  }

  Future<void> loadCode(String code) async {
    final CollectionReference codesCollection =
        FirebaseFirestore.instance.collection('user_codes');

    codesCollection.doc(code).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        loadConnectedUser(documentSnapshot.data()['user_id']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isConnected) {
      if (friendProfile == null) {
        return Loading();
      } else {
        print('Friend Last Name: ${friendProfile.lastname}');
        return Container(
          child: Text('I am connected'),
        );
      }
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
                      await loadCode(code);
                    },
                    child: Text('Search Code'))
              ],
            ),
          ),
        ),
      );
    }
  }
}
