// providers/house_provider.dart
import 'package:flutter/material.dart';
import 'package:generator/Models/houses.dart';
import '../services/house_service.dart';

class HouseProvider with ChangeNotifier {
  List<House> _houses = [];

  List<House> get houses => _houses;

  Future<void> fetchHouses() async {
    _houses = await HouseService().fetchHouses();
    notifyListeners();
  }
}
