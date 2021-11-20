
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:skin/login.dart';

import 'package:skin/signup.dart';
import 'package:tflite/tflite.dart';

void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0xFFFF00FF),
    ),
    theme: ThemeData.light(),
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

const String ssd = "SSD MobileNet";
const String yolo = "Tiny YOLOv2";
const String intelli = "intelli_model";
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // we will give media query height
          // double.infinity make it big as my parent allows
          // while MediaQuery make it big as per the screen

          width: double.infinity,

          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            // even space distribution
            verticalDirection: VerticalDirection.down,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Welcome to Skin Diagnosis App",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "The Dignosis is done by upload the picture of affected skin, SIGNIN/ SIGNUP for free ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle, 
                  
                    image: DecorationImage(
                    
                        image: AssetImage("assets/SIGNIN.png"))),
              ),
              Column(
                children: <Widget>[
                  // the login button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    // defining the shape
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  // creating the signup button
                  SizedBox(height: 20),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    color: Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TfliteHome extends StatefulWidget {
  @override
  _TfliteHomeState createState() => _TfliteHomeState();
}

class _TfliteHomeState extends State<TfliteHome> {


var isInialized = true;
String _model = ssd;
File _image = File('assets/allegy.png');
String predOne = ''; 
String _skinModel = intelli;

// ignore: unused_field
double _imageWidth = 0.0;
// ignore: unused_field
double _imageHeight = 0.0;
bool _busy = false;

// ignore: unused_field
List _recognitions = [];
 
  @override 
  void initState(){
    super.initState();
    _busy = true;

    loadModel().then((val){
      setState(() {
        _busy = false;
      });
    });

  }

  loadModel() async {
    Tflite.close();
    try {
      String res;
      res = (await Tflite.loadModel(
        model: "assets/intelli_model.tflite",
        labels: "assets/intelli_labels.txt",
        ))!;
        print(res);
    } on PlatformException{
      print("Failed to load the model");
    }
  }

  setRecognitions(image){
    setState(() {
      predOne = image[0]['label'];
    });
  }

  Future getImage(int type) async{
  File image = (await ImagePicker().pickImage(source: type == 1 ?
  ImageSource.camera:
  ImageSource.gallery,
       imageQuality: 50
   )) as File;
   isInialized = true;
   //

   setState(() {
     _busy = true;
     image = File(image.path);
   });
   setRecognitions(image);
  }
  

  
  setRecognition(File image) async {
    // ignore: unnecessary_null_comparison
    if (_model == null) {
      return;
    // ignore: unnecessary_null_comparison
    } else if(_skinModel != null) {

      return setRecognition(image);
    }


    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
          });
        })));
    setState(() {
      _image = image;
      _busy = false;
    });
  }

   
 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      // ignore: unrelated_type_equality_checks
      child: _image == [] ? Text('no image Selected') : Image.file(_image),
    ));

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Skin Detector'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.image),
        tooltip: "Pick Image from Gallery",
        onPressed: () async { 
        final tmpFile = await getImage(2);
        setState(() {
          _image = tmpFile;
        });
        }),
      body: Stack(
        children: stackChildren,
      ),
    );
  }
}

 // ignore: unused_element
 List _outputs = [];
 // File _image = asse;
