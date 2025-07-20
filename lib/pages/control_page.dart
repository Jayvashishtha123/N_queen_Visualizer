import 'package:flutter/material.dart';
import 'package:n_queen_visualizer/model/nqueen_model.dart';
import 'package:provider/provider.dart';

class NQueenControlPage extends StatelessWidget {
  const NQueenControlPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Controls',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
      ),
      body: Center(
        child: Consumer<NQueenModel>( // <-- This listens for changes!
          builder: (context, model, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Board Size',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Slider(
                value: model.n.toDouble(),
                min: 4,
                max: 12,
                divisions: 8,
                label: '${model.n}',
                onChanged: (val) {
                  model.setN(val.toInt());
                },
                activeColor: Colors.deepPurpleAccent,
                inactiveColor: Colors.white24,
              ),
              ElevatedButton(
                onPressed: () => model.setN(model.n),
                child: const Text('Solve Again'),
              ),
              Text(
                'N = ${model.n}',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}