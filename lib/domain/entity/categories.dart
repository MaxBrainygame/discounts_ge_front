
class Categories {
  final int key;
  final String name;
  Categories({required this.key, required this.name});
 
  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      key: int.parse(json['Key']),
      name: json['Name']
    );
  }

   Map<String, dynamic> toJson() => {
        'key': key,
        'name': name,
      };
}