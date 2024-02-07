import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double waterLevel = 0.0;
  double phLevel = 0;
  double tempLevel = 0;
  List<int> predictionValues = [1, 1, 1];

  Future<void> _sendDataToApi() async {
    final uri = Uri.parse('https://sic.server.ahmedsaed.me/api/models/recommendation');
    final Map<String, dynamic> requestData = {
      'temperature': tempLevel,
      'ph': phLevel,
      'water_level': waterLevel / 100.0,
    };

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData.containsKey('prediction')) {
          setState(() {
            predictionValues = List<int>.from(responseData['prediction']);
          });
        } else {
          print('Error: Unexpected response format');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  IconData getIcon(int value) {
    if (value == -1) {
      return Icons.remove_circle;
    } else if (value == 1) {
      return Icons.add_circle;
    } else {
      return Icons.radio_button_unchecked;
    }
  }

  String getMessage(int value) {
    if (value == -1) {
      return 'Decrease value';
    } else if (value == 1) {
      return 'Increase value';
    } else {
      return 'Keep value';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Range Control'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Water Level
            Column(
              children: [
                Text(
                  'Water Level: ${waterLevel.toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  getMessage(predictionValues[0]),
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20.0),
                FlutterSlider(
                  values: [waterLevel],
                  max: 100,
                  min: 0,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    setState(() {
                      waterLevel = lowerValue;
                    });
                  },
                  handler: FlutterSliderHandler(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.lightGreen,
                    ),
                    child: Icon(
                      getIcon(predictionValues[0]),
                      color: Colors.white,
                    ),
                  ),
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBar: BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                  tooltip: FlutterSliderTooltip(
                    format: (String value) {
                      return value;
                    },
                  ),
                ),
               // SizedBox(height: 5.0),

              ],
            ),

            Divider(height: 10,thickness:6,),
            // pH Level
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'pH Level: ${phLevel.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0),

                  Text(
                    getMessage(predictionValues[1]),
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  FlutterSlider(
                    values: [phLevel],
                    max: 14,
                    min: 0,
                    step: FlutterSliderStep(step: 0.1),
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      setState(() {
                        phLevel = lowerValue;
                      });
                    },
                    handler: FlutterSliderHandler(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.lightGreen,
                      ),
                      child: Icon(
                        getIcon(predictionValues[1]),
                        color: Colors.white,
                      ),
                    ),
                    trackBar: FlutterSliderTrackBar(
                      activeTrackBar: BoxDecoration(
                        color: Colors.green,
                      ),
                    ),
                    tooltip: FlutterSliderTooltip(
                      format: (String value) {
                        return value;
                      },
                    ),
                  ),
                 // SizedBox(height: 5.0),

                ],
              ),
            ),
            Divider(height: 10,thickness:6,),

            // Temperature Level
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Temperature Level: ${tempLevel.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0),

                  Text(
                    getMessage(predictionValues[2]),
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  FlutterSlider(
                    values: [tempLevel],
                    max: 60,
                    min: 0,
                    step: FlutterSliderStep(step: 0.1),
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      setState(() {
                        tempLevel = lowerValue;
                      });
                    },
                    handler: FlutterSliderHandler(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.lightGreen,
                      ),
                      child: Icon(
                        getIcon(predictionValues[2]),
                        color: Colors.white,
                      ),
                    ),
                    trackBar: FlutterSliderTrackBar(
                      activeTrackBar: BoxDecoration(
                        color: Colors.green,
                      ),
                    ),
                    tooltip: FlutterSliderTooltip(
                      format: (String value) {
                        return value;
                      },
                    ),
                  ),
                  SizedBox(height: 5.0),

                ],
              ),
            ),

            // Button to send data to API
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _sendDataToApi,
              child: Text('Check Ranges'),
            ),
          ],
        ),
      ),
    );
  }
}
