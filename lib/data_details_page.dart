import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataDetailsPage extends StatefulWidget {
  final String title;
  final int dataCount; // Number of data points to fetch

  DataDetailsPage(this.title, {required this.dataCount});

  @override
  _DataDetailsPageState createState() => _DataDetailsPageState();
}

class _DataDetailsPageState extends State<DataDetailsPage> {
  List<FlSpot> dataPoints = [];
  List<String> timestamps = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String data;
    if (widget.title == "Light") {
      data = "light_intensity";
    } else if (widget.title == "Temperature") {
      data = "temperature";
    } else if (widget.title == "CO2") {
      data = "co2_level";
    } else if (widget.title == "PH") {
      data = "water_ph_value";
    } else {
      data = "temperature";
    }

    final apiUrl =
        'https://sic.server.ahmedsaed.me/api/data/${data}/${widget.dataCount}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        setState(() {
          dataPoints = List.generate(
            widget.dataCount,
                (index) {
              final temperature = responseData['$index'] as double?;
              return FlSpot(index.toDouble(), temperature ?? 0.0);
            },
          );
        });
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 16),
        child: Container(
          width: double.infinity,
          height: 500,
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                leftTitles: SideTitles(showTitles: true),
                rightTitles: SideTitles(showTitles: false),
                topTitles: SideTitles(
                  showTitles: false,
                  getTitles: (value) {
                    if (value.toInt() >= 0 &&
                        value.toInt() < timestamps.length) {
                      return timestamps[value.toInt()];
                    }
                    return '';
                  },
                ),
                bottomTitles: SideTitles(
                  showTitles: false,
                  getTitles: (value) {
                    if (value.toInt() >= 0 &&
                        value.toInt() < timestamps.length) {
                      return timestamps[value.toInt()];
                    }
                    return '';
                  },
                ),
              ),
              gridData: FlGridData(show: true),
              borderData: FlBorderData(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                  left: BorderSide(color: Colors.black),

                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: dataPoints,
                  isCurved: false,
                  colors: [Colors.red],
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: true),
                ),
              ],
            ),
            swapAnimationDuration: Duration(milliseconds: 500), // Animation duration
          ),
        ),

      ),
    );
  }
}
