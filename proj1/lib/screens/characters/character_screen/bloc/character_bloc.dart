import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/models/character.dart';
import 'package:proj1/dio.dart';

import '../../../../database.dart';





part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {

  CharacterBloc() : super(CharacterInitial()) {
    on<LoadCharacter>((event, emit) async {
      var db = DatabaseHelper();
      try {
        if(state is! CharacterLoaded){
          emit(CharacterLoading());
        }
        var dio = DioHelper();
        final character = await dio.getDataFromId(event.id);
        db.addCharacter(character);
        emit(CharacterLoaded(character: character));
      }
      catch (e) {
        final character = await db.getCharacterFromId(event.id);
        print(character);
        emit(CharacterLoadingFailure(exception: e, character: character));
      }
      finally {
        event.completer.complete();
      }
    });
  }

  //final characterGet = CharacterGet();
}