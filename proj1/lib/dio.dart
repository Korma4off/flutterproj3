import 'package:dio/dio.dart';
import 'package:proj1/models/character.dart';

class DioHelper {
  static final DioHelper instance = DioHelper._internal();
  factory DioHelper() => instance;
  DioHelper._internal();

  final dio = Dio();
  late var result;
  var counter = 0;

  Future<List<Character>> getData() async {
    List<Character> characters = [];
    try {
      final response = await dio.get('https://rickandmortyapi.com/api/character/');
      int pages = await response.data['info']['pages'];
      for(int i = 0; i < pages; i++){
        final req = await dio.get('https://rickandmortyapi.com/api/character/?page=$i');
        var charList = await req.data['results'];
        for(int j = 0; j < charList.length; j++){
          characters.add(Character.fromMap(charList[j]));
        }
      }
    }
    catch (_) {
      rethrow;
    }
    return characters;
  }

  Future<Character> getDataFromId(int id) async {
    Character character;
    try {
      final response = await dio.get('https://rickandmortyapi.com/api/character/$id');
      character = Character.fromMap(response.data);
      return character;
    }
    catch (_) {
      rethrow;
    }
  }
}