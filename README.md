# weatherapp

A new Flutter project.

**Features**
1. Automatically acquire user current location
2. Searchable location

**How to Run**
1. Create an account at OpenWeatherMap.
2. Then get your API key from https://home.openweathermap.org/api_keys.
3. Sometimes after getting your OpenWeatherMap API key it won't work right away
   To test if your API key is working or not copy and paste the following link to your browser
   https://api.openweathermap.org/data/2.5/weather?lat=53.4794892&lon=-2.2451148&units=metric&appid=YOUR_API_KEY
   Then replace YOUR_API_KEY with your own API key from OpenWeatherMap
7. Clone the repo
   git clone https://github.com/buddhitamang/weatherapp.git
9. Install all the packages by typing
   flutter pub get
12. Navigate to lib/provider/weatherProvider.dart and paste your API key to the apiKey variable
    String apiKey = 'Paste Your API Key Here';
14. Run the App
