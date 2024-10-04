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
  int _firstSelectedIndex = -1;
  int _secondSelectedIndex = -1;
  bool _isChecking = false; // Flag to avoid multiple taps during check
  int score = 0;

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
    score = 0; // Reset score
    _firstSelectedIndex = -1;
    _secondSelectedIndex = -1;
    _isChecking = false; // Reset the checking flag
  }

  // Function to check if two selected cards match
  void _checkForMatch() async {
    if (_firstSelectedIndex != -1 && _secondSelectedIndex != -1) {
      setState(() {
        _isChecking = true; // Set flag to prevent taps during check
      });

      if (cards[_firstSelectedIndex].imageAssetPath ==
          cards[_secondSelectedIndex].imageAssetPath) {
        setState(() {
          cards[_firstSelectedIndex].isMatched = true;
          cards[_secondSelectedIndex].isMatched = true;
          score += 10; // Increase score when match is found
        });
      } else {
        // Delay the face-down flip after a short delay if cards don't match
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          cards[_firstSelectedIndex].isFaceUp = false;
          cards[_secondSelectedIndex].isFaceUp = false;
        });
      }
      setState(() {
        _firstSelectedIndex = -1;
        _secondSelectedIndex = -1;
        _isChecking = false; // Reset flag after check is done
      });
    }
  }

  // Function to handle when a card is tapped
  void _onCardTapped(int index) {
    if (_isChecking || cards[index].isFaceUp || cards[index].isMatched) {
      return; // Ignore taps during checking, or on already face-up or matched cards
    }
    setState(() {
      cards[index].isFaceUp = true;
      if (_firstSelectedIndex == -1) {
        _firstSelectedIndex = index;
      } else {
        _secondSelectedIndex = index;
        _checkForMatch(); // Check for match after selecting second card
      }
    });
  }

  // Function to check if all cards are matched (Victory condition)
  bool _checkForWin() {
    return cards.every((card) => card.isMatched);
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  children: List.generate(cards.length, (index) {
                    return GestureDetector(
                      onTap: () => _onCardTapped(index),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: cards[index].isFaceUp || cards[index].isMatched
                              ? Colors.grey
                              : Colors.yellow,
                          borderRadius: BorderRadius.circular(8.0),
                          image: cards[index].isFaceUp || cards[index].isMatched
                              ? DecorationImage(
                                  image:
                                      AssetImage(cards[index].imageAssetPath),
                                  fit: BoxFit.cover,
                                )
                              : null, // Show image only if card is face-up or matched
                        ),
                        child: Center(
                          child: cards[index].isFaceUp || cards[index].isMatched
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
              SizedBox(height: 20),
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _initializeCards(); // Reset the game
                  });
                },
                child: Text('Restart Game'),
              ),
              if (_checkForWin()) // Show victory message if all cards are matched
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'You Win!',
                    style: TextStyle(fontSize: 32, color: Colors.green),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
