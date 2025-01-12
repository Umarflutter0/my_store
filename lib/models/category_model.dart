class CategoryModel {
  final String slug;
  final String name;
  final String url;

  CategoryModel({
    required this.slug,
    required this.name,
    required this.url,
  });

  // Factory constructor to create a CategoryModel from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'],
      name: json['name'],
      url: json['url'],
    );
  }

  // Method to convert CategoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'url': url,
    };
  }
}
