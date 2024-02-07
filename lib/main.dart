import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jitropha_system/control_page.dart';
import 'package:jitropha_system/home_page.dart';
import 'package:jitropha_system/image_detect.dart';
import 'package:jitropha_system/menu_page.dart';
import 'package:jitropha_system/plant_disease.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
  ));
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryColor: Colors.lightGreen
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    MyApp(),
    ImageUploadPage(),
    PlantDisease(),
    ControlPage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [

          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.black,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.panorama_photosphere_select,color: Colors.black,),
            label: 'Detect seeds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image,color: Colors.black,),
            label: 'Plant Diseases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.control_camera,color: Colors.black,),
            label: 'Control',
          ),

        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
