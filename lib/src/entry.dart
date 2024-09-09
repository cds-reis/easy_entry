/// A utility class representing a key-value pair entry within a map.
///
/// This class provides methods to manipulate the associated value of a key
/// in a given map. It is designed to work with immutable maps, meaning that
/// the map instance itself is not modified directly, but rather, the class
/// offers ways to interact with the values associated with the key.
///
/// Example usage:
/// ```dart
/// final map = <int, List<String>>{};
/// final entry = map.entry(10);
///
/// // Insert a value if not present.
/// entry.orInsert(['Hello']); // The map will have {10: 'Hello'}.
///
/// // Modify the existing value if present.
/// entry.andModify((value) => value.add('World')); // The map will have {10: ['Hello', 'World']}.
///
/// // Lazily insert a value if the key is not present.
/// map.entry(15).orInsertWith(() => ['New Entry']); // The map will have {10: ['Hello', 'World'], 15: ['New Entry']}.
///
/// // Insert a value using a key-dependent factory function if the key is not present.
/// map.entry(15).orInsertWithKey((key) => ['$key']); // The map will have {10: ['Hello', 'World'], 15: ['New Entry']}.
/// ```
final class Entry<K, V> {
  /// Creates a new [Entry] with the given key and map.
  ///
  /// The constructor is private and should be accessed via the `entry` extension
  /// on [Map].
  const Entry._({required this.key, required Map<K, V> map}) : _map = map;

  /// The key associated with this entry.
  final K key;

  final Map<K, V> _map;

  /// Modifies the value associated with the key using the provided function.
  ///
  /// If the key is present in the map, the provided function [f] is applied to
  /// the existing value. If the key is not present, the map remains unchanged.
  Entry<K, V> andModify(void Function(V value) f) {
    final value = _map[key];
    if (value == null) {
      return Entry._(key: key, map: _map);
    }

    f(value);

    return Entry._(key: key, map: _map);
  }

  /// Inserts a value into the map if the key is not already present.
  ///
  /// If the key is not present in the map, the provided [value] is inserted.
  /// If the key is already present, the existing value is returned.
  V orInsert(V value) => _map[key] ??= value;

  /// Lazily inserts a value into the map if the key is not already present.
  ///
  /// If the key is not present in the map, the value returned by the provided
  /// function [f] is inserted. If the key is already present, the existing
  /// value is returned.
  V orInsertWith(V Function() f) => _map[key] ??= f();

  /// Inserts a value into the map if the key is not already present, using
  /// a factory function that depends on the key.
  ///
  /// If the key is not present in the map, the value returned by the provided
  /// function [f], which takes the key as a parameter, is inserted. If the key
  /// is already present, the existing value is returned.
  V orInsertWithKey(V Function(K key) f) => _map[key] ??= f(key);
}

/// An extension on [Map] that provides a convenient way to create [Entry]
/// instances.
///
/// This extension allows you to easily create an [Entry] object for a given
/// key, which provides methods for manipulating the associated value in the
/// map.
extension EasyEntry<K, V> on Map<K, V> {
  /// Creates an [Entry] for the specified key in the map.
  Entry<K, V> entry(K key) => Entry._(key: key, map: this);
}
