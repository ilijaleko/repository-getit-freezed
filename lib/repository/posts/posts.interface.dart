import '../../models/post.dart';

abstract class IPostsRepository {
  Future<List<Post>> getPosts();
}
