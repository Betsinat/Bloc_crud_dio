import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_event.dart';
import 'post_state.dart';
import '../repo/post_repo.dart';
import '../data/models/post.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepo repo;

  PostBloc({required this.repo}) : super(InitialState()) {
    on<FetchEvent>(_onFetch);
    on<AddEvent>(_onAdd);
    on<EditEvent>(_onEdit);
    on<DropEvent>(_onDrop);
  }

  Future<void> _onFetch(FetchEvent ev, Emitter<PostState> emit) async {
    emit(LoadingState());
    try {
      final list = await repo.getAll();
      emit(LoadedState(list));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> _onAdd(AddEvent ev, Emitter<PostState> emit) async {
    if (state is LoadedState) {
      final current = (state as LoadedState).data;
      try {
        final res = await repo.add(ev.p);
        emit(LoadedState([res, ...current]));
      } catch (e) {
        emit(ErrorState('Add failed'));
      }
    }
  }

  Future<void> _onEdit(EditEvent ev, Emitter<PostState> emit) async {
    if (state is LoadedState) {
      final current = (state as LoadedState).data;
      try {
        final res = await repo.edit(ev.p);
        final next = current
            .map((item) => item.id == res.id ? res : item)
            .toList();
        emit(LoadedState(next));
      } catch (e) {
        emit(ErrorState('Edit failed'));
      }
    }
  }

  Future<void> _onDrop(DropEvent ev, Emitter<PostState> emit) async {
    if (state is LoadedState) {
      final current = (state as LoadedState).data;
      final next = current.where((item) => item.id != ev.id).toList();
      emit(LoadedState(next));
      try {
        await repo.drop(ev.id);
      } catch (e) {
        emit(ErrorState('Delete failed'));
        emit(LoadedState(current));
      }
    }
  }
}
