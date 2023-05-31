part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

@freezed
class PostState with _$PostState {
  const factory PostState({
    required PostStatus status,
    required List<Post> posts,
    required bool hasReachedMax,
  }) = _PostState;

  factory PostState.initial() => const PostState(
        status: PostStatus.initial,
        posts: <Post>[],
        hasReachedMax: false,
      );

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';
  }
}
