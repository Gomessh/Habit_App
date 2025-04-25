import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTiles extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingsTapped;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;

  const HabitTiles({
    super.key,
    required this.habitName,
    required this.onTap,
    required this.settingsTapped,
    required this.habitStarted,
    required this.timeGoal,
    required this.timeSpent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        CircularPercentIndicator(
                          radius: 30,
                          lineWidth: 5.0,
                          progressColor: Colors.green,
                          backgroundColor: Colors.grey[300]!,
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                        ),

                        // Play/Pause button
                        Center(
                          child: Icon(
                            habitStarted ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      habitName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Progress
                    Text(
                      '$timeSpent / $timeGoal',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(onTap: settingsTapped, child: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
