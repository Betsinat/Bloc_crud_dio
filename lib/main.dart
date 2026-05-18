import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/providers/api_prov.dart';
import 'repo/post_repo.dart';
import 'bloc/post_bloc.dart';
import 'bloc/post_event.dart';
import 'ui/home.dart';

void main() {
  final prov = ApiProv();
  final repo = PostRepo(prov: prov);

  runApp(MyApp(repo: repo));
}

class MyApp extends StatelessWidget {
  final PostRepo repo;
  const MyApp({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.dark().copyWith(
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.white,
      onSecondary: Colors.black,
      surface: Colors.black,
      onSurface: Colors.white,
      error: Colors.white,
      onError: Colors.black,
    );

    return BlocProvider(
      create: (ctx) => PostBloc(repo: repo)..add(FetchEvent()),
      child: MaterialApp(
        title: 'Bloc CRUD App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(colorScheme: colorScheme).copyWith(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          dialogTheme: const DialogThemeData(
            backgroundColor: Colors.black,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            contentTextStyle: TextStyle(color: Colors.white),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white70),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white54),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.white10,
            contentTextStyle: TextStyle(color: Colors.white),
          ),
          listTileTheme: const ListTileThemeData(
            textColor: Colors.white,
            iconColor: Colors.white,
            tileColor: Colors.black,
          ),
        ),
        home: const HomeScr(),
      ),
    );
  }
}
