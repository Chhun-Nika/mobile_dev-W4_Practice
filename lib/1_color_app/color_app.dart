import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType {
  red("red", Colors.red),
  blue("blue", Colors.blue),
  yellow("yellow", Colors.yellow),
  green("green", Colors.green);

  final String label;
  final Color color;

  const CardType(this.label, this.color);
}

// this service act as subject for other widget to listen to
class ColorService extends ChangeNotifier {
  // int redCount = 0;
  // int blueCount = 0;
  // int yellowCount = 0;
  // int greenCount = 0;
  // initialize count for each card type to 0
  // using the collection-for as a shortcut,
  // beside this we can loop inside constructor or use static method so that the value is initialize
  // when this class is instantiated
  final Map<CardType, int> _counts = {
    for (var type in CardType.values) type: 0,
  };

  Map<CardType, int> get counts => _counts;

  void increment(CardType type) {
    // value from map can be null, increment does not work
    _counts[type] = (_counts[type] ?? 0) + 1;
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
          // ColorTap(type: CardType.red),
          // ColorTap(type: CardType.blue),
          // ColorTap(type: CardType.yellow),
          // ColorTap(type: CardType.green),
          for (var type in CardType.values) ColorTap(type: type),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  // Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

  // int get tapCount =>
  //     type == CardType.red ? colorService.redCount : colorService.blueCount;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            colorService.increment(type);
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: type.color,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(
                'Taps: ${colorService.counts[type]}',
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
        child: ListenableBuilder(
          listenable: colorService,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var type in CardType.values)
                  Text("${type.label} counts = ${colorService._counts[type]}"),
              ],
            );
          },
        ),
      ),
    );
  }
}
