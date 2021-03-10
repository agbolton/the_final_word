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
  int movieId;

  Movie newMovie = Movie();

  void initState() {
    super.initState();
    initId();
  }

  void initId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      movieId = prefs.getInt('movieId') ?? 1;
    });
    getName(movieId);
  }

  void updateId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    movieId = movieId + 1;
    prefs.setInt('movieId', movieId);
    getName(movieId);
  }

  void getName(int movieId) async {
    final database = DatabaseInstance.getInstance();
    Movie pullMovie = await database.getNewMovie(movieId);
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
                  padding: EdgeInsets.only(top: 175),
                  child: Text('${newMovie.name}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.indigo))),
              Padding(
                  padding: EdgeInsets.only(top: 75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 5, color: Colors.red)),
                          child: IconButton(
                            icon: Icon(Icons.close),
                            color: Colors.red,
                            iconSize: 80,
                            onPressed: updateId,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 5, color: Colors.green)),
                          child: IconButton(
                              icon: Icon(Icons.check),
                              color: Colors.green,
                              iconSize: 80,
                          onPressed: () async {
                            setState(() {
                              profile.movies.add(newMovie.name);
                              addNametoDatabase(profile.uid, profile.movies);
                            });
                            updateId();
                          })
                        ))],
                  ))
            ]));
          } else {
            return Loading();
          }
        });
  }
}
