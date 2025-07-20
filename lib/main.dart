import 'package:flutter/material.dart';
import 'package:n_queen_visualizer/model/nqueen_model.dart';
import 'package:n_queen_visualizer/pages/control_page.dart';
import 'package:n_queen_visualizer/pages/nqueen_visualizer_page.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NQueenModel(8), // Default N=8
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'N-Queens Visualizer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const NQueenHomePage(),
    );
  }
}

class NQueenHomePage extends StatefulWidget {
  const NQueenHomePage({super.key});
  @override
  State<NQueenHomePage> createState() => _NQueenHomePageState();
}

class _NQueenHomePageState extends State<NQueenHomePage> {
  int _currentIndex = 0;
  final _pages = const [
    NQueenVisualizerPage(),
    NQueenControlPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        selectedLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_on), label: 'Visualizer'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Controls'),
        ],
      ),
    );
  }
}