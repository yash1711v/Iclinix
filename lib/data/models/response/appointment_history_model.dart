import 'dart:convert';

// Main model class for Patient
class AppointmentHistoryModel {
  final int id;
  final int userId;
  final int? parentId;
  final int? apiRegid;
  final int branchId;
  final DateTime regDate;
  final String regTime;
  final String initial;
  final String firstName;
  final String lastName;
  final String? careOfType;
  final String? careOfName;
  final String mobileNo;
  final String? emergencyNo;
  final String? phoneRes;
  final String sex;
  final DateTime dob;
  final int ageYear;
  final int ageMonth;
  final int ageDays;
  final String? areaName;
  final String? pincode;
  final String? patientAddress;
  final String? cityName;
  final String? districtName;
  final String? stateName;
  final String? countryName;
  final String? sourceName;
  final String? occupation;
  final String? partyName;
  final String? emailAddress;
  final String? aadhaarCardNo;
  final String? vip;
  final String? isDisabled;
  final String? nationality;
  final int createSource;
  final int diabetesProblem;
  final int bpProblem;
  final int eyeProblem;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Appointment> patientAppointments;

  AppointmentHistoryModel({
    required this.id,
    required this.userId,
    this.parentId,
    this.apiRegid,
    required this.branchId,
    required this.regDate,
    required this.regTime,
    required this.initial,
    required this.firstName,
    required this.lastName,
    this.careOfType,
    this.careOfName,
    required this.mobileNo,
    this.emergencyNo,
    this.phoneRes,
    required this.sex,
    required this.dob,
    required this.ageYear,
    required this.ageMonth,
    required this.ageDays,
    this.areaName,
    this.pincode,
    this.patientAddress,
    this.cityName,
    this.districtName,
    this.stateName,
    this.countryName,
    this.sourceName,
    this.occupation,
    this.partyName,
    this.emailAddress,
    this.aadhaarCardNo,
    this.vip,
    this.isDisabled,
    this.nationality,
    required this.createSource,
    required this.diabetesProblem,
    required this.bpProblem,
    required this.eyeProblem,
    required this.createdAt,
    required this.updatedAt,
    required this.patientAppointments,
  });

  // Factory method to create a Patient from JSON
  factory AppointmentHistoryModel.fromJson(Map<String, dynamic> json) {
    return AppointmentHistoryModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      parentId: json['parent_id'],
      apiRegid: json['api_regid'],
      branchId: json['branchid'] ?? 0,
      regDate: DateTime.parse(json['regdate'] ?? DateTime.now().toString()),
      regTime: json['regtime'] ?? '',
      initial: json['initial'] ?? '',
      firstName: json['firstname'] ?? '',
      lastName: json['lastname'] ?? '',
      careOfType: json['careoftype'],
      careOfName: json['careofname'],
      mobileNo: json['mobileno'] ?? '',
      emergencyNo: json['emmergencyno'],
      phoneRes: json['phoneres'],
      sex: json['sex'] ?? '',
      dob: DateTime.parse(json['dob'] ?? DateTime.now().toString()),
      ageYear: json['ageyear'] ?? 0,
      ageMonth: json['agemonth'] ?? 0,
      ageDays: json['agedays'] ?? 0,
      areaName: json['areaname'],
      pincode: json['pincode'],
      patientAddress: json['patientaddress'],
      cityName: json['cityname'],
      districtName: json['districtname'],
      stateName: json['statename'],
      countryName: json['countryname'],
      sourceName: json['sourcename'],
      occupation: json['occupation'],
      partyName: json['partyname'],
      emailAddress: json['emailaddress'],
      aadhaarCardNo: json['adharcardno'],
      vip: json['vip'],
      isDisabled: json['isdisabled'],
      nationality: json['nationality'],
      createSource: json['create_source'] ?? 0,
      diabetesProblem: json['diabetes_problem'] ?? 0,
      bpProblem: json['bp_problem'] ?? 0,
      eyeProblem: json['eye_problem'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
      patientAppointments: List<Appointment>.from(json['patient_appointments']?.map((x) => Appointment.fromJson(x)) ?? []),
    );
  }
}

// Model class for Appointment
class Appointment {
  final int id;
  final int patientId;
  final int? apiVisitId;
  final int? apiRegid;
  final int branchId;
  final int? apiBranchId;
  final String branchName;
  final DateTime opdDate;
  final String? opdTime;
  final String? doctorName;
  final String? isCrossReferred;
  final String categoryName;
  final String? isDilated;
  final String? fresh;
  final String? review;
  final int? status;
  final String? adult;
  final String? pediatric;
  final bool? walkIn;
  final bool? withAppointment;
  final String? visitTime;
  final String? returnTime;
  final String? otherProblem;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String branchImage;
  final Branch branch;

  Appointment({
    required this.id,
    required this.patientId,
    this.apiVisitId,
    this.apiRegid,
    required this.branchId,
    this.apiBranchId,
    required this.branchName,
    required this.opdDate,
    this.opdTime,
    this.doctorName,
    this.isCrossReferred,
    required this.categoryName,
    this.isDilated,
    this.fresh,
    this.review,
    this.adult,
    this.pediatric,
    this.walkIn,
    this.withAppointment,
    this.visitTime,
    this.returnTime,
    this.otherProblem,
    this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.branchImage,
    required this.branch,
  });

  // Factory method to create an Appointment from JSON
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? 0,
      patientId: json['patient_id'] ?? 0,
      apiVisitId: json['api_visitid'],
      apiRegid: json['api_regid'],
      branchId: json['branch_id'] ?? 0,
      apiBranchId: json['api_branchid'],
      branchName: json['branchname'] ?? '',
      opdDate: DateTime.parse(json['opddate'] ?? DateTime.now().toString()),
      opdTime: json['opdtime'],
      doctorName: json['doctorname'],
      isCrossReferred: json['iscrossreferred'],
      categoryName: json['categoryname'] ?? '',
      isDilated: json['isdilated'],
      fresh: json['fresh'],
      review: json['review'],
      adult: json['adult'],
      pediatric: json['peadiatric'],
      walkIn: json['walkin'] == 1,
      withAppointment: json['withappointment'] == 1,
      visitTime: json['visittime'],
      returnTime: json['returntime'],
      otherProblem: json['other_problem'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
      branchImage: json['branch_image'] ?? '',
      branch: Branch.fromJson(json['branch']),
      status: json['status'],
    );
  }
}

// Model class for Branch
class Branch {
  final int id;
  final int apiBranchId;
  final String branchCode;
  final String branchName;
  final String branchContactNo;
  final String branchEmailAddress;
  final String image;
  final String charge;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Branch({
    required this.id,
    required this.apiBranchId,
    required this.branchCode,
    required this.branchName,
    required this.branchContactNo,
    required this.branchEmailAddress,
    required this.image,
    required this.charge,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Branch from JSON
  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      apiBranchId: json['api_branchid'] ?? 0,
      branchCode: json['branchcode'] ?? '',
      branchName: json['branchname'] ?? '',
      branchContactNo: json['branchcontactno'] ?? '',
      branchEmailAddress: json['branchemailaddress'] ?? '',
      image: json['image'] ?? '',
      charge: json['charge'] ?? '',
      isActive: json['isactive'] == 1,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
    );
  }
}
