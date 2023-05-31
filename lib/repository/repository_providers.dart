import 'package:get_it/get_it.dart';

import 'posts/posts.repository.dart';

class RepositoryProviders {
  static initializeProviders() async {
    final getIt = GetIt.instance;

    getIt.registerLazySingleton(() => PostsRepository());
  }
}
