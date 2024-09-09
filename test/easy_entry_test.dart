// Assuming the Entry and EasyEntry classes are defined in entry.dart
import 'package:easy_entry/easy_entry.dart';
import 'package:test/test.dart';

void main() {
  group('Entry', () {
    test('orInsert adds a value if the key is not present', () {
      final map = <int, List<String>>{};
      final entry = map.entry(10);

      entry.orInsert(['Hello']);

      expect(map[10], equals(['Hello']));
    });

    test('orInsert returns existing value if the key is present', () {
      final map = <int, List<String>>{
        10: ['Hello'],
      };

      final entry = map.entry(10);

      final value = entry.orInsert(['World']);

      expect(value, equals(['Hello']));
      expect(map[10], equals(['Hello']));
    });

    test('andModify applies function to the existing value', () {
      final map = <int, List<String>>{
        10: ['Hello']
      };

      final entry = map.entry(10);

      entry.andModify((value) => value.add('World'));

      expect(map[10], equals(['Hello', 'World']));
    });

    test('andModify does nothing if key is not present', () {
      final map = <int, List<String>>{};
      final entry = map.entry(10);

      entry.andModify((value) => value.add('World'));

      expect(map[10], isNull);
    });

    test('orInsertWith adds value from function if key is not present', () {
      final map = <int, List<String>>{};
      final entry = map.entry(10);

      entry.orInsertWith(() => ['Hello']);

      expect(map[10], equals(['Hello']));
    });

    test('orInsertWith returns existing value if key is present', () {
      final map = <int, List<String>>{
        10: ['Existing']
      };
      final entry = map.entry(10);

      final value = entry.orInsertWith(() => ['New']);

      expect(value, equals(['Existing']));
      expect(map[10], equals(['Existing']));
    });

    test(
        'orInsertWithKey adds value from function with key if key is not present',
        () {
      final map = <int, List<String>>{};
      final entry = map.entry(10);

      entry.orInsertWithKey((key) => ['Value for $key']);

      expect(map[10], equals(['Value for 10']));
    });

    test('orInsertWithKey returns existing value if key is present', () {
      final map = <int, List<String>>{
        10: ['Existing']
      };
      final entry = map.entry(10);

      final value = entry.orInsertWithKey((key) => ['New Value']);

      expect(value, equals(['Existing']));
      expect(map[10], equals(['Existing']));
    });
  });
}
