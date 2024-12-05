part of 'character_bloc.dart';

abstract class CharacterState {

}

class CharacterInitial extends CharacterState{
  @override
  List<Object?> get props => [];

}
class CharacterLoading extends CharacterState{
  @override
  List<Object?> get props => [];
}
class CharacterLoaded extends CharacterState{
  CharacterLoaded({required this.character});
  final Character character;

  @override
  List<Object?> get props => [character];
}
class CharacterLoadingFailure extends CharacterState{
  CharacterLoadingFailure({required this.exception, required this.character});
  final Character character;
  final Object exception;

  @override
  List<Object?> get props => [exception];
}