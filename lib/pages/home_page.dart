import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_app/util/habit_tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Habit Summary
  List habitList = [
    // [name, boolean, timespent timegoal]
    ['Exercise', false, 0, 10],
    ['Read', false, 0, 20],
    ['Study', false, 0, 20],
    ['Work', false, 0, 40],
  ];

  void habitStarted(int index) {
    var startTime = DateTime.now();

    // include the time already elapsed
    int elapsedTime = habitList[index][2];

    // start and stop
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    if (habitList[index][1]) {
      // keep the time going
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          // check if the button stop was pressed
          if (habitList[index][1] == false) {
            timer.cancel();
          }

          // calculate the time elapsed by camparing current time and start time
          var currentTime = DateTime.now();
          habitList[index][2] =
              elapsedTime +
              currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void settingsOpened(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text('Settings for ' + habitList[index][0]));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Work Smart And Hard 💪",
          style: TextStyle(color: Colors.grey[100]),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: ((context, index) {
          return HabitTiles(
            habitName: habitList[index][0],
            onTap: () {
              habitStarted(index);
            },
            settingsTapped: () {
              settingsOpened(index);
            },
            habitStarted: habitList[index][1],
            timeGoal: habitList[index][3],
            timeSpent: habitList[index][2],
          );
        }),
      ),
    );
  }
}
