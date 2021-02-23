import 'dart:math';

class BabyNames {
  final Random random = Random();
  final List<String> names;
  final String gender;
  String _currentName = "Test";

  BabyNames({this.gender, this.names});

  String get currentName => _currentName;

  void shuffle() {
    print('In shuffle');
    _currentName = names[random.nextInt(names.length)];
    print(_currentName);
  }
}

class BabyName {
  final String name;
  final String gender;

  BabyName({this.name, this.gender});
}
