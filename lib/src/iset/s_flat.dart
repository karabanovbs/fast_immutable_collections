import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";

class SFlat<T> extends S<T> {
  final ListSet<T> _set;

  static S<T> empty<T>() => SFlat.unsafe(ListSet<T>.empty());

  SFlat(Iterable<T> iterable, {ConfigSet config})
      : assert(iterable != null),
        _set = ListSet.of(iterable, sort: (config ?? ISet.defaultConfig).sort);

  SFlat.unsafe(Set<T> set)
      : assert(set != null),
        _set = ListSet.unsafeView(set);

  @override
  ListSet<T> getFlushed(ConfigSet config) => _set;

  @override
  Iterator<T> get iterator => _set.iterator;

  @override
  bool get isEmpty => _set.isEmpty;

  @override
  Iterable<T> get iter => _set;

  @override
  T get anyItem => _set.first;

  @override
  bool contains(covariant T element) => _set.contains(element);

  @override
  int get length => _set.length;

  @override
  T get first => _set.first;

  @override
  T get last => _set.last;

  @override
  T get single => _set.single;

  @override
  T operator [](int index) => _set[index];

  bool deepSetEquals_toIterable(Iterable<T> other) {
    if (other == null) return false;
    Set<T> set = (other is Set<T>) ? other : Set<T>.of(other);
    return const SetEquality(MapEntryEquality()).equals(_set, set);
  }

  bool deepSetEquals(SFlat<T> other) =>
      (other == null) ? false : const SetEquality(MapEntryEquality()).equals(_set, other._set);

  int deepSetHashcode() => const SetEquality(MapEntryEquality()).hash(_set);
}
