class User {
  final int phoneNumber;
  final String name;
  final String password ;
  final String address ;
  final int generatorId;

  const User({
    required this.phoneNumber,
    required this.name,
    required this.password ,
    required this.address ,
    required this.generatorId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        phoneNumber: json["phoneNumber"],
        name: json["name"],
        password: json["password"],
        address: json["address"],
        generatorId: json["generatorId"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "name": name,
        "password": password ,
        "address": address ,
        "generatorId": generatorId,
      };
}

class Generator {
  final int phoneNumber;
  final String name;
  final String password ;
  final int generatorId;

  const Generator({
    required this.phoneNumber,
    required this.name,
    required this.password ,
    required this.generatorId,
  });

  factory Generator.fromJson(Map<String, dynamic> json) => Generator(
        phoneNumber: json["phoneNumber"],
        name: json["name"],
        password: json["password"],
        generatorId: json["generatorId"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "name": name,
        "password": password ,
        "generatorId": generatorId,
      };
}