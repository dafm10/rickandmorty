import 'package:flutter/material.dart';
import 'package:rickandmortyapp/models/models.dart';
import 'package:http/http.dart' as http;

// para widgets que se tenga que redibujar
class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';
  List<Character> characters = [];
  List<Episode> episodes = [];
  ThemeData _theme = ThemeData.light();
  ThemeData get theme => _theme;

  Future<void> getCharacters(int page) async {
    final results = await http.get(Uri.https(url, "/api/character", {
      'page': page.toString(),
    }));
    final response = characterResponseFromJson(results.body);
    characters.addAll(response.results!);
    notifyListeners();
  }

  Future<List<Character>> getCharacter(String name) async {
    final result =
        await http.get(Uri.https(url, '/api/character', {'name': name}));
    final response = characterResponseFromJson(result.body);
    return response.results!;
  }

  Future<List<Episode>> getEpisodes(Character character) async {
    episodes = [];
    for (var i = 0; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeFromJson(result.body);
      episodes.add(response);
      notifyListeners();
    }
    return episodes;
  }

  void toggleTheme() {
    final isDark = _theme == ThemeData.dark();
    if (isDark) {
      _theme = ThemeData.light();
    } else {
      _theme = ThemeData.dark();
    }
    notifyListeners();
  }
}
