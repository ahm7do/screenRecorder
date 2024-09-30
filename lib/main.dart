import 'package:flutter/material.dart';
import 'package:record/record.dart';

import 'package:screen_protector/screen_protector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await ScreenProtector.protectDataLeakageOn();
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final record = AudioRecorder();

  @override
  void initState() {
    Future.microtask(() async {
      if (await record.hasPermission()) {
        await record
            .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
      }
      // final isRecording = await ScreenProtector.isRecording();
      // if (isRecording) {
      //   await startRecording();
      // } else {
      //   await stopRecording();
      // }
    });

    super.initState();
  }

  Future<void> startRecording() async {
    await record.start(const RecordConfig(), path: "");
  }

  Future<void> stopRecording() async {
    await record.cancel();
  }

  @override
  void dispose() {
    record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'YnTEXW7RaYY',
    flags: const YoutubePlayerFlags(autoPlay: true),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }
}
