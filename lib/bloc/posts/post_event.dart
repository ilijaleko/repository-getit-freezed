part of 'post_bloc.dart';

// We extend Equatable so that we can compare Posts.
// Equatable is a package that helps to implement equality without needing to explicitly override == and hashCode.
class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Our PostBloc will only be responding to a single event.
// PostFetched which will be added by the presentation layer whenever it needs more Posts to present.
class PostFetched extends PostEvent {}
