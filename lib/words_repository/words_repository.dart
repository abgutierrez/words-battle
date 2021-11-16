import 'dart:convert';

import 'package:words_generator/model/word.dart';
import 'package:http/http.dart' as http;

class WordRepository {
  final WordProvider wordProvider = WordProvider();

  Future<Map<String, Word>> getWords() async {
    final Word randomWord = await wordProvider.readData();
    final Word nextWord = await wordProvider.readData();

    return {'randomWord': randomWord, 'nextWord': nextWord};
  }
}

class WordProvider {
  Future<Word> readData() async {
    var url = Uri.parse(
      'https://palabras-aleatorias-public-api.herokuapp.com/random',
    );
    final response = await http.get(url);
    return Word.fromJson(jsonDecode(response.body));
  }
}
