
class Promotion {
  final String url;
  final String place;
  final String picture;
  final String title;
  final String description;
  Promotion({required this.url, required this.place, required this.picture, required this.title, required this.description});
 
  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      url: json['Url'],
      place: json['Place'],
      picture: json['Picture'],
      title: json['Title'],
      description: json['Description']
    );
  }
}