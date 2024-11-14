class PlanModel {
  int planId;
  String planName;
  double price;
  double discount;
  double sellingPrice;
  int discountType;
  int duration;
  String sortDesc;
  String description;
  String? tagLine; // Nullable because it can be null in the response
  int status;
  List<FeatureModel> features;
  String? createdAt; // Nullable
  String? updatedAt; // Nullable

  PlanModel({
    required this.planId,
    required this.planName,
    required this.price,
    required this.discount,
    required this.sellingPrice,
    required this.discountType,
    required this.duration,
    required this.sortDesc,
    required this.description,
    this.tagLine, // Nullable
    required this.status,
    required this.features,
    this.createdAt, // Nullable
    this.updatedAt, // Nullable
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      planId: json['plan_id'] ?? 0, // Default to 0 if null
      planName: json['plan_name'] ?? '', // Default to an empty string if null
      price: (json['price'] ?? 0).toDouble(), // Default to 0.0 if null
      discount: (json['discount'] ?? 0).toDouble(), // Default to 0.0 if null
      sellingPrice: (json['selling_price'] ?? 0).toDouble(), // Default to 0.0 if null
      discountType: json['discount_type'] ?? 0, // Default to 0 if null
      duration: json['duration'] ?? 0, // Default to 0 if null
      sortDesc: json['sort_desc'] ?? '', // Default to an empty string if null
      description: json['description'] ?? '',
      tagLine: json['tag_line'], // Nullable, keep as is
      status: json['status'] ?? 0, // Default to 0 if null
      features: (json['features'] as List<dynamic>?)
          ?.map((feature) => FeatureModel.fromJson(feature))
          .toList() ?? [], // Ensure a default empty list if features is null
      createdAt: json['created_at'], // Nullable, keep as is
      updatedAt: json['updated_at'], // Nullable, keep as is
    );
  }
}

class FeatureModel {
  int id;
  String featureName;
  int sortOrder;
  int status;

  FeatureModel({
    required this.id,
    required this.featureName,
    required this.sortOrder,
    required this.status,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      id: json['id'] ?? 0, // Default to 0 if null
      featureName: json['feature_name'] ?? '', // Default to an empty string if null
      sortOrder: json['sort_order'] ?? 0, // Default to 0 if null
      status: json['status'] ?? 0, // Default to 0 if null
    );
  }
}
