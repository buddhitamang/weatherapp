class Weather {
  final String? cityName;
  final double temparature;
  final String condition;

  Weather(
      {required this.cityName, required this.temparature, required this.condition});

  factory Weather.fromJson(Map<String, dynamic>json){
    return Weather(
        cityName: json['name'],
        temparature: json['main']['temp'].toDouble(),
        condition: json['weather'][0]['main'],);
  }
}