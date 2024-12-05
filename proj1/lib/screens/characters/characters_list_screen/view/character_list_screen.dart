import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/models/character.dart';

import '../../character_screen/view/character_screen.dart';
import '../bloc/character_list_bloc.dart';

part 'character_view.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {

  final _charactersListBloc = CharacterListBloc();

  @override
  void initState(){
    final completer = Completer();
    _charactersListBloc.add(LoadCharacterList(completer));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: RefreshIndicator(
          child:  BlocBuilder<CharacterListBloc, CharacterListState>(
            bloc: _charactersListBloc,
            builder: (context, state) {
              if(state is CharacterListLoaded) {
                return listBuilding(state, true);
              }
              if (state is CharacterListLoadingFailure) {
                return listBuilding(state, false);
              }
              if(state is CharacterListLoading) {
                return listBuilding(state, false);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          onRefresh: () async {
            final completer = Completer();
            _charactersListBloc.add(LoadCharacterList(completer));
            return completer.future;
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget listBuilding(state, bool internet){
    return ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      itemCount: state.charactersList.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final character = state.charactersList[index];
        return CharacterView(character: character, internet: internet);
      },
    );
  }

}


