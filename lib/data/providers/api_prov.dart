import 'package:dio/dio.dart';
import '../models/post.dart';

class ApiProv {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<List<Post>> getList() async {
    try {
      final res = await _dio.get('/posts');
      return (res.data as List).map((j) => Post.fromJson(j)).toList();
    } on DioException catch (e) {
      throw _err(e);
    }
  }

  Future<Post> create(Post p) async {
    try {
      final res = await _dio.post('/posts', data: p.toJson());
      return Post.fromJson(res.data);
    } on DioException catch (e) {
      throw _err(e);
    }
  }

  Future<Post> update(Post p) async {
    try {
      final res = await _dio.put('/posts/${p.id}', data: p.toJson());
      return Post.fromJson(res.data);
    } on DioException catch (e) {
      throw _err(e);
    }
  }

  Future<void> delete(int id) async {
    try {
      await _dio.delete('/posts/$id');
    } on DioException catch (e) {
      throw _err(e);
    }
  }

  String _err(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) return 'Timeout!';
    if (e.type == DioExceptionType.badResponse)
      return 'Server Error: ${e.response?.statusCode}';
    return 'Network Error';
  }
}
