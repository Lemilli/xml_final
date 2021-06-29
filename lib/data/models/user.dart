class User {
  final String? email;
  final String? name;

  User({
    this.email,
    this.name,
  });

  static User? _instance;

  static User? getInstance({name, email}) {
    if (_instance == null) {
      _instance = User(name: name, email: email);
      return _instance;
    }
    return _instance;
  }
}
