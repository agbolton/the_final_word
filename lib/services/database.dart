import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference profilesCollection =
      FirebaseFirestore.instance.collection('profiles');

  Future updateProfileData(
      String first_name, String last_name, String email) async {
    return await profilesCollection.doc(uid).set({
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'access_code': '',
      'girls_names': [],
      'boys_names': []
    });
  }

  // profileData from snapshot (build one profile object)
  Profile _profileFromSnapshot(DocumentSnapshot snapshot) {
    return Profile(
        uid: uid,
        first_name: snapshot.data()['first_name'],
        last_name: snapshot.data()['last_name'],
        email: snapshot.data()['email'],
        access_code: snapshot.data()['access_code'],
        girls_names:
            List.castFrom(snapshot.data()['girls_names'] as List ?? []),
        boys_names: List.castFrom(snapshot.data()['boys_names'] as List ?? []));
  }

  // get user doc stream (AKA get one user profile)
  Stream<Profile> get profile {
    return profilesCollection.doc(uid).snapshots().map(_profileFromSnapshot);
  }
}
