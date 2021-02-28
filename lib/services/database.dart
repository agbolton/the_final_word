import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import '../models/user.dart';
import '../models/babynames.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference profilesCollection =
      FirebaseFirestore.instance.collection('profiles');

  Future updateProfileData(
      String first_name, String last_name, String email) async {
    return await profilesCollection.doc(uid).set(
        {'first_name': first_name, 'last_name': last_name, 'email': email});
  }

  // profileData from snapshot (build one profile object)
  Profile _profileFromSnapshot(DocumentSnapshot snapshot) {
    return Profile(
        uid: uid,
        first_name: snapshot.data()['first_name'],
        last_name: snapshot.data()['last_name'],
        email: snapshot.data()['email']);
  }

  // get user doc stream (AKA get one user profile)
  Stream<Profile> get profile {
    return profilesCollection.doc(uid).snapshots().map(_profileFromSnapshot);
  }
}

// example to map a set of profiles to a list
// List<Profile> _profileListFromSnapshot(QuerySnapshot snapshot) {
//   return snapshot.docs.map((doc) {
//     return Profile(
//       name: doc.data()['name'] ?? '',
//       email: doc.data()['email'] ?? ''
//     );
//   }).toList();
// }

// exanmple to return a list of those profiles
// Stream<List<Profile>> get profiles {
//   return profilesCollection.snapshots()
//   .map(_profileListFromSnapshot);
// }

/*
class BabyNameService {
  final String gender;
  BabyNameService({this.gender});

  final CollectionReference babyCollection =
      FirebaseFirestore.instance.collection('baby names');

  BabyName _nameFromSnapShot(DocumentSnapshot snapshot) {
    print(snapshot.data().keys);
    snapshot.data().keys.forEach((element) {
      print(element);
      var name = BabyName(gender: 'male', name: element);
    });
    return name;
  }

  Stream<BabyName> get name {
    return babyCollection.doc('male').snapshots().map(_nameFromSnapShot);
  }
}
*/