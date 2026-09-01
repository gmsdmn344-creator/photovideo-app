import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhotoVideo Maker',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<XFile> images = [];
  String? audioPath;
  bool isRecording = false;
  final recorder = AudioRecorder();

  pickImages() async {
    final picked = await ImagePicker().pickMultiImage();
    setState(() => images = picked);
  }

  pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if(result != null) setState(() => audioPath = result.files.single.path);
  }

  startRecording() async {
    if(await recorder.hasPermission()){
      await recorder.start();
      setState(() => isRecording = true);
    }
  }

  stopRecording() async {
    String? path = await recorder.stop();
    setState(() { audioPath = path; isRecording = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo to Video")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: pickImages, child: Text("1. Photos Select Karo")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: pickAudio, child: Text("2. Music Uthao")),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: isRecording ? stopRecording : startRecording, 
              child: Text(isRecording ? "Recording Rokho" : "3. Mic se Record")
            ),
          ],
        ),
      ),
    );
  }
}