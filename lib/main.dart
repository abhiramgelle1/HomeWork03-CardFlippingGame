import 'package:flutter/material.dart';

void main() {
  runApp(CardMatchingGame());
}

class CardMatchingGame extends StatelessWidget {
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
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4, // 4x4 grid
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              children: List.generate(16, (index) {
                return Card(
                  color: Colors.yellow,
                  child: Center(
                    child: Text('Back', style: TextStyle(color: Colors.black)),
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
