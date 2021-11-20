

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:skin/modelScreen.dart';
import 'package:flutter/rendering.dart';
import 'package:skin/main.dart';

// ignore: unused_import
import 'screens/modelScreen.dart';

class UploadPhoto extends StatelessWidget {

  late final List<CameraDescription> cameras;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('PHOTO UPLOADER'),
          elevation: 0,
          brightness: Brightness.light,
        backgroundColor: Colors.lightBlue,
        ),
        backgroundColor: Colors.white12,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  
                  color: Colors.redAccent,
                  image: DecorationImage(
                    
                    image: AssetImage('assets/SIGNIN.png'),
                    fit: BoxFit.cover
                  )
                ),
                child: Text('Intelli Team Skin Care'),
              ),
              ListTile(
                title: const Text('Docs'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TfliteHome()));
                },
              ),
              ListTile(
                title: const Text('View Profile'),
                onTap: (){},
              ),
              ListTile(
                title: const Text('Settings'),
                onTap: (){},
              ),
              ListTile(
                title: const Text('Contacts '),
                onTap: (){},
              ),
              ListTile(
                title: const Text('About'),
                onTap: (){},
              ),
              ListTile(
                title: const Text('LogOut'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
              )
            ],
          ),
        ),
        
        body: Stack(
          children: <Widget>[   
             Container(
                height: MediaQuery.of(context).size.height / 2.5,
               decoration: BoxDecoration(
                 
               shape: BoxShape.rectangle,
                 // alignment: Alignment.topCenter,
                  image: DecorationImage(
                    scale: 0.50,
                    alignment: Alignment.topCenter, 
                    image:AssetImage ("assets/image.png",),
                    
                   // height: 300,
                  ),
                  )
                ),      
            Align(
              alignment: Alignment.center,
              child: 
              ElevatedButton(onPressed: (){ 
                
              Navigator.push(context, MaterialPageRoute(builder: (context) => SkinModel()));
              },
               child: Text('UPLOAD PHOTO')),
              )
          ],
        ),
      ),
    );
  
  }
}

/*
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(title: Text('Upload Image')),
      body: Column(  
        children: <Widget>[
          TextButton(  
            child: Text('Upload Image'),
            onPressed: () => uploadImage(),
          )
        ],
      ),
    );
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;


    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = (await _picker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _storage.ref()
        .child('folderName/imageName')
        .putFile(file);
        

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }

    } else {
      print('Grant Permissions and try again');
    }

    

    
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('imageUrl', imageUrl));
  }

}
*/

/*
import 'dart:async';


import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: PhotoScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}


class PhotoScreen extends StatefulWidget {
  const PhotoScreen({ Key? key, required this.camera,}) : super(key: key);

  final CameraDescription camera;

  @override
  PhotoScreenState createState() => PhotoScreenState();
}

class PhotoScreenState extends State<PhotoScreen> {

  late CameraController _controller;

  @override 
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
  }

  @override 
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return 
  FutureBuilder<void>(
  
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      // If the Future is complete, display the preview.
      return CameraPreview(_controller);
    } else {
      // Otherwise, display a loading indicator.
      return const Center(child: CircularProgressIndicator());
    }
  },
);
  }
  
}*/



