import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/homescreen_providers.dart';
import 'package:todo/providers/todo_providers.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  // PageController _pageController = PageController();
  // void goToNext()
  // {

  // }

  @override
  Widget build(BuildContext context, ref) {
    final _currentChip = ref.watch(currentChipStateProvider.state);
    final _pageController = ref.watch(pageControllerState.state);
    final _currentSelection = ref.watch(currentChipStateProvider.state);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Welcome Back!"),
                    Text(
                      "Here's Update Today.",
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.search))
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StateChip(
                title: "Today",
                bgColor: _currentChip.state == 0 ? Colors.black : Colors.white,
                textColor:
                    _currentChip.state == 0 ? Colors.white : Colors.black,
              ),
              StateChip(
                title: "Upcoming",
                bgColor: _currentChip.state == 1 ? Colors.black : Colors.white,
                textColor:
                    _currentChip.state == 1 ? Colors.white : Colors.black,
              ),
              StateChip(
                title: "Completed",
                bgColor: _currentChip.state == 2 ? Colors.black : Colors.white,
                textColor:
                    _currentChip.state == 2 ? Colors.white : Colors.black,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: PageView(
              controller: _pageController.state,
              onPageChanged: (currIndex) {
                _currentSelection.state = currIndex;
              },
              children: const [
                TasksView(
                  title: "Today",
                ),
                TasksView(
                  title: "Upcoming",
                ),
                TasksView(
                  title: "Completed",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TasksView extends StatelessWidget {
  final String title;
  const TasksView({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final _getAllHabits = ref.watch(getAllTasksProvider);
      return _getAllHabits.when(
          data: (_data) => _data.isNotEmpty
              ? ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: ((context, index) =>
                      taskCard(task: _data[index])))
              : Center(
                  child: Text("All DOne for the day"),
                ),
          error: (_, __) => Center(
                child: Text("SOmething went wrong please retry"),
              ),
          loading: () => Center(
                child: CircularProgressIndicator(),
              ));
    });
  }

  Widget taskCard({required Map<String, String> task}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Chip(
                  label: Text("Tag 1"),
                  // backgroundColor: Colors.red,
                  side: BorderSide(width: 1),
                ),
                const SizedBox(
                  width: 2,
                ),
                const Chip(
                  label: Text("Tag 2"),
                  // backgroundColor: Colors.red,
                  side: BorderSide(width: 1),
                ),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
              ],
            ),
            Text(
              task['habit_name'].toString(),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Row(
              children: const [Icon(Icons.calendar_today), Text("Date")],
            ),
            Row(
              children: [
                const Icon(Icons.watch_later_sharp),
                const Text("TIme"),
                const Spacer(),
                Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    value: true,
                    onChanged: (val) {})
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StateChip extends StatelessWidget {
  final String title;
  final Color bgColor, textColor;
  final BoxBorder? border;
  const StateChip(
      {Key? key,
      this.border,
      required this.title,
      required this.bgColor,
      required this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final _currentSelection = ref.watch(currentChipStateProvider.state);
      final _pageController = ref.watch(pageControllerState.state);
      return Expanded(
        child: GestureDetector(
          onTap: () {
            switch (title) {
              case "Today":
                _currentSelection.state = 0;
                _pageController.state.animateToPage(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
                break;
              case "Upcoming":
                _currentSelection.state = 1;
                _pageController.state.animateToPage(1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
                break;
              case "Completed":
                _currentSelection.state = 2;
                _pageController.state.animateToPage(2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
                break;
              default:
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: bgColor,
              border: border,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
                child: Text(
              title,
              style: TextStyle(color: textColor),
            )),
          ),
        ),
      );
    });
  }
}
