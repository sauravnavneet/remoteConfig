import 'dart:convert';
import 'package:flutter/widgets.dart';

// user model
class UserModel {
  String email;
  String id;
  String? name;

  UserModel({
    required this.email,
    required this.id,
    this.name,
  });

  UserModel copyWith({
    String? email,
    String? id,
    ValueGetter<String?>? name,
  }) {
    return UserModel(
      email: email ?? this.email,
      id: id ?? this.id,
      name: name != null ? name() : this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      id: map['uid'] ?? '',
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(email: $email, id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.email == email &&
        other.id == id &&
        other.name == name;
  }

  @override
  int get hashCode => email.hashCode ^ id.hashCode ^ name.hashCode;
}
