import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/post_bloc.dart';
import '../../bloc/post_event.dart';
import '../../bloc/post_state.dart';
import '../../data/models/post.dart';

class HomeScr extends StatelessWidget {
  const HomeScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dio & Bloc Minimal')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _box(context),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (ctx, st) {
          if (st is ErrorState) {
            ScaffoldMessenger.of(
              ctx,
            ).showSnackBar(SnackBar(content: Text(st.msg)));
          }
        },
        builder: (ctx, st) {
          if (st is LoadingState)
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          if (st is LoadedState) {
            if (st.data.isEmpty) return const Center(child: Text('Empty list'));
            return RefreshIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
              onRefresh: () async => ctx.read<PostBloc>().add(FetchEvent()),
              child: ListView.builder(
                itemCount: st.data.length,
                itemBuilder: (ctx, idx) {
                  final p = st.data[idx];
                  return ListTile(
                    title: Text(p.title, maxLines: 1),
                    subtitle: Text(p.body, maxLines: 1),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _box(ctx, p: p),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              ctx.read<PostBloc>().add(DropEvent(p.id!)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: Text('Press button to load data.'));
        },
      ),
    );
  }

  void _box(BuildContext ctx, {Post? p}) {
    final tCtrl = TextEditingController(text: p?.title ?? '');
    final bCtrl = TextEditingController(text: p?.body ?? '');

    showDialog(
      context: ctx,
      builder: (dCtx) => AlertDialog(
        title: Text(p == null ? 'New Post' : 'Edit Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: bCtrl,
              decoration: const InputDecoration(labelText: 'Body'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dCtx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final item = Post(
                id: p?.id,
                uid: p?.uid ?? 1,
                title: tCtrl.text,
                body: bCtrl.text,
              );
              if (p == null) {
                ctx.read<PostBloc>().add(AddEvent(item));
              } else {
                ctx.read<PostBloc>().add(EditEvent(item));
              }
              Navigator.pop(dCtx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
