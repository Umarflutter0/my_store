class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final double weight;
  final Dimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Review> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Meta meta;
  final List<String> images;
  final String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Title',
      description: json['description'] ?? 'No description available',
      category: json['category'] ?? 'Unknown Category',
      price: (json['price'] ?? 0.0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      stock: json['stock'] ?? 0,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      brand: json['brand'] ?? 'Unknown Brand',
      sku: json['sku'] ?? 'Unknown SKU',
      weight: (json['weight'] ?? 0.0).toDouble(),
      dimensions: json['dimensions'] != null
          ? Dimensions.fromJson(json['dimensions'])
          : Dimensions.empty(),
      warrantyInformation:
          json['warrantyInformation'] ?? 'No warranty information available',
      shippingInformation:
          json['shippingInformation'] ?? 'No shipping information available',
      availabilityStatus: json['availabilityStatus'] ?? 'Unknown Status',
      reviews: (json['reviews'] as List?)
              ?.map((review) => Review.fromJson(review))
              .toList() ??
          [],
      returnPolicy: json['returnPolicy'] ?? 'No return policy',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 1,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : Meta.empty(),
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}

class Dimensions {
  final double width;
  final double height;
  final double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: (json['width'] ?? 0.0).toDouble(),
      height: (json['height'] ?? 0.0).toDouble(),
      depth: (json['depth'] ?? 0.0).toDouble(),
    );
  }

  factory Dimensions.empty() {
    return Dimensions(width: 0.0, height: 0.0, depth: 0.0);
  }
}

class Review {
  final double rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: (json['rating'] ?? 0.0).toDouble(),
      comment: json['comment'] ?? 'No comment',
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      reviewerName: json['reviewerName'] ?? 'Unknown Reviewer',
      reviewerEmail: json['reviewerEmail'] ?? 'no-reply@unknown.com',
    );
  }
}

class Meta {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      barcode: json['barcode'] ?? '',
      qrCode: json['qrCode'] ?? '',
    );
  }

  factory Meta.empty() {
    return Meta(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      barcode: '',
      qrCode: '',
    );
  }
}
