
class Shop {
  final String host;
  final String name;
  final String logo;
  Shop({required this.host, required this.name, required this.logo});
 
  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      host: json['Host'],
      name: json['Name'],
      logo: json['Logo']
    );
  }
}