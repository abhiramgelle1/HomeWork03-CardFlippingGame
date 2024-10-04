import 'package:flutter/material.dart';

void main() {
  runApp(CardMatchingGame());
}

class CardModel {
  final String imageAssetPath;
  bool isFaceUp;
  bool isMatched;

  CardModel({
    required this.imageAssetPath,
    this.isFaceUp = false,
    this.isMatched = false,
  });
}

class CardMatchingGame extends StatefulWidget {
  @override
  _CardMatchingGameState createState() => _CardMatchingGameState();
}

class _CardMatchingGameState extends State<CardMatchingGame> {
  late List<CardModel> cards;

  @override
  void initState() {
    super.initState();
    _initializeCards();
  }

  void _initializeCards() {
    cards = [
      CardModel(imageAssetPath: 'assets/captainamerica.jpeg'),
      CardModel(imageAssetPath: 'assets/captainamerica.jpeg'),
      CardModel(imageAssetPath: 'assets/beyblade.jpeg'),
      CardModel(imageAssetPath: 'assets/beyblade.jpeg'),
      CardModel(imageAssetPath: 'assets/naruto.jpeg'),
      CardModel(imageAssetPath: 'assets/naruto.jpeg'),
      CardModel(imageAssetPath: 'assets/thor.jpeg'),
      CardModel(imageAssetPath: 'assets/thor.jpeg'),
      CardModel(imageAssetPath: 'assets/inazuma.jpeg'),
      CardModel(imageAssetPath: 'assets/inazuma.jpeg'),
      CardModel(imageAssetPath: 'assets/spiderman.jpeg'),
      CardModel(imageAssetPath: 'assets/spiderman.jpeg'),
      CardModel(imageAssetPath: 'assets/haikyuu.jpeg'),
      CardModel(imageAssetPath: 'assets/haikyuu.jpeg'),
      CardModel(imageAssetPath: 'assets/demonslayer.jpeg'),
      CardModel(imageAssetPath: 'assets/demonslayer.jpeg'),
    ];
    cards.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Cards Flipping Game'),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              children: List.generate(cards.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      cards[index].isFaceUp =
                          !cards[index].isFaceUp; // Flip card
                    });
                  },
                  child: AnimatedContainer(
                    duration:
                        Duration(milliseconds: 300), // Animation for flipping
                    decoration: BoxDecoration(
                      color:
                          cards[index].isFaceUp ? Colors.grey : Colors.yellow,
                      borderRadius: BorderRadius.circular(8.0),
                      image: cards[index].isFaceUp
                          ? DecorationImage(
                              image: AssetImage(cards[index].imageAssetPath),
                              fit: BoxFit.cover,
                            )
                          : null, // Show image only if card is face-up
                    ),
                    child: Center(
                      child: cards[index].isFaceUp
                          ? null
                          : Text(
                              "Back",
                              style: TextStyle(color: Colors.black),
                            ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
