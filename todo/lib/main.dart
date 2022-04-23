import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/adapters/todo_adapter.dart';
import 'package:todo/locator.dart';
import 'package:todo/views/authentication_screen.dart';
import 'package:todo/views/main_screen.dart';

void main() async {
  setup();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('alltodos');
  await Hive.openBox('accounts');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Box accountBox = Hive.box('accounts');
    return MaterialApp(
        title: 'Todo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: accountBox.get('token') == null
            ? AuthenticationScreen()
            : MainScreen());
  }
}
