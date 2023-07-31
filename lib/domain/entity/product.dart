
class Product {
  final String url;
  final String picture;
  final String title;
  final double regularPrice;
  final double finalPrice;
  Product({required this.url, required this.picture, required this.title, required this.regularPrice, required this.finalPrice});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      url: json['Url'],
      picture: json['Picture'],
      title: json['Title'],
      regularPrice: checkDouble(json['RegularPrice']),
      finalPrice: checkDouble(json['FinalPrice']),
    );
  }
}

 double checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else {
      return value;
    }
  }
