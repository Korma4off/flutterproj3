part of 'character_bloc.dart';

abstract class CharacterEvent {

}

class LoadCharacter extends CharacterEvent{
  LoadCharacter({required this.completer, required this.id});
  final int id;
  final Completer completer;

  @override
  List<Object?> get props => [completer];
}