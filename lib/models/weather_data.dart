class WeatherData {
  String? weatherIcon;
  String? weatherDescription;
  double? temperature;
  double? feelsLike;
  double? pressure;
  double? humidity;
  double? windspeed;
  DateTime? sunrise;
  DateTime? sunset;
  String? cityName;

  String? get iconUrl {
    return 'http://openweathermap.org/img/wn/$weatherIcon@2x.png';
  }

  WeatherData({
    this.cityName,
    this.temperature,
    this.weatherDescription,
    this.weatherIcon,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.windspeed,
    this.sunrise,
    this.sunset,
  });

  factory WeatherData.fromjson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final temperature = json['main']['temp'];
    final weatherIcon = json['weather'][0]['icon'];
    final weatherDescription = json['weather'][0]['description'];
    final feelsLike = json['main']['feels_like'];
    final pressure = json['main']['pressure'];
    final humidity = json['main']['humidity'];
    final windspeed = json['wind']['speed'];
    final sunrise =
        DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000);
    final sunset =
        DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000);

    return WeatherData(
      cityName: cityName,
      temperature: temperature.toDouble(),
      weatherDescription: weatherDescription,
      weatherIcon: weatherIcon,
      feelsLike: feelsLike.toDouble(),
      pressure: pressure.toDouble(),
      humidity: humidity.toDouble(),
      windspeed: windspeed.toDouble(),
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}
