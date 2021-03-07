class NewUser {
  final String uid;

  NewUser({this.uid});

  String get id {
    return uid;
  }
}

class Profile {
  final String uid;
  final String first_name;
  final String last_name;
  final String email;
  final String access_code;
  final List<String> girls_names;

  Profile(
      {this.uid,
      this.first_name,
      this.last_name,
      this.email,
      this.access_code,
      this.girls_names});

  String get lastname {
    return this.last_name;
  }
}
