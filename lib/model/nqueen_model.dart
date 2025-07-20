import 'package:flutter/material.dart';

class NQueenModel extends ChangeNotifier {
  int _n;
  List<List<int>> _solutions = [];
  int _currentStep = 0;

  NQueenModel([this._n = 8]) {
    solve();
  }

  int get n => _n;
  List<List<int>> get solutions => _solutions;
  int get currentStep => _currentStep;
  List<int> get currentBoard => _solutions.isEmpty ? [] : _solutions[_currentStep];

  void setN(int newN) {
    _n = newN;
    _currentStep = 0;
    solve();
    notifyListeners();
  }

  void nextSolution() {
    if (_solutions.isEmpty) return;
    _currentStep = (_currentStep + 1) % _solutions.length;
    notifyListeners();
  }

  void prevSolution() {
    if (_solutions.isEmpty) return;
    _currentStep = (_currentStep - 1 + _solutions.length) % _solutions.length;
    notifyListeners();
  }

  void solve() {
    _solutions.clear();
    void dfs(int row, List<int> pos, Set<int> diag1, Set<int> diag2, Set<int> cols) {
      if (row == _n) {
        _solutions.add(List.from(pos));
        return;
      }
      for (int col = 0; col < _n; col++) {
        if (cols.contains(col) || diag1.contains(row-col) || diag2.contains(row+col)) continue;
        pos.add(col);
        cols.add(col);
        diag1.add(row-col);
        diag2.add(row+col);
        dfs(row+1, pos, diag1, diag2, cols);
        pos.removeLast();
        cols.remove(col);
        diag1.remove(row-col);
        diag2.remove(row+col);
      }
    }
    dfs(0, [], <int>{}, <int>{}, <int>{});
    _currentStep = 0;
    notifyListeners();
  }
}