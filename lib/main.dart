import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _channel = const MethodChannel('com.theamorn.widgetKit');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                child: const Text("Start LiveActivity"),
                onPressed: () async {
                  try {
                    await _channel.invokeMethod('startLiveActivity');
                  } on PlatformException catch (e) {
                    debugPrint("==== PlatformException '${e.message}' ====");
                  }
                }),
            TextButton(
                child: const Text("Update LiveActivity"),
                onPressed: () async {
                  try {
                    await _channel.invokeMethod('updateLiveActivity');
                  } on PlatformException catch (e) {
                    debugPrint("==== PlatformException '${e.message}' ====");
                  }
                }),
            TextButton(
                child: const Text("Stop LiveActivity"),
                onPressed: () async {
                  try {
                    await _channel.invokeMethod('stopLiveActivity');
                  } on PlatformException catch (e) {
                    debugPrint("==== PlatformException '${e.message}' ====");
                  }
                }),
            TextButton(
                child: const Text("Show All"),
                onPressed: () async {
                  try {
                    await _channel.invokeMethod('showAll');
                  } on PlatformException catch (e) {
                    debugPrint("==== PlatformException '${e.message}' ====");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
