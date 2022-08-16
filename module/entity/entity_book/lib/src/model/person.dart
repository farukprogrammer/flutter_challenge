import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
  final String name;
  final int? birthYear;
  final int? deathYear;

  Person({
    required this.name,
    this.birthYear,
    this.deathYear,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        name: json['name'] as String,
        birthYear: json['birth_year'] == null
            ? null
            : int.tryParse(json['birth_year']),
        deathYear: json['death_year'] == null
            ? null
            : int.tryParse(json['death_year']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'birth_year': birthYear,
        'death_year': deathYear,
      };
}
