class SearchModel {
  int? id;
  int? apiBranchId;
  String? branchCode;
  String? branchName;
  String? branchContactNo;
  String? branchEmailAddress;
  String? image;
  String? charge;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  SearchModel({
    this.id,
    this.apiBranchId,
    this.branchCode,
    this.branchName,
    this.branchContactNo,
    this.branchEmailAddress,
    this.image,
    this.charge,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to create an instance of Branch from JSON
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'],
      apiBranchId: json['api_branch_id'],
      branchCode: json['branch_code'],
      branchName: json['branch_name'],
      branchContactNo: json['branch_contact_no'],
      branchEmailAddress: json['branch_email_address'],
      image: json['image'],
      charge: json['charge'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert the Branch instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'api_branch_id': apiBranchId,
      'branch_code': branchCode,
      'branch_name': branchName,
      'branch_contact_no': branchContactNo,
      'branch_email_address': branchEmailAddress,
      'image': image,
      'charge': charge,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
