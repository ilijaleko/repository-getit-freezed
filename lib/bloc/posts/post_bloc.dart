import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import '../../models/post.dart';
import '../../repository/posts/posts.repository.dart';

part 'post_bloc.freezed.dart';
part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return events.throttle(duration).switchMap(mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;
  final postsRepository = GetIt.instance.get<PostsRepository>();

  PostBloc({required this.httpClient}) : super(PostState.initial()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );

    // trigger initial load... if you want
  }

  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await postsRepository.getPosts();
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
      final posts = await postsRepository.getPosts(state.posts.length);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
