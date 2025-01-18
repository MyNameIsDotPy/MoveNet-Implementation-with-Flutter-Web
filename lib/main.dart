import 'dart:async';

import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/js.dart' as js;
import 'dart:ui_web' as ui;

import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFA800)),
        useMaterial3: true,
      ),
      home:
        const MyHomePage(
          title: 'Flutter Web - Tensorflow.js implementation'
        ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String?> initCam() async {
    final videoElement = html.VideoElement()
      ..id = 'video-draw'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'cover'
      //..style.display = 'none'
      ..autoplay = true
      ..muted = true;

    final canvasElement = html.CanvasElement()
      ..id = 'canvas-draw'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'cover';

    final mediaStream = await html.window.navigator.mediaDevices?.getUserMedia({
      'video': {
        'width': {'ideal': 1920},
        'height': {'ideal': 1920}
      }
    });

    if (mediaStream != null) {
      videoElement.srcObject = mediaStream;
      final viewType = Uuid().v1();
      ui.platformViewRegistry
          .registerViewFactory('${viewType}video', (viewId) => videoElement);

      ui.platformViewRegistry
          .registerViewFactory('${viewType}output', (viewId) => canvasElement);

      return viewType;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initCam(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                HtmlElementView(
                  viewType: '${snapshot.data}video',
                ),
                HtmlElementView(
                  viewType: '${snapshot.data}output',
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Text('Start'),
            onPressed: () {
              js.context.callMethod('detectPose');
            }
          ),
        );
      },
    );
  }
}
