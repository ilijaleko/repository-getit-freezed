import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_router.dart';
import 'repository/repository_providers.dart';
import 'simple_bloc_observer.dart';

void main() async {
  Bloc.observer = const SimpleBlocObserver();

  await RepositoryProviders.initializeProviders();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Flutter bootcamp', routerConfig: AppRouter.routerConfig);
  }
}
