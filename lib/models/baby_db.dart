class Names {
  List<dynamic> names;

  Names({this.names});

  factory Names.fromJSON(Map<String, dynamic> json) {
    return Names(names: json["names"]);
  }
}
