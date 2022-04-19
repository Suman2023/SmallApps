import 'package:hive/hive.dart';

part 'todo_adapter.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  DateTime? dateTime;
}
