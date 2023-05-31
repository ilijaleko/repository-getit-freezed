import 'dart:convert';

import '../../models/post.dart';
import 'posts.interface.dart';

import 'package:http/http.dart' as http;

class PostsRepository implements IPostsRepository {
  final httpClient = http.Client();
  final _postLimit = 20;

  @override
  Future<List<Post>> getPosts([int startIndex = 0]) async {
    // This function can be implemented in data layer
    // Example: return await _postsApi.getPosts(startIndex);
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final posts = Post.fromJsonList(body);
      return posts;
    }
    throw Exception('error fetching posts');
  }
}
