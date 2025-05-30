import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fitness_app/frontend/states/index.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStreakBanner(),
              const SizedBox(height: 24),
              const Text(
                'Recent Activity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // dummy data to be replaced with data from backend
              FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No posts yet."));
                  }

                  return Column(
                    children: snapshot.data!.map((post) {
                      return _Post(
                        username: post['username'],
                        description: post['description'],
                        date: post['date'],
                        workoutType: post['workoutType'],
                        duration: post['duration'],
                        exerciseCount: post['exerciseCount'],
                        likes: post['likes'],
                        comments: post['comments'],
                      );
                    }).toList(),
                  );
                },
              ),

              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('View More Workouts'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // streak banner with progress and buttons
  Widget _buildStreakBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(100),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(40, 0, 0, 0),
            offset: Offset(0, 1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🔥 70',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Streak',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          //  switches to the 'Log Workout'
                          context
                              .findAncestorStateOfType<IndexState>()
                              ?.setState(() {
                            context
                                .findAncestorStateOfType<IndexState>()
                                ?.selectedPage = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(154, 197, 244, 1),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Log Workout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          //  Implement Start Workout logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Start Workout',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          CircularPercentIndicator(
            radius: 70.0,
            lineWidth: 15.0,
            percent: 4 / 5,
            center: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ("${4 / 5 * 100}%"),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Daily Achievements",
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            progressColor: const Color.fromRGBO(154, 197, 244, 1),
            backgroundColor: const Color.fromRGBO(154, 197, 244, 0.4),
            animation: true,
          ),
        ],
      ),
    );
  }

  //  post  widget
  Widget _Post({
    required String username,
    required String description,
    required String date,
    required String workoutType,
    required int duration,
    required int exerciseCount,
    required int likes,
    required int comments,
  }) {
    String formattedTime;
    final DateTime postTime = DateTime.parse(date);
    final Duration difference = DateTime.now().difference(postTime);

    if (difference.inMinutes < 1) {
      formattedTime = 'Just now';
    } else if (difference.inHours < 1) {
      formattedTime = '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      formattedTime = '${difference.inHours}h ago';
    } else {
      formattedTime = DateFormat('d MMMM y').format(postTime);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(description),
          const SizedBox(height: 8),
          Text(
            formattedTime,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('❤️ $likes   💬 $comments'),
              TextButton(
                onPressed: () {
                  // View workout detail
                },
                child: const Text('View Workout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// replace with backend logic
Future<List<Map<String, dynamic>>> fetchPosts() async {
  await Future.delayed(Duration(seconds: 1));
  return [
    {
      'username': 'FitFish1',
      'description': 'Morning Run',
      'date': '2025-01-15T06:30:00',
      'workoutType': 'Cardio',
      'duration': 45,
      'exerciseCount': 4,
      'likes': 3,
      'comments': 1,
    },
    {
      'username': 'FitFish2',
      'description': 'Strength Training',
      'date': '2025-01-18T09:00:00',
      'workoutType': 'Strength',
      'duration': 60,
      'exerciseCount': 5,
      'likes': 5,
      'comments': 2,
    }
  ];
}
