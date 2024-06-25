final di = _Di();

class _Di {
  final Map<Type, dynamic> _di = {};

  void set<T>(T obj) {
    _di[T] = obj;
  }

  T get<T>() => _di[T] as T;
}