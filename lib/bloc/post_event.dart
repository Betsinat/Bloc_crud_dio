import 'package:equatable/equatable.dart';
import '../data/models/post.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object?> get props => [];
}

class FetchEvent extends PostEvent {}

class AddEvent extends PostEvent {
  final Post p;
  const AddEvent(this.p);
  @override
  List<Object?> get props => [p];
}

class EditEvent extends PostEvent {
  final Post p;
  const EditEvent(this.p);
  @override
  List<Object?> get props => [p];
}

class DropEvent extends PostEvent {
  final int id;
  const DropEvent(this.id);
  @override
  List<Object?> get props => [id];
}
