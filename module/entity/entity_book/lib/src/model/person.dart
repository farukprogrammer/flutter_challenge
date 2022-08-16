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
        birthYear: json['birth_year'] as int?,
        deathYear: json['death_year'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'birth_year': birthYear,
        'death_year': deathYear,
      };
}
