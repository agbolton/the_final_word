import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_final_word/components/loading.dart';
import '../models/baby_name.dart';
import 'dart:math';



Widget returnGirlName(BuildContext context) {
  
  final CollectionReference names =
      FirebaseFirestore.instance.collection('baby names');

  //create function to grab random female documentId and store it
  List babyIds = [];

  final String documentId = 'YCZKdhhR5X4UMTly1jXh';

  // FirebaseFirestore.instance.collection('baby names')
  //   .where('gender', isEqualTo: 'female').get()
  //   .then((QuerySnapshot querySnapshot) => {
  //       querySnapshot.docs.forEach((doc) {
  //         print(doc.id);
  //       })
  //   });

    //List<BabyName> babyNames = await getBabyNames();
  

    return FutureBuilder<DocumentSnapshot>(
      future: names.doc(documentId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        else if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          BabyName name = _nameFromSnapshot(data, documentId);
          return Text(name.name, 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.pink[600]));
        } else {
          return Loading();
        }
      }
    );
  }

Widget returnBoyName(BuildContext context) {
  
  final CollectionReference names =
      FirebaseFirestore.instance.collection('baby names');

  //create function to grab random male documentId and store it
  final String documentId = 'HluR342PoyyCDlmW29h5';

    return FutureBuilder<DocumentSnapshot>(
      future: names.doc(documentId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        else if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          BabyName name = _nameFromSnapshot(data, documentId);
          return Text(name.name, 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.blue[800]));
        } else {
          return Loading();
        }
      }
    );
  }

  // profileData from snapshot (build one profile object)
 BabyName _nameFromSnapshot(Map data, String id) {
    return BabyName(
        id: id,
        name: data['name'],
        gender: data['gender']);
  }

