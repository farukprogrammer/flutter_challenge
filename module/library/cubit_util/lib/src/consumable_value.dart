class ConsumableValue<T> {
  bool _isConsumed = false;
  final T _value;

  ConsumableValue(this._value);

  T? get value {
    if (_isConsumed) return null;
    _isConsumed = true;
    return _value;
  }
}
