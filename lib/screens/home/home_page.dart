import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter/services.dart';
import 'package:callrecorder/android/call_recorder_channel.dart';

const number = '+918618764563';

void startCallRecording() async {
  try {
    const platform = MethodChannel('call_recorder_channel');
    await platform.invokeMethod('startCallRecording');
    print('Call recording started');
  } catch (e) {
    print('Failed to start call recording: $e');
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
            startCallRecording();
          },
          child: const Text("Call & Start Recording"),
        ),
      ),
    );
  }
}
