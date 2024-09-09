import 'package:easy_entry/easy_entry.dart';

void main() {
  final map = <int, List<String>>{
    10: ['Hello'],
  };

  final helloWorld = map
      .entry(10)
      .andModify((value) => value.add('World'))
      .retainIf((value) => value.length == 2)
      .orInsert(['Default']);

  print(helloWorld);

  final item = map
      .entry(20)
      .andModify((value) => value.remove('Something from the list'))
      .orNull;

  print(item);
}
