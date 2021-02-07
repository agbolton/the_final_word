import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/profile.dart';

class DatabaseService {

  final String uid;
  final String email;
  DatabaseService({ this.uid, this.email });

  // collection reference
  final CollectionReference profilesCollection = FirebaseFirestore.instance.collection('profiles');

  Future updateProfileData(String name, String email) async {
    return await profilesCollection.doc(uid).set({
      'name': name,
      'email': email
    });
  }

  // profile list from snapshot
  List<Profile> _profileListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Profile(
        name: doc.data()['name'] ?? '',
        email: doc.data()['email'] ?? ''
      );
    }).toList();
  }

  // get users stream
  Stream<List<Profile>> get profiles {
    return profilesCollection.snapshots()
    .map(_profileListFromSnapshot);
  }


}