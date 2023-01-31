import 'package:flutter/material.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State createState() => _AppState();
}

class _AppState extends State<App> {
  final messages = <String>[];

  _AppState() {
    WatchConnectivity().messageStream.listen(_handleMessage);
  }

  void _handleMessage(Map<String, dynamic> message) {
    setState(() => messages.add(message['message']));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) => Text(messages[index]),
        ),
      ),
    );
  }
}
