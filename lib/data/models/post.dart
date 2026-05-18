import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int? id;
  final int uid;
  final String title;
  final String body;

  const Post({
    this.id,
    required this.uid,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int?,
      uid: json['userId'] as int? ?? 1,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'userId': uid,
      'title': title,
      'body': body,
    };
    if (id != null) data['id'] = id;
    return data;
  }

  @override
  List<Object?> get props => [id, uid, title, body];
}
