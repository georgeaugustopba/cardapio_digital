class User {
  const User({
    required this.id,
    required this.username,
    required this.email,
  });

  final int id;
  final String username;
  final String email;

  @override
  String toString() {
    return 'User{ id: $id, username: $username, email: $email,}';
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      username: map['username'] as String,
      email: map['email'] as String,
    );
  }
}
