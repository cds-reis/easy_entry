import 'package:easy_entry/easy_entry.dart';
import 'package:test/test.dart';

void main() {
  group('Entry', () {
    late Map<String, List<String>> map;
    late Entry<String, List<String>> entry;

    setUp(() {
      map = {};
      entry = map.entry('key');
    });

    group('andModify', () {
      test('modifies existing value', () {
        map['key'] = ['value1'];
        entry.andModify((value) => value.add('value2'));
        expect(map['key'], ['value1', 'value2']);
      });

      test('does nothing if key does not exist', () {
        entry.andModify((value) => value.add('value2'));
        expect(map['key'], null);
      });
    });
    group('retainIf', () {
      test('retains value if predicate is true', () {
        map['key'] = ['value1'];
        entry.retainIf((value) => value.contains('value1'));
        expect(map['key'], ['value1']);
      });

      test('removes value if predicate is false', () {
        map['key'] = ['value1'];
        entry.retainIf((value) => value.isEmpty);
        expect(map['key'], null);
      });
    });
    group('remove', () {
      test('removes entry if exists', () {
        map['key'] = ['value1'];
        final removedValue = entry.remove();
        expect(removedValue, ['value1']);
        expect(map['key'], null);
      });

      test('returns null if entry does not exist', () {
        final removedValue = entry.remove();
        expect(removedValue, null);
      });
    });
    group('exists', () {
      test('returns true if key exists', () {
        map['key'] = ['value1'];
        expect(entry.exists, true);
      });

      test('returns false if key does not exist', () {
        expect(entry.exists, false);
      });
    });

    group('orNull', () {
      test('returns value if key exists', () {
        map['key'] = ['value1'];
        expect(entry.orNull, ['value1']);
      });

      test('returns null if key does not exist', () {
        expect(entry.orNull, null);
      });
    });
    group('orInsert', () {
      test('inserts value if key does not exist', () {
        final value = entry.orInsert(['new value']);
        expect(value, ['new value']);
        expect(map['key'], ['new value']);
      });

      test('returns existing value if key exists', () {
        map['key'] = ['existing value'];
        final value = entry.orInsert(['new value']);
        expect(value, ['existing value']);
      });
    });
    group('orInsertWith', () {
      test('inserts value if key does not exist', () {
        final value = entry.orInsertWith(() => ['lazy value']);
        expect(value, ['lazy value']);
        expect(map['key'], ['lazy value']);
      });

      test('returns existing value if key exists', () {
        map['key'] = ['existing value'];
        final value = entry.orInsertWith(() => ['lazy value']);
        expect(value, ['existing value']);
      });
    });
    group('orInsertWithKey', () {
      test('inserts value using key-dependent factory function', () {
        final value = map.entry('key123').orInsertWithKey((key) => [key]);
        expect(value, ['key123']);
        expect(map['key123'], ['key123']);
      });

      test('returns existing value if key exists', () {
        map['key123'] = ['existing value'];
        final value = map.entry('key123').orInsertWithKey((key) => [key]);
        expect(value, ['existing value']);
      });
    });

    test('andModify and orInsert', () {
      final newEntry = map.entry('key2');
      newEntry
          .andModify((value) => value.add('value2'))
          .orInsert(['initial value']);
      expect(map['key2'], ['initial value']);
    });

    test('retainIf and orInsert', () {
      map['key4'] = ['value1'];
      map
          .entry('key4')
          .retainIf((value) => value.contains('value1'))
          .orInsert(['default value']);
      expect(map['key4'], ['value1']);
    });
  });
}
