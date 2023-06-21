import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import android.os.Bundle;
import android.media.MediaRecorder;
import android.os.Environment;
import java.io.File;
import java.io.IOException;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.telephony.TelephonyManager;

public class CallRecorder extends FlutterActivity {
    private static final String CALL_RECORDER_CHANNEL = "call_recorder_channel";
    private static final String ACTION_OUTGOING_CALL_STARTED = "android.intent.action.NEW_OUTGOING_CALL";
    private static final String ACTION_INCOMING_CALL_STARTED = "android.intent.action.PHONE_STATE";
    private static final String EXTRA_PHONE_NUMBER = "android.intent.extra.PHONE_NUMBER";
    private static final String STATE_IDLE = "IDLE";
    private static final String STATE_OFFHOOK = "OFFHOOK";
    private static final String STATE_RINGING = "RINGING";
    private MediaRecorder recorder;
    private boolean isRecording = false;

    private BroadcastReceiver callReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();

            if (action.equals(ACTION_OUTGOING_CALL_STARTED)) {
                String phoneNumber = intent.getStringExtra(EXTRA_PHONE_NUMBER);
                startCallRecording();
            } else if (action.equals(ACTION_INCOMING_CALL_STARTED)) {
                String state = intent.getStringExtra(TelephonyManager.EXTRA_STATE);
                if (state.equals(TelephonyManager.EXTRA_STATE_RINGING)) {
                    // Incoming call started
                    startCallRecording();
                } else if (state.equals(TelephonyManager.EXTRA_STATE_OFFHOOK)) {
                    // Call answered
                    startCallRecording();
                }
            }
        }
    };

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

    @Override
    protected void onResume() {
        super.onResume();
        registerReceiver(callReceiver, new IntentFilter(ACTION_OUTGOING_CALL_STARTED));
        registerReceiver(callReceiver, new IntentFilter(ACTION_INCOMING_CALL_STARTED));
    }

    @Override
    protected void onPause() {
        super.onPause();
        unregisterReceiver(callReceiver);
    }

    private void startCallRecording() {
        if (!isRecording) {
            recorder = new MediaRecorder();

            // Set the audio source to VOICE_CALL if available, otherwise use MIC
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N && MediaRecorder.AudioSource.VOICE_CALL != MediaRecorder.AudioSource.DEFAULT) {
                recorder.setAudioSource(MediaRecorder.AudioSource.VOICE_CALL);
            } else {
                recorder.setAudioSource(MediaRecorder.AudioSource.MIC);
            }

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
            isRecording = true;
        }
    }

    private void stopCallRecording() {
        if (isRecording) {
            // Stop recording
            recorder.stop();
            isRecording = false;

            // Release resources
            recorder.release();
            recorder = null;
        }
    }
}
