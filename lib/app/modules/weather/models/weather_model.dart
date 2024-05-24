class Weather {
  final String city;
  final String country;
  final String condition;
  final String conditionIcon;
  final String isDay;
  final String temp;
  final String feelsLike;

  Weather({
    required this.city,
    required this.country,
    required this.condition,
    required this.conditionIcon,
    required this.isDay,
    required this.temp,
    required this.feelsLike,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        city: json['location']['name'].toString(),
        country: json['location']['country'].toString(),
        condition: json['current']['condition']['text'].toString(),
        conditionIcon: json['current']['condition']['icon'].toString(),
        isDay: json['current']['is_day'].toString(),
        temp: json['current']['temp_c'].toString(),
        feelsLike: json['current']['feelslike_c'].toString());
  }
}
