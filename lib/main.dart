import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);

  runApp(MyApp());
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  print("Task Enter");
  Workmanager().executeTask((task, inputData) async {
    print("Task $task and input $inputData");
    for (int i = 1; i <= 10; i++) {
      print("Index $i");
      await Future.delayed(const Duration(seconds: 2));

      if (i == 10) {
        print('Task executed in background for Flutter');
      }
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BackgroundTaskScreen(),
    );
  }
}

class BackgroundTaskScreen extends StatefulWidget {
  @override
  _BackgroundTaskScreenState createState() => _BackgroundTaskScreenState();
}

class _BackgroundTaskScreenState extends State<BackgroundTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Task Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Workmanager().registerOneOffTask(
                "task-identifier",
                 "simpleTaskKey", // Ignored on iOS
                initialDelay: const Duration(seconds: 10),
                constraints: Constraints(
                  // connected or metered mark the task as requiring internet
                  networkType: NetworkType.connected,
                  // require external power
                  requiresCharging: true,
                ),
                inputData:  <String, String>{}// fully supported
            ).then((value) {
              print("Registered");
            }).onError(printErrror);
          },
          child: Text('Start Background Task'),
        ),
      ),
    );
  }

  FutureOr<Null> printErrror(Object error, StackTrace stackTrace) {
    print("Someethign $error");
  }
}
