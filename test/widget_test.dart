// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_crud_app_dio/data/models/post.dart';
import 'package:bloc_crud_app_dio/data/providers/api_prov.dart';
import 'package:bloc_crud_app_dio/repo/post_repo.dart';
import 'package:bloc_crud_app_dio/main.dart';

class FakePostRepo extends PostRepo {
  FakePostRepo() : super(prov: ApiProv());

  @override
  Future<List<Post>> getAll() async => [];

  @override
  Future<Post> add(Post p) async => p;

  @override
  Future<Post> edit(Post p) async => p;

  @override
  Future<void> drop(int id) async {}
}

void main() {
  testWidgets('Home screen shows title and empty list', (WidgetTester tester) async {
    final repo = FakePostRepo();
    await tester.pumpWidget(MyApp(repo: repo));
    await tester.pumpAndSettle();

    expect(find.text('Dio & Bloc Minimal'), findsOneWidget);
    expect(find.text('Empty list'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
