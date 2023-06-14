import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import android.os.Bundle;
import android.media.MediaRecorder;
import android.os.Environment;
import java.io.File;
import java.io.IOException;
import com.jetbrains.CallRecorderMethodCallHandler

public class MainActivity extends FlutterActivity {
    private static final String CALL_RECORDER_CHANNEL = "call_recorder_channel";
    private MediaRecorder recorder;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // ...

        MethodChannel methodChannel = new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CALL_RECORDER_CHANNEL);
        methodChannel.setMethodCallHandler((call, result) -> {
            // Handle method invocations here
            if (call.method.equals("startCallRecording")) {
                startCallRecording();
                result.success(null); // Return a success result if needed
            } else if (call.method.equals("stopCallRecording")) {
                stopCallRecording();
                result.success(null); // Return a success result if needed
            } else {
                result.notImplemented(); // Handle unknown method invocations
            }
        });
    }

    private void startCallRecording() {
        recorder = new MediaRecorder();

        // Set the audio source
        recorder.setAudioSource(MediaRecorder.AudioSource.VOICE_CALL);

        // Set the output format
        recorder.setOutputFormat(MediaRecorder.OutputFormat.MPEG_4);

        // Set the output file path
        File outputDir = new File(Environment.getExternalStorageDirectory(), "Call Recording");
        if (!outputDir.exists()) {
            outputDir.mkdirs();
        }
        String outputPath = outputDir.getAbsolutePath() + File.separator + "call_recording.mp4";
        recorder.setOutputFile(outputPath);

        // Set the audio encoder
        recorder.setAudioEncoder(MediaRecorder.AudioEncoder.AAC);

        // Prepare the MediaRecorder
        try {
            recorder.prepare();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Start recording
        recorder.start();
    }

    private void stopCallRecording() {
        if (recorder != null) {
            // Stop recording
            recorder.stop();

            // Release resources
            recorder.release();
            recorder = null;
        }
    }
}
