import 'package:callrecorder/main.dart';
import 'package:callrecorder/recorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:callrecorder/methodchannel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const number = '+918618764563';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                FlutterPhoneDirectCaller.callNumber(number);
                //launchUrl('tel://$number' as Uri);
              },
              child: const Text("Call"),
            ),
            const SizedBox(width: 20), // Add spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Handle the second button press
              },
              child: const Text("Voice Recording"),
            ),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recording"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          const Text("Align Button to Bottom"),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: buildStart(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStart() {
    final isRecording = false; // Replace with your recording logic
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? "Stop" : "Start";
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(175, 50),
        primary: Colors.red,
        onPrimary: Colors.black,
      ),
      icon: const Icon(Icons.mic),
      label: const Text(
        'Start',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => recorder()),
        );
        // Handle button press
      },
    );
  }

  recorder() {}
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}
