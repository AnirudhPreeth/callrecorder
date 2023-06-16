import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter/services.dart';

const number = '+918618764563';

const MethodChannel _callRecorderChannel = MethodChannel('call_recorder_channel');

class CallRecorder {
  static Future<void> startRecording() async {
    try {
      await _callRecorderChannel.invokeMethod('startCallRecording');
      print('Call recording started');
    } catch (e) {
      print('Failed to start call recording: $e');
    }
  }

  static Future<void> stopRecording() async {
    try {
      await _callRecorderChannel.invokeMethod('stopCallRecording');
      print('Call recording stopped');
    } catch (e) {
      print('Failed to stop call recording: $e');
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            FlutterPhoneDirectCaller.callNumber(number);
            CallRecorder.startRecording();
          },
          child: const Text("Call & Start Recording"),
        ),
      ),
    );
  }
}
