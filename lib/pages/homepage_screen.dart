import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/const.dart';
import 'package:weatherapp/services/weather_services.dart';
import 'package:weatherapp/model/weather.dart' as MyAppWeather;
import 'package:weatherapp/const.dart';
import 'help_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _weatherService = WeatherServices(apiKey: OPENWEATHER_API_KEY);
  MyAppWeather.Weather? _weather;
  TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchSavedCityWeather();
  }

  void _fetchSavedCityWeather() async {
    String? savedCity = await getSavedCity();
    if (savedCity != null) {
      _fetchWeather(savedCity);
    } else {
      _fetchWeather('');
    }
  }


  Future<String?> getSavedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('savedCity');
  }

  void saveCity(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedCity', cityName);
  }

  _fetchWeather(String cityName) async {
    try {
      if (cityName.isEmpty) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        final weather = await _weatherService.getWeatherByLocation(
          position.latitude,
          position.longitude,
        );
        setState(() {
          _weather = weather;
        });
      } else {
        final weather = await _weatherService.getWeather(cityName);
        setState(() {
          _weather = weather;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? condition) {
    if (condition == null) return 'lib/videos/animate2.json';
    switch (condition.toLowerCase()) {
      case 'clouds':
        return 'lib/videos/animate2.json';
      case 'smoke':
      case 'clear':
        return 'lib/videos/sunny.json';
      case 'fog':
      case 'mist':
      case 'rain':
        return 'lib/videos/animate1.json';
      case 'thunderstorm':
      default:
        return 'lib/videos/animate3.json';
    }
  }

  void _openHelpScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HelpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Weather App',
          style: TextStyle(
              color: Colors.yellow.shade600, fontWeight: FontWeight.bold, fontSize: 38),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.black87,
            ),
            onPressed: () => _openHelpScreen(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_pin,
                          color: Colors.black45,
                        ),
                        labelText: 'Enter Location',
                        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Colors.yellow,
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      String cityName = _locationController.text;
                      _fetchWeather(cityName);
                      saveCity(cityName);
                    },
                    child: Text(
                        _locationController.text.isEmpty ? 'Save' : 'Update'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              _weather?.cityName ?? 'loading city...',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            _weather != null
                ? Lottie.asset(getWeatherAnimation(_weather?.condition ?? ""))
                : CircularProgressIndicator(), // Placeholder for animation
            SizedBox(
              height: 30,
            ),
            Text(
              '${_weather?.temparature?.round()}°C',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700),
            ),
            Text(
              _weather?.condition ?? "",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
