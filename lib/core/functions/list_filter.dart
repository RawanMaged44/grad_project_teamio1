class ListFilter {
  static List<T> filter<T>({
    required List<T> items,
    required String query,
    required String Function(T item) getField,
  }) {
    if (query.trim().isEmpty) return items;
    final q = query.trim().toLowerCase();
    return items.where((item) => getField(item).toLowerCase().startsWith(q)).toList();
  }
}
