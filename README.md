<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

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
