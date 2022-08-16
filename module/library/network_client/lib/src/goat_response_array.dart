import 'package:nullable_util/nullable_util.dart';

import 'constants.dart';

class GoatResponseArray<T> {
  late int count;
  late String? next;
  late String? previous;
  late List<T> results;

  GoatResponseArray({
    this.count = 0,
    this.next,
    this.previous,
    this.results = const [],
  });

  GoatResponseArray.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) payloadTransformer,
  ) {
    final payload = castOrNull<List>(json[keyResults]);
    results = <T>[];
    if (payload != null) {
      for (var element in payload) {
        if (element is T) {
          results.add(element);
        } else {
          results.add(payloadTransformer(element));
        }
      }
    }
    count = int.tryParse(json[keyCount] as String? ?? '0') ?? 0;
    next = json[keyNext] as String?;
    previous = json[keyPrevious] as String?;
  }

  Map<String, dynamic> toJson(
    Map<String, dynamic> Function(T) payloadTransformer, {
    String? payloadName,
  }) {
    final _data = <String, dynamic>{};

    if (results.isNotEmpty) {
      _data[keyResults] = results.map(payloadTransformer).toList();
    }
    _data[keyCount] = count;
    _data[keyNext] = next;
    _data[keyPrevious] = previous;

    return _data;
  }
}