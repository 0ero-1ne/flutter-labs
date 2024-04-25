class Store<Bread> implements Iterator {
  int _breadIndex = -1;
  List<Bread> _breads = [];

  Store(List<Bread> store) {
    _breads = store;
  }

  @override
  get current {
    if (_breadIndex >= 0 && _breadIndex <= _breads.length - 1) {
      return _breads[_breadIndex];
    }
  }

  @override
  bool moveNext() {
    if (_breadIndex < _breads.length - 1) {
      _breadIndex++;
      return true;
    }
    return false;
  }
}