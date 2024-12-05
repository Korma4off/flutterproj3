import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/character_bloc.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({required this.id, super.key});
  final int id;

  @override
  State<CharacterScreen> createState() => _CharacterScreenState(id: id);
}

class _CharacterScreenState extends State<CharacterScreen> {
  _CharacterScreenState({required this.id});
  final int id;
  final _characterBloc = CharacterBloc();

  Map<String, Color> statusColors = {
    'Alive': Colors.green,
    'Dead': Colors.red,
    'unknown': Colors.orange,
  };


  @override
  void initState(){
    final completer = Completer();
    _characterBloc.add(LoadCharacter(completer: completer, id: id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Title'),
        ),
        body: RefreshIndicator(
          child:  BlocBuilder<CharacterBloc, CharacterState>(
            bloc: _characterBloc,
            builder: (context, state) {
              if(state is CharacterLoaded) {
                return buildingPage(state.character, true);
              }
              if (state is CharacterLoadingFailure) {
                return buildingPage(state.character, false);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          onRefresh: () async {
            final completer = Completer();
            _characterBloc.add(LoadCharacter(completer: completer, id: id));
            return completer.future;
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget buildingPage(character, internet){
    return Column(
      children:[
        Text(character.id.toString()),
        Image(
          image: getImage(character, internet) as ImageProvider<Object>,
          width: 150,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              character.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 15,
                  color: statusColors[character.status],
                ),
                Text(
                  character.status,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Text(
              'Species: ' + character.species,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Gender: ' + character.gender,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ]
        ),
      ],
    );
  }
  Object getImage(character, internet) => internet ? NetworkImage(character.image) : AssetImage('assets/images/unknown.jpeg');
}
