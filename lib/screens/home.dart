import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'camerascreen.dart';

class MyHomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  MyHomePage(this.cameras, Set set, {camera});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String predOne = '';

  @override
  void initState() {
    super.initState();
    loadTfliteModel();
  }

  loadTfliteModel() async {
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt"))!;
    print(res);
  }

  setRecognitions(outputs) {
    setState(() {
      predOne = outputs[null]['label'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Diagnosis Screen",
        ),
        backgroundColor: Colors.teal,
      ),
      body:Flexible(
        child: ListView(
        children: [
          Camera(widget.cameras, setRecognitions),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 20.0)],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "$predOne",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.tealAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

