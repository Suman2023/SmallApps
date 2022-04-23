import 'package:flutter/material.dart';
import 'package:todo/views/home_screen.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key? key}) : super(key: key);

  List taskColors = const [
    Colors.yellow,
    Colors.cyan,
    Colors.blue,
    Colors.red,
    Colors.brown,
    Colors.blueGrey,
    Colors.lightGreen,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("Add Task"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Color Task"),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (var i = 0; i < 14; i++) smallColorCircle(30, i % 7)
                ],
              ),
            ),
          ],
        ),
        Divider(
          thickness: 1,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title"),
            TextField(
              decoration: InputDecoration(),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deadline"),
            TextField(
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: IconButton(
                          onPressed: () async {
                            await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2023));
                          },
                          icon: Icon(Icons.date_range_outlined)))),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Task Type"),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                StateChip(
                    border: Border.all(),
                    title: "Basic",
                    bgColor: Colors.black,
                    textColor: Colors.white),
                const SizedBox(
                  width: 2,
                ),
                StateChip(
                    border: Border.all(),
                    title: "Urgent",
                    bgColor: Colors.white,
                    textColor: Colors.black),
                const SizedBox(
                  width: 2,
                ),
                StateChip(
                    border: Border.all(),
                    title: "Important",
                    bgColor: Colors.white,
                    textColor: Colors.black)
              ],
            ),
          ],
        ),
        ElevatedButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text("Save"),
            ))
      ],
    );
  }

  Widget smallColorCircle(double width, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: width,
        width: width,
        decoration: BoxDecoration(
            color: taskColors[index],
            borderRadius: BorderRadius.circular(width / 2)),
      ),
    );
  }
}
