import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/models/character.dart';
import 'package:proj1/dio.dart';

import '../../../../database.dart';





part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {

  CharacterListBloc() : super(CharacterListInitial()) {
    on<LoadCharacterList>((event, emit) async {
      var db = DatabaseHelper();
      try {
        if(state is! CharacterListLoaded){
          final charactersList = await db.getCharacters();
          emit(CharacterListLoading(charactersList: charactersList));
        }
        var dio = DioHelper();
        final charactersList = await dio.getData();
        for(Character character in charactersList) {
          db.addCharacter(character);
        }
        emit(CharacterListLoaded(charactersList: charactersList));
      }
      catch (e) {
        final charactersList = await db.getCharacters();
        emit(CharacterListLoadingFailure(exception: e, charactersList: charactersList));
      }
      finally {
        event.completer.complete();
      }
    });
  }

  //final characterGet = CharacterGet();
}