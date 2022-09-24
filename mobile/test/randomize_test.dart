import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/randomize.dart';

void main() {
  group('randomize', () {
    test('repeats once for double seed length', () {
      final seed = [1, 2, 3];
      final iterator = randomize(seed);

      expect(iterator.take(6).toList()..sort(), equals([1, 1, 2, 2, 3, 3]));
    });

    test('no repeats in 1000 iterations', () {
      final seed = [1, 2, 3];
      final iterator = randomize(seed, length: 1000);

      int? previous;
      for (final current in iterator) {
        expect(previous, isNot(equals(current)));
        previous = current;
      }
    });

    test('elementAt(0) equals elementAt(0)', () {
      final iterator = randomize([1, 2, 3, 4, 5, 6, 7, 8, 9]);

      for (var i = 0; i < 1000; i++) {
        expect(iterator.elementAt(0), equals(iterator.elementAt(0)));
      }
    });
  });
}
