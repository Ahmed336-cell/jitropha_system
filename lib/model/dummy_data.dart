class DummyData {
  // Plant Health Metrics
  static List<double> plantHealthMetricsData = [75, 80, 85, 78, 90, 92, 88, 95, 80, 85];

  // Weather Data
  static List<double> temperatureData = [25, 26, 27, 28, 29, 30, 31, 32, 33, 34];
  static List<double> humidityData = [60, 62, 65, 70, 68, 75, 80, 78, 72, 70];

  // Crop Progress
  static List<double> cropProgressData = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

  // Equipment Status
  static List<double> equipmentStatusData = [90, 85, 88, 92, 95, 80, 78, 85, 90, 88];

  // Resource Utilization
  static List<double> resourceUtilizationData = [70, 75, 80, 85, 88, 90, 92, 95, 80, 78];

  static List<String> timeData = ['8 AM', '9 AM', '10 AM', '11 AM', '12 PM', '1 PM', '2 PM', '3 PM', '4 PM', '5 PM'];
  final List<double> timePoints =
  List.generate(10, (index) => index.toDouble());
}
