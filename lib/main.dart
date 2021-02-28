import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_final_word/screens/home/generate_code.dart';
import 'models/user.dart';
import 'screens/wrapper.dart';
import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  static final routes = {GenerateCode.routename: (context) => GenerateCode()};

  Widget build(BuildContext context) {
    return StreamProvider<NewUser>.value(
      value: AuthService().user,
      child: MaterialApp(
          title: 'Final Word',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          //routes: routes,
          home: Wrapper()),
    );
  }
}
