import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/models/character_model.dart';
import 'package:rickandmortyapp/providers/api_provider.dart';
import 'package:rickandmortyapp/screen/character_screen.dart';
import 'package:rickandmortyapp/screen/home_screen.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'character',
          builder: (context, state) {
            final character = state.extra as Character;
            return CharacterScreen(
              character: character,
            );
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      builder: (context, child) {
        final provider = Provider.of<ApiProvider>(context);
        return MaterialApp.router(
          title: 'Rick and Morty App',
          debugShowCheckedModeBanner: false,
          theme: provider.theme,
          routerConfig: _router,
        );
      },
      // child: MaterialApp.router(
      //   title: 'Rick and Morty App',
      //   debugShowCheckedModeBanner: false,
      //   theme: ThemeData(
      //     brightness: Brightness.dark,
      //     useMaterial3: true,
      //   ),
      //   routerConfig: _router,
      // ),
    );
  }
}
