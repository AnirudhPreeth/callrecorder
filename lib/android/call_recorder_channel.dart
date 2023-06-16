import 'package:flutter/services.dart';

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
