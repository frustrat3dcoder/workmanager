import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);

  runApp(MyApp());
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(Duration(seconds: 2));

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
            Workmanager().registerOneOffTask('1', 'simpleTask');
          },
          child: Text('Start Background Task'),
        ),
      ),
    );
  }
}
