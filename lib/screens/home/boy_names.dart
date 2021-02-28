import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_final_word/components/loading.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';
import '../../models/babynames.dart';
import '../../services/database.dart';

class MyBoy extends StatefulWidget {
  @override
  _MyBoyState createState() => _MyBoyState();
}

class _MyBoyState extends State<MyBoy> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Boys Name'));
  }
}
