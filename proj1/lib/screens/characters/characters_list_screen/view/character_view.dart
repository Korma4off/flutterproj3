part of 'character_list_screen.dart';


class CharacterView extends StatefulWidget {
  CharacterView({ required this.character, required this.internet, super.key });
  Character character;
  bool internet;

  @override
  State<CharacterView> createState() => _CharacterViewState(character: character, internet: internet);
}

class _CharacterViewState extends State<CharacterView> {
  _CharacterViewState({required this.character, required this.internet});
  Character character;
  bool internet;

  Map<String, Color> statusColors = {
    'Alive': Colors.green,
    'Dead': Colors.red,
    'unknown': Colors.orange,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterScreen(id: character.id)),);},

        child: Row(
          children: <Widget> [
            /*Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(
                character.id.toString(),
                style: Theme.of(context).textTheme.headlineMedium,),
            ),*/

            Container(
              width: 200,
              alignment: Alignment.center,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(
                  image: getImage() as ImageProvider<Object>,
                  width: 150,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  child: Expanded(
                    child: Text(
                    character.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
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
              ],
            )
          ]
      ),
    );
  }

  Object getImage() => internet ? NetworkImage(character.image) : AssetImage('assets/images/unknown.jpeg');
}
