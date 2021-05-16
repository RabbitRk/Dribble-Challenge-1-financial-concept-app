import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterNotifier extends ChangeNotifier{
  int _counter = 0;

  int get value => _counter;

  void updateCounter(int i)
  {
    _counter = i;
    notifyListeners();
  }
}