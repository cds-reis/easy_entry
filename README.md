A simple, readable and concise way to deal with modifying, inserting and removing Map entries in Dart.

Inspired on Rust's [Entry API](https://doc.rust-lang.org/std/collections/hash_map/enum.Entry.html).

## Usage

Add `easy_entry` to our dependencies in `pubspec.yaml`:

```yaml
dependencies:
  easy_entry: ^1.0.0
```

Next, import the library:

```dart
import 'package:easy_entry/easy_entry.dart';
```

### Get a map's entry

Use the `.entry(key)` method on a map to get an entry:

```dart
final map = <int, List<String>>{};

map.entry(10);
```

Then, you can perform operations on your entry to modify, insert or remove it from the map:

```dart
final items = map
      .entry(10)
      .retainIf((value) => value.isNotEmpty)
      .andModify((value) => value.add('Another Item'))
      .orInsert([]);
```

#### Inserting

Use any of the `orInsert` methods to insert an value if there isn't a current entry with the given key:

```dart
final map = <int, String> {};

final String value1 = map.entry(1).orInsert('Item 1'); // Inserts the value if the key is not present.
final String value2 = map.entry(2).orInsertWith(() => 'Item 2'); // Lazily inserts the value.
final String value3 = map.entry(3).orInsertWithKey((key) => 'Item $key'); // Lazily inserts the value with the key.
```

#### Modifying

If you want to replace the value of the given entry, use any of the `replace` methods:

```dart
final map = <int, String> {
  1: 'Item 1',
  2: 'Item 2',
  3: 'Item 3',
};

final entry1 = map.entry(1).replace('User item 1');
final entry2 = map.entry(2).replaceWith(() => 'User item 2');.
final entry3 = map.entry(3).replaceWithKey((key) => 'User item $key');
final entry4 = map.entry(4).replaceWith(() => 'User item 4'); // Since there is no entry with the key 4, the entry will remain empty.
```

If you instead want to modify the value of the entry, like adding an item to a `List`, then use `andModify`:

```dart
final map = <int, List<String>>{
  1: ['Item 1', 'Item 2'],
};

map.andModify((value) => value.add('Item 3'));
```

#### Filtering

If you want to filter if the value of the entry is valid, you can use `retainIf` to retain the value if it satisfie the condition:

```dart
final map = <int, List<String>>{
  1000: ['Item 1', 'Item 2'],
};

map.entry(1000).retainIf((value) => value.isNotEmpty);
```

A common thing to do is to check if the value is valid, and, in the case of an invalid value, insert a default value for the entry:

```dart
final map = <int, List<String>>{
  1000: ['Item 1', 'Item 2'],
};

final items = map
      .entry(1000)
      .retainIf((value) => value.length >= 1)
      .orInsertWithKey((key) => ['Default Item $key']);
```

#### Removing

You can also remove the entry from the map, returning the value if it was present:

```dart
final map = <int, List<String>>{
  1000: ['Item 1', 'Item 2'],
};

final removedItems = map.entry(1000).remove();
```
