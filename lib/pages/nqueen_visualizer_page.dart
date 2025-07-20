import 'package:flutter/material.dart';
import 'package:n_queen_visualizer/model/nqueen_model.dart';
import 'package:provider/provider.dart';

class NQueenVisualizerPage extends StatelessWidget {
  const NQueenVisualizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NQueenModel>();
    final board = model.currentBoard;
    final n = model.n;

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
            'N-Queens Visualizer',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
      ),
      body: Center(
        child: board.isEmpty
            ? const Text('No solution!', style: TextStyle(color: Colors.white))
            : _buildChessBoard(board, n),
      ),
      bottomNavigationBar: Container(
        color: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: model.prevSolution,
            ),
            Text(
              'Solution ${model.currentStep + 1} / ${model.solutions.length}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: model.nextSolution,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChessBoard(List<int> board, int n) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: n,
          ),
          itemCount: n * n,
          itemBuilder: (context, index) {
            final row = index ~/ n;
            final col = index % n;
            final isQueen = board.isNotEmpty && board[row] == col;
            final isLight = (row + col) % 2 == 0;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: isLight ? Colors.white : Colors.deepPurple,
              ),
              child: Center(
  child: AnimatedOpacity(
    duration: const Duration(milliseconds: 300),
    opacity: isQueen ? 1.0 : 0.0,
    child: Text(
      '\u265B', // Chess queen unicode
      style: TextStyle(
        color: Colors.redAccent,
        fontSize: (330 / n).clamp(28, 46),
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
            );
          },
        ),
      ),
    );
  }
}