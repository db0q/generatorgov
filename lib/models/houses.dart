// models/house.dart
class House {
  final String id;
  final String name;
  final String address;
  final List<Bill> bills;

  House({required this.id, required this.name, required this.address, required this.bills});

  factory House.fromJson(Map<String, dynamic> json) {
    var list = json['bills'] as List;
    List<Bill> billList = list.map((i) => Bill.fromJson(i)).toList();

    return House(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      bills: billList,
    );
  }
}

// models/bill.dart
class Bill {
  final String id;
  final String description;
  final double amount;
  final DateTime date;

  Bill({required this.id, required this.description, required this.amount, required this.date});

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'],
      description: json['description'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }
}
