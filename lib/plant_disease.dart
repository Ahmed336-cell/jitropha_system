import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PlantDisease extends StatefulWidget {
  @override
  _PlantDisease createState() => _PlantDisease();
}

class _PlantDisease extends State<PlantDisease> {
  File? _image;
  String _imageUrl = "";
  bool prediction = false; // Declare prediction as a class-level variable

  Future<void> _uploadImage() async {
    if (_image == null) {
      print('No image selected');
      return;
    }

    final uri = Uri.parse('https://sic.server.ahmedsaed.me/api/models/health');
    final request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final parsedResponse = jsonDecode(responseData);

        if (parsedResponse.containsKey('prediction')) {
          setState(() {
            prediction = parsedResponse['prediction'];
            _imageUrl = ''; // Clear any existing image URL
          });

          print('Prediction result: $prediction');

          // Handle the prediction result as needed
          // For example, update state or UI based on the prediction
        } else {
          print('Error: Unexpected response format');
        }
      } else {
        print('Error uploading image: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Diseases checker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!, height: 300, width: 300)
                : Text('No image selected'),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _image != null ? _uploadImage : null,
              child: Text('Upload Image'),
            ),
            _imageUrl.isNotEmpty
                ? Image.network(_imageUrl, height: 150, width: 150)
                : SizedBox.shrink(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  prediction ? Icons.check_circle : Icons.cancel,
                  color: prediction ? Colors.green : Colors.red,
                  size: 100.0,
                ),
                SizedBox(height: 20.0),
                Text(
                  prediction ? 'Plant is in good Health' : 'Plant Has a bad health',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: prediction ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PlantDisease(),
  ));
}
