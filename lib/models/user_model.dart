import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final int user_id;
  final String username;
  final String? name;
  final int? mobno;
  final String? email_id;
  final String password;
  final String jwt_token;
  final DateTime creation_date;
  UserModel({
    required this.user_id,
    required this.username,
    required this.name,
    required this.mobno,
    required this.email_id,
    required this.password,
    required this.jwt_token,
    required this.creation_date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'username': username,
      'name': name,
      'mobno': mobno,
      'email_id': email_id,
      'hashedPassword': password,
      'jwt_token': jwt_token,
      'creation_date': creation_date,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user_id: map['user_id'] as int,
      username: map['username'] as String,
      name: map['name'] as String? ?? '',
      mobno: map['mobno'] as int? ?? 0, // Default value if null
      email_id: map['email_id'] as String? ?? '', // Default value if null
      password: map['hashedPassword'] as String,
      jwt_token: map['jwt_token'] as String,
      creation_date: DateTime.parse(map['creation_date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
