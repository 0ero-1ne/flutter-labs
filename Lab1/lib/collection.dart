import 'package:lab1/bread.dart';

class Collection implements Iterable<Bread> {
  final List<Bread> _items = [];

  void add(Bread Bread) => _items.add(Bread);

  @override
  Iterator<Bread> get iterator => _items.iterator;

  @override
  bool any(bool Function(Bread element) test)=>_items.any(test);

  @override
  Iterable<R> cast<R>()=> _items.cast();

  @override
  bool contains(Object? element)=>_items.contains(element);

  @override
  Bread elementAt(int index)=> _items.elementAt(index);

  @override
  bool every(bool Function(Bread element) test)=> _items.every(test);

  @override
  Bread get first => _items.first;

  @override
  Bread firstWhere(bool Function(Bread element) test,{Bread Function()? orElse}) =>_items.firstWhere(test, orElse: orElse);

  @override
  Iterable<Bread> followedBy(Iterable<Bread> other)=> _items.followedBy(other);

  @override
  void forEach(void Function(Bread element) action)=> _items.forEach(action);

  @override
  bool get isEmpty => _items.isEmpty;

  @override
  bool get isNotEmpty => _items.isNotEmpty;

  @override
  String join([String separator = ""])=> _items.join(separator);

  @override
  Bread get last => _items.last;

  @override
  Bread lastWhere(bool Function(Bread element) test,{Bread Function()? orElse}) =>_items.lastWhere(test, orElse: orElse);

  @override
  int get length => _items.length;

  @override
  Bread reduce(Bread Function(Bread value, Bread element) combine)=> _items.reduce(combine);

  @override
  Bread get single => _items.single;

  @override
  Bread singleWhere(bool Function(Bread element) test,{Bread Function()? orElse})=> _items.singleWhere(test, orElse: orElse);

  @override
  Iterable<Bread> skip(int count)=> _items.skip(count);

  @override
  Iterable<Bread> skipWhile(bool Function(Bread value) test)=> _items.skipWhile(test);

  @override
  Iterable<Bread> take(int count)=> _items.take(count);

  @override
    Iterable<Bread> takeWhile(bool Function(Bread value) test)=> _items.takeWhile(test);

  @override
  List<Bread> toList({bool growable = true})=> toList(growable: growable);

  @override
  Set<Bread> toSet()=> _items.toSet();

  @override
  Iterable<Bread> where(bool Function(Bread element) test)=> _items.where(test);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(Bread element) toElements) => _items.expand(toElements);

  @override
  T fold<T>(T initialValue, T Function(T previousValue, Bread element) combine) {
    // BreadODO: implement fold
    throw UnimplementedError();
  }

  @override
  Iterable<T> map<T>(T Function(Bread e) toElement) {
    // BreadODO: implement map
    throw UnimplementedError();
  }

  @override
  Iterable<T> whereType<T>() {
    // TODO: implement whereType
    throw UnimplementedError();
  }
}