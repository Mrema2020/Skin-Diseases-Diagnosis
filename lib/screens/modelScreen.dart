// ignore: avoid_web_libraries_in_flutter
// ignore: unused_import
// ignore: avoid_web_libraries_in_flutter
// ignore: unused_import
// ignore: avoid_web_libraries_in_flutter
import'dart:html'as html;
import 'dart:io';
//import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:tflite/tflite.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:image_picker_web/image_picker_web.dart';

html.File _cloudFile = {} as html.File;
var _fileBytes = [];
var pickedImage;


class SkinModel extends StatefulWidget {

  
  @override
  _SkinModelState createState() => _SkinModelState();
}

class _SkinModelState extends State<SkinModel> {

  List _outputs = [];
  File _image = File('');

  Future loadImageModel() async {
  print('ELVIS');
    Tflite.close();
    String? result;
    result = (await Tflite.loadModel(
      model: "assets/intelli_model.tflite",
      labels: "assets/intelli_labels.txt",
    ));
    print(result);
  }

Future predictImage(image) async {
  _outputs = [];
  print("Recognition start $image");
    try { 
       final List? result = await Tflite.detectObjectOnImage(
      path: image.path,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print("Recognition done");
    setState(() {
      if (image != null){
        _image = File(image.path);
        _outputs = result!;
      } else{
        print('No image selected.');
      }
    });
    } catch (e) {
     return ;
    }
  }
  
Future <void> pickImage() async {
  
    Object? bytesFromPicker =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    if (bytesFromPicker != null) {
      debugPrint(bytesFromPicker.toString());
    }
     Object? imageFile =
        await ImagePickerWeb.getImage(outputType: ImageType.file);

    if (imageFile != null) {
      debugPrint(imageFile.toString());
    }

  //Object? fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.widget);
  /* Object? bytesFromPicker =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);
  if(bytesFromPicker != null){

    debugPrint(bytesFromPicker.toString());
  }*/
    /*final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera, 
    imageQuality: 80,
    maxHeight: 300);
    kIsWeb
    ? Image.network('https://i.imgur.com/sUFH1Aq.png')
    : Image.file(_image);
    predictImage(image);
    setState(() {
      if (image != null) {
      _image = File(image.path);
    }else {
      print('No image selected.');
    }
    });*/
  }

  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disease Diagnosis")
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              child: Icon(Icons.person,
              size: 200,
              semanticLabel: "Image-Site",
              color: Colors.greenAccent,
              ),
              height: 200,
              width: 250,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2, 2),
                    spreadRadius: 5,
                    blurRadius: 5,
                  ),
                ],
              ),

             
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              hoverColor:Colors.greenAccent,
              color: Colors.blueAccent,
             // autofocus:true,
              onPressed: (){
                pickImage();
              },
              child: Icon(Icons.image
            ),),
            SizedBox(height: 20),
            SingleChildScrollView(
              child: Column(
                // ignore: unnecessary_null_comparison
                children: _outputs != null
                ? _outputs.map((result){
                  return Card(
                    elevation: 0.0,
                    color: Colors.lightBlue,
                    child: Container(
                      width: 300,
                      margin: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "${result["label"]} :${(result["confidence"] * 100).toStringAsFixed(1)}%",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                }).toList()
                : [],
              ),
            ),
          ]
        ),
      ),
    );
  }
}