import 'package:flutter/material.dart';
import '../../services/sql_db.dart';
import '../../services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../models/movie.dart';
import 'package:the_final_word/components/loading.dart';
import '../../models/user.dart';

class AddMovies extends StatefulWidget {
  @override
  _AddMovies createState() => _AddMovies();
}

class _AddMovies extends State<AddMovies> {
  int movieID;

  Movie newMovie = Movie();

  void initState() {
    super.initState();
    initId();
  }

  void initId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      movieID = prefs.getInt('movieId') ?? 1;
    });
    getName(movieID);
  }

  void updateId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    movieID = movieID + 1;
    prefs.setInt('movieID', movieID);
    getName(movieID);
  }

  void getName(int movieId) async {
    final database = DatabaseInstance.getInstance();
    Movie pullMovie = await database.getNewMovie(movieID);
    setState(() {
      newMovie = pullMovie;
    });
  }

  void addNametoDatabase(String uid, List<String> movies) async {
    final CollectionReference userProfile =
        FirebaseFirestore.instance.collection('profiles');

    return userProfile
        .doc(uid)
        .update({'movies': FieldValue.arrayUnion(movies)}).catchError(
            (onError) => print('Failed to add'));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser>(context);

    if (newMovie == null) {
      return Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<Profile>(
        stream: DatabaseService(uid: user.uid).profile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Profile profile = snapshot.data;
            return Center(
                child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(top: 220.0),
                  child: Text('${newMovie.name}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                          color: Colors.pink[600]))),
              Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(Icons.stop_circle_outlined),
                          color: Colors.red,
                          iconSize: 80,
                          onPressed: updateId),
                      IconButton(icon: Icon(Icons.help), onPressed: () {}),
                      IconButton(
                          icon: Icon(Icons.check_box),
                          color: Colors.green,
                          iconSize: 80,
                          onPressed: () async {
                            setState(() {
                              profile.movies.add(newMovie.name);
                              addNametoDatabase(profile.uid, profile.movies);
                            });
                            updateId();
                          })
                    ],
                  ))
            ]));
          } else {
            return Loading();
          }
        });
  }
}
