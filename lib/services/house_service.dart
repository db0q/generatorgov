// services/house_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:generator/Models/houses.dart';

class HouseService {
  Future<List<House>> fetchHouses() async {
    final response = await http.get(Uri.parse('your_api_endpoint'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((house) => House.fromJson(house)).toList();
    } else {
      throw Exception('Failed to load houses');
    }
  }
}
