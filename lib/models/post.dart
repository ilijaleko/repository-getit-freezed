import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    final int? id,
    final String? title,
    final String? body,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  static List<Post> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Post.fromJson(json)).toList();
  }
}
