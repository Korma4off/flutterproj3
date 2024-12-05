part of 'character_list_bloc.dart';

abstract class CharacterListState {

}

class CharacterListInitial extends CharacterListState{
  @override
  List<Object?> get props => [];

}
class CharacterListLoading extends CharacterListState{
  CharacterListLoading({required this.charactersList});
  final List<Character> charactersList;

  @override
  List<Object?> get props => [charactersList];
}
class CharacterListLoaded extends CharacterListState{
  CharacterListLoaded({required this.charactersList});
  final List<Character> charactersList;

  @override
  List<Object?> get props => [charactersList];
}
class CharacterListLoadingFailure extends CharacterListState{
  CharacterListLoadingFailure({
    required this.exception,
    required this.charactersList
  });
  final Object exception;
  final List<Character> charactersList;

  @override
  List<Object?> get props => [exception, charactersList];
}