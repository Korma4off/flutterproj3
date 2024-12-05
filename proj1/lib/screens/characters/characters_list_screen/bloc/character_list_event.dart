part of 'character_list_bloc.dart';

abstract class CharacterListEvent {

}

class LoadCharacterList extends CharacterListEvent{
  LoadCharacterList(this.completer);
  final Completer completer;

  @override
  List<Object?> get props => [completer];
}