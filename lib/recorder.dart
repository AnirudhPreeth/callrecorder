import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';


const pathToSaveAudio = 'audio_example.aac';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool isRecorderInitialised = false;
  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if(status!=PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone Permission');
    }
    await _audioRecorder!.openRecorder();
    isRecorderInitialised = true;
  }

  void dispose() {
    if(!isRecorderInitialised) return;
    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    isRecorderInitialised = false;
  }

  Future _record() async {
    if(!isRecorderInitialised) return;
    await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  Future _stop() async {
    if(!isRecorderInitialised) return;
    await _audioRecorder!.stopRecorder();
  }

  Future toggleRecording() async{
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }

}