import android.media.MediaRecorder;
import android.os.Environment;
import java.io.File;
import java.io.IOException;

public class CallRecorder {
    private MediaRecorder recorder;

    public void startRecording() {
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

    public void stopRecording() {
        if (recorder != null) {
            // Stop recording
            recorder.stop();

            // Release resources
            recorder.release();
            recorder = null;
        }
    }
}
