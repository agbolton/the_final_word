import 'package:flutter/material.dart';
import 'dart:math';

class GenerateCode extends StatefulWidget {
  static const routename = 'code';
  @override
  _GenerateCodeState createState() => _GenerateCodeState();
}

class _GenerateCodeState extends State<GenerateCode> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Code Gen'));
  }
}
