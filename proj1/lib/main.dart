import 'package:flutter/material.dart';
import 'package:proj1/screens/characters/characters_list_screen/view/character_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:CharacterListScreen(),
    );
    //return CharacterScreen();
  }
}
