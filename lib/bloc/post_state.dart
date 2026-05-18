import 'package:equatable/equatable.dart';
import '../data/models/post.dart';

abstract class PostState extends Equatable {
  const PostState();
  @override
  List<Object?> get props => [];
}

class InitialState extends PostState {}

class LoadingState extends PostState {}

class LoadedState extends PostState {
  final List<Post> data;
  const LoadedState(this.data);
  @override
  List<Object?> get props => [data];
}

class ErrorState extends PostState {
  final String msg;
  const ErrorState(this.msg);
  @override
  List<Object?> get props => [msg];
}
