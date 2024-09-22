import 'dart:convert';

// Post Model
class PostModel {
  int postId;
  int id;
  String name;
  String email;
  String comments;
  PostModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.comments,
  });

  PostModel copyWith({
    int? postId,
    int? id,
    String? name,
    String? email,
    String? comments,
  }) {
    return PostModel(
      postId: postId ?? this.postId,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'comments': comments,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['postId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      comments: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(postId: $postId, id: $id, name: $name, email: $email, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.postId == postId &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.comments == comments;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        comments.hashCode;
  }
}
