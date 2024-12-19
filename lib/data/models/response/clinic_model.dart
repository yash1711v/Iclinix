import 'dart:convert';

// Function to parse JSON data
ClinicModel branchFromJson(String str) => ClinicModel.fromJson(json.decode(str));

// Function to convert model to JSON string
String branchToJson(ClinicModel data) => json.encode(data.toJson());

class ClinicModel {
  ClinicModel({
    required this.id,
    required this.apiBranchId,
    required this.branchCode,
    required this.branchName,
    required this.branchContactNo,
    required this.branchEmailAddress,
    required this.image,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.doctors,
  });

  final int id;
  final int apiBranchId;
  final String branchCode;
  final String branchName;
  final String branchContactNo;
  final String branchEmailAddress;
  final String image;
  final int isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Doctor> doctors;

  factory ClinicModel.fromJson(Map<String, dynamic> json) => ClinicModel(
    id: json["id"],
    apiBranchId: json["api_branch_id"],
    branchCode: json["branch_code"],
    branchName: json["branch_name"],
    branchContactNo: json["branch_contact_no"],
    branchEmailAddress: json["branch_email_address"],
    image: json["image"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    doctors: List<Doctor>.from(json["doctors"].map((x) => Doctor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "api_branch_id": apiBranchId,
    "branch_code": branchCode,
    "branch_name": branchName,
    "branch_contact_no": branchContactNo,
    "branch_email_address": branchEmailAddress,
    "image": image,
    "is_active": isActive,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "doctors": List<dynamic>.from(doctors.map((x) => x.toJson())),
  };
}

class Doctor {
  Doctor({
    required this.id,
    required this.apiDoctId,
    required this.doctorname,
    required this.subspecialtyid,
    required this.mobileno,
    required this.usertype,
    required this.scheduleweekdays,
    required this.profileImage,
    required this.shortDescription,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  final int id;
  final int apiDoctId;
  final String doctorname;
  final int subspecialtyid;
  final String mobileno;
  final String usertype;
  final String scheduleweekdays;
  final String? profileImage;
  final String? shortDescription;
  final int isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["id"],
    apiDoctId: json["api_doct_id"],
    doctorname: json["doctorname"],
    subspecialtyid: json["subspecialtyid"],
    mobileno: json["mobileno"],
    usertype: json["usertype"],
    scheduleweekdays: json["scheduleweekdays"] ?? '',
    profileImage: json["profile_image"],
    shortDescription: json["short_description"],
    isActive: json["isactive"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "api_doct_id": apiDoctId,
    "doctorname": doctorname,
    "subspecialtyid": subspecialtyid,
    "mobileno": mobileno,
    "usertype": usertype,
    "scheduleweekdays": scheduleweekdays,
    "profile_image": profileImage,
    "short_description": shortDescription,
    "isactive": isActive,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  Pivot({
    required this.branchId,
    required this.doctorId,
  });

  final int branchId;
  final int doctorId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    branchId: json["branch_id"],
    doctorId: json["doctor_id"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId,
    "doctor_id": doctorId,
  };
}
