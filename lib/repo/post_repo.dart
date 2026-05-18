import '../data/providers/api_prov.dart';
import '../data/models/post.dart';

class PostRepo {
  final ApiProv prov;
  PostRepo({required this.prov});

  Future<List<Post>> getAll() => prov.getList();
  Future<Post> add(Post p) => prov.create(p);
  Future<Post> edit(Post p) => prov.update(p);
  Future<void> drop(int id) => prov.delete(id);
}
