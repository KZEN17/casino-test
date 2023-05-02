import 'dart:async';
import 'dart:convert';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:http/http.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;

  CharactersRepositoryImpl(this.client);

  @override
  Future<List<Character>?> getCharacters(int page) async {
    var client = Client();
    final charResult = await client.get(
      Uri.parse("https://rickandmortyapi.com/api/character/?page=$page"),
    );
    final jsonMap = await json.decode(charResult.body) as Map<String, dynamic>;

    final results = jsonMap["results"];

    if (results == null || results is! List<dynamic>) {
      return null;
    }

    final characters =
        results.map((value) => Character.fromJson(value)).toList();

    return Future.value(characters);
  }
}
