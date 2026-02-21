import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue, yellow, green }

// this service act as subject for other widget to listen to
class ColorService extends ChangeNotifier {
  int redCount = 0;
  int blueCount = 0;
  int yellowCount = 0;
  int greenCount = 0;

  void onRedTap() {
    redCount++;
    notifyListeners();
  }

  void onBlueTap() {
    blueCount++;
    notifyListeners();
  }

  void onYellowTap() {
    yellowCount++;
    notifyListeners();
  }

  void onGreenTap() {
    greenCount++;
    notifyListeners();
  }
}

final ColorService colorService = ColorService();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ColorTap(type: CardType.red),
          ColorTap(type: CardType.blue),
          ColorTap(type: CardType.yellow),
          ColorTap(type: CardType.green),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  // Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;
  Color get backgroundColor {
    switch (type) {
      case CardType.red:
        return Colors.red;
      case CardType.blue:
        return Colors.blue;
      case CardType.yellow:
        return Colors.yellow;
      case CardType.green:
        return Colors.green;
    }
  }

  // int get tapCount =>
  //     type == CardType.red ? colorService.redCount : colorService.blueCount;

  int get tapCount {
    switch (type) {
      case CardType.red:
        return colorService.redCount;
      case CardType.blue:
        return colorService.blueCount;
      case CardType.yellow:
        return colorService.yellowCount;
      case CardType.green:
        return colorService.greenCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            switch (type) {
      case CardType.red:
        return colorService.onRedTap();
      case CardType.blue:
        return colorService.onBlueTap();
      case CardType.yellow:
        return colorService.onYellowTap();
      case CardType.green:
        return colorService.onGreenTap();
    }
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(
                'Taps: $tapCount',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Red Taps: ${colorService.redCount}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Blue Taps: ${colorService.blueCount}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Yellow Taps: ${colorService.yellowCount}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Green Taps: ${colorService.greenCount}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
