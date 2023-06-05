import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const platform = MethodChannel('call_recorder_channel');

void startCallRecording() async {
  try {
    await platform.invokeMethod('startCallRecording');
    print('Call recording started');
  } catch (e) {
    print('Failed to start call recording: $e');
  }
}

void stopCallRecording() async {
  try {
    await platform.invokeMethod('stopCallRecording');
    print('Call recording stopped');
  } catch (e) {
    print('Failed to stop call recording: $e');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Call Recorder'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  startCallRecording();
                },
                child: Text("Start Recording"),
              ),
              ElevatedButton(
                onPressed: () {
                  stopCallRecording();
                },
                child: Text("Stop Recording"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
