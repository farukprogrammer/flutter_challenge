import 'dart:convert';

import 'format.dart';
import 'person.dart';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String personToJson(Book data) => json.encode(data.toJson());

class Book {
  final int id;
  final String title;
  final List<String> subjects;
  final List<Person> authors;
  final List<Person> translators;
  final List<String> bookshelves;
  final List<String> languages;
  final bool? copyright;
  final String mediaType;
  final Format formats;
  final int downloadCount;

  Book({
    required this.id,
    required this.title,
    this.subjects = const <String>[],
    this.authors = const <Person>[],
    this.translators = const <Person>[],
    this.bookshelves = const <String>[],
    this.languages = const <String>[],
    this.copyright,
    this.mediaType = '',
    this.formats = const Format(),
    this.downloadCount = 0,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: int.tryParse(json['id']) ?? 0,
        title: json['title'] as String,
        subjects: (json['subjects'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        authors: (json['authors'] as List<dynamic>?)
                ?.map((e) => personFromJson(e))
                .toList() ??
            [],
        translators: (json['translators'] as List<dynamic>?)
                ?.map((e) => personFromJson(e))
                .toList() ??
            [],
        bookshelves: (json['bookshelves'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        languages: (json['languages'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        copyright: json['copyright'] as bool?,
        mediaType: json['media_type'] as String,
        formats: json['formats'] == null
            ? const Format()
            : formatFromJson(json['formats']),
        downloadCount:
            int.tryParse(json['download_count'] as String? ?? '0') ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subjects': subjects,
        'authors': authors,
        'translators': translators,
        'bookshelves': bookshelves,
        'languages': languages,
        'copyright': copyright,
        'media_type': mediaType,
        'formats': formats,
        'download_count': downloadCount,
      };
}