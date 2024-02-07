import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jitropha_system/menu_page.dart';
import 'model/dummy_data.dart';

void main() {
  runApp(MyApp());
}

class FarmFactory {
  final String name;
  final String location;
  final String type;
  final double percent;

  FarmFactory({required this.name, required this.location, required this.type , required this.percent});
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<FarmFactory> farmsFactories = [
    FarmFactory(name: 'Sahel Farm', location: ' North Sahel', type: "Farm" , percent: 70.0),
    FarmFactory(name: 'Gharbia Desert', location: ' Gharbia Desert', type: "Farm" , percent: 68.0),
    FarmFactory(name: 'Sahel Factory', location: ' North Sahel', type: "Factory" , percent: 85.4),
    FarmFactory(name: 'Gharbia Desert Factory', location: ' Gharbia Desert', type: "Factory" , percent: 75.4),
    FarmFactory(name: "Red Sea Farm", location: " Red Sea", type: "Farm" , percent: 40.0),
    FarmFactory(name: "Red Sea Factory", location: " Red Sea", type: "Factory",percent: 78.78),
  ];

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          title: Text(' Home Page'),
          backgroundColor: Colors.lightGreen,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Alerts Section
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              'Alerts',
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8,),
                            Positioned(

                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: Text(
                                  "2",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (isExpanded)
                        Column(
                          children: [
                            SizedBox(height: 10.0),
                            // Display alerts here (e.g., using ListTile)
                            ListTile(
                              title: Text('Urgent Alert'),
                              subtitle: Text('Seeds will Dead in Sahel'),
                              leading: Icon(Icons.warning, color: Colors.red),
                              onTap: () {
                                // Handle alert tap
                              },
                            ),
                            ListTile(
                              title: Text('Critical Alert'),
                              subtitle: Text('There is a problem in sensors in Gharbia Desert'),
                              leading: Icon(Icons.error, color: Colors.red),
                              onTap: () {
                                // Handle alert tap
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              // Farms/Factories List Section
              Text(
                'Farm/Factories List',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: ListView.builder(
                  itemCount: farmsFactories.length,
                  itemBuilder: (context, index) {
                    final farmFactory = farmsFactories[index];

                    return Card(
                      elevation: 5.0,
                      child: ListTile(
                        leading: farmFactory.type == "Factory"
                            ? Image.asset("images/factory.png")
                            : Image.asset("images/plant.png"),
                        title: Text(farmFactory.name),
                        subtitle: Row(
                          children: [
                            Icon(Icons.location_on),
                            Text(farmFactory.location),
                          ],
                        ),
                        onTap: () {
                          // Handle farm/factory tap
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
                        },

                        trailing: Container(
                          width: 60,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(16))
                            ),
                            child: Center(child: Text("${farmFactory.percent}%", style: TextStyle(color: Colors.white),))),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              // Bar Chart

            ],
          ),
        ),
      ),
    );
  }


}
