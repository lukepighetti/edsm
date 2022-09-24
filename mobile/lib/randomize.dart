/// Given a List, return an iterable that is
///
///  - of specified length
///  - randomizes the order of the list
///  - ensures no consecutive duplicates
///  - runs through all elements in seed before repeating chunk
Iterable<T> randomize<T>(List<T> seed, {int length = 1000}) {
  return _randomize(seed).take(length);
}

Iterable<T> _randomize<T>(List<T> seed) sync* {
  var stack = <T>[];

  T? last;

  while (true) {
    if (stack.isEmpty) {
      final newChunk = List<T>.from(seed)..shuffle();

      if (last != null && last == newChunk.last) {
        newChunk.insert(0, newChunk.removeLast());
      }

      stack.addAll(newChunk);
    } else {
      final current = stack.removeLast();

      if (stack.isEmpty) {
        last = current;
      }

      yield current;
    }
  }
}
