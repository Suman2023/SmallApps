import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/bottom_navbar_provider.dart';
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
        floatingActionButton: _addButtonVisible.state
            ? FloatingActionButton(
                onPressed: () {
                  // _addButtonVisible.state = false;

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      content: SingleChildScrollView(
                          child: Container(
                        height: 350,
                      ))));
                },
                child: const Icon(Icons.add),
              )
            : null,
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
}
