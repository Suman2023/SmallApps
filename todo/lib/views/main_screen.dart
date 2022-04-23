import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/bottom_navbar_provider.dart';
import 'package:todo/views/add_todo.dart';
import 'package:todo/views/dashboard_screen.dart';
import 'package:todo/views/habits_screen.dart';
import 'package:todo/views/home_screen.dart';
import 'package:todo/views/profile_screen.dart';

class MainScreen extends ConsumerWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<Widget> _screens = [
    HomeScreen(),
    HabitScreen(),
    DashboardScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, ref) {
    final _currentIndex = ref.watch(buttomNavbarCurrentIndexProvider.state);
    final _addButtonVisible = ref.watch(addButtonProvider.state);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // _addButtonVisible.state = false
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return bottomSheet();
                });
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: true,
          currentIndex: _currentIndex.state,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.graphic_eq), label: 'Habits'),
            BottomNavigationBarItem(
                icon: Icon(Icons.grid_on_sharp), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          onTap: (int index) {
            _currentIndex.state = index;
          },
        ),
        body: IndexedStack(
          children: _screens,
          index: _currentIndex.state,
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.8,
        builder: ((context, scrollController) => Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: AddTodoScreen(),
            )));
  }
}
