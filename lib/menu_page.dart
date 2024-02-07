import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jitropha_system/data_details_page.dart';
import 'model/dummy_data.dart';

class MenuPage extends StatelessWidget {
   MenuPage({Key? key});
  final List<double> timePoints =
      List.generate(10, (index) => index.toDouble());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: EdgeInsets.zero, children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              title: Text(
                'Hello Ahad!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
              subtitle: Text(
                'Good Morning',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white54,
                    ),
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
      Container(
        color: Colors.lightGreen,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(200),
            ),
          ),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 40,
            mainAxisSpacing: 30,
            children: [
              clickableItemDashboard(
                context,
                'Soil Moisture',
                Image.asset("images/plant.png"),
                Colors.deepOrange,
              ),
              clickableItemDashboard(
                context,
                'Temperature',
                Image.asset("images/temperature.png"),
                Colors.green,
              ),
              clickableItemDashboard(
                context,
                'Light',
                Image.asset("images/lamp.png"),
                Colors.purple,
              ),
              clickableItemDashboard(
                context,
                'CO2',
                Image.asset("images/co2.png"),
                Colors.brown,
              ),
              clickableItemDashboard(
                context,
                'PH',
                Image.asset("images/ph.png"),
                Colors.indigo,
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 20),
      Divider(height: 20,),

           Container(
             height: 50,
             child: ListView.builder(
               scrollDirection: Axis.horizontal,
               itemCount: 6,
               itemBuilder: (BuildContext context, int index) {
               return  _buildLegend();

               },



              ),
           ),

      AspectRatio(
        aspectRatio: 1.3,
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              leftTitles: SideTitles(showTitles: true, reservedSize: 40),
              bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (value) {
                  // Assuming time points are integers, replace with actual time labels
                  return '${value.toInt()}h';
                },
              ),
            ),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              _buildLineChartBar(DummyData.plantHealthMetricsData, Colors.blue),
              _buildLineChartBar(DummyData.temperatureData, Colors.red),
              _buildLineChartBar(DummyData.humidityData, Colors.green),
              _buildLineChartBar(DummyData.cropProgressData, Colors.orange),
              _buildLineChartBar(DummyData.equipmentStatusData, Colors.purple),
              _buildLineChartBar(
                  DummyData.resourceUtilizationData, Colors.teal),
            ],
          ),
        ),

      ),
    ]

        )
    );
  }

  Widget clickableItemDashboard(
      BuildContext context, String title, Image iconData, Color background) {
    return GestureDetector(
      onTap: () {
        // Handle item click here, you can navigate to a new screen or perform any other action.
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DataDetailsPage(title,dataCount: 50)));
      },
      child: itemDashboard(title, iconData, background),
    );
  }

  Widget itemDashboard(String title, Image iconData, Color background) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 70,
              height: 70,
              child: iconData,
            ),
          ),
          const SizedBox(height: 8),
          Text(title.toUpperCase())
        ],
      ),
    );
  }

  LineChartBarData _buildLineChartBar(List<double> data, Color color) {
    return LineChartBarData(
      spots: List.generate(
          data.length, (index) => FlSpot(timePoints[index], data[index])
      ),
      isCurved: true,
      colors: [color],
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }
   Widget _buildLegend() {
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           _buildLegendItem(Colors.blue, 'Plant Health'),
           _buildLegendItem(Colors.red, 'Temperature'),
           _buildLegendItem(Colors.green, 'Humidity'),
           _buildLegendItem(Colors.orange, 'Crop Progress'),
           _buildLegendItem(Colors.purple, 'Equipment Status'),
           _buildLegendItem(Colors.teal, 'Resource Utilization'),
         ],
       ),
     );
   }

   Widget _buildLegendItem(Color color, String title) {
     return Row(
       children: [
         Container(
           width: 20,
           height: 20,
           color: color,
         ),
         SizedBox(width: 8),
         Text(title),
         SizedBox(width: 16),
       ],
     );
   }
}
