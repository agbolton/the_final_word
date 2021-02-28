import 'package:flutter/material.dart';
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
  String code;
  Profile profile;

  void loadUser(String uid) async {
    final CollectionReference profilesCollection =
        FirebaseFirestore.instance.collection('profiles');

    profilesCollection.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot.data()['last_name']);
      }
    });
  }

  void loadCode(String code) async {
    final CollectionReference codesCollection =
        FirebaseFirestore.instance.collection('user_codes');

    codesCollection.doc(code).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        //print(documentSnapshot.data()['user_id']);
        print("found Code");
        loadUser(documentSnapshot.data()['user_id']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser>(context);
    loadUser(user.id);
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
                    print('Button Pressed');
                    loadCode(code);
                  },
                  child: Text('Search Code'))
            ],
          ),
        ),
      ),
    );

    /*
    return StreamBuilder<Profile>(
        stream: DatabaseService(uid: user.uid).profile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Profile profile = snapshot.data;
            return Text('${profile.first_name}');
          } else {
            return Text('Problem');
          }
        });
    */
  }
}
