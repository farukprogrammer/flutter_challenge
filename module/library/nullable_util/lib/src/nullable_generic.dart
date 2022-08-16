/// Warning, this doesn't work on dynamic type, cast them first.
extension NullableGeneric<T> on T? {
  /// return instance if it's not null, otherwise return [replace]
  /// easier to read and chain rather than using '= instance ?? replace'
  T or(T replace) {
    final self = this;
    if (self == null) {
      return replace;
    }
    return self;
  }

  R? let<R>(R Function(T) applicator) {
    final self = this;
    if (self != null) {
      return applicator(self);
    }
    return null;
  }

  R? castOrNull<R>() {
    final self = this;
    return self is R ? self : null;
  }

  R castOrFallback<R>(R fallback) {
    final self = this;
    return self is R ? self : fallback;
  }
}

T? castOrNull<T>(dynamic x) => x is T ? x : null;

T castOrFallback<T>(dynamic x, T fallback) => x is T ? x : fallback;
