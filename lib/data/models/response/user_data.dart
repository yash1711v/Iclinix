class UserData {
  int? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? emailVerifiedAt;
  String? role;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      mobile: json['mobile'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      role: json['role'],
      image: json['image'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'mobile': mobile,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'role': role,
      'image': image,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class PatientData {
  int? id;
  int? userId;


  String? mobileno;
  String? phoneres;
  String? dob;
  int diabetesProblem;
  int bpProblem;
  int eyeProblem;
  DateTime? createdAt;
  DateTime? updatedAt;

  PatientData({
    this.id,
    this.userId,

    this.mobileno,

    this.phoneres,

    this.dob,
    required this.diabetesProblem,
    required this.bpProblem,
    required this.eyeProblem,
    this.createdAt,
    this.updatedAt,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) {
    return PatientData(
      id: json['id'],
      userId: json['user_id'],

      mobileno: json['mobileno'],
      phoneres: json['phoneres'],
      dob: json['dob'],
      diabetesProblem: json['diabetes_problem'] ?? 0,
      bpProblem: json['bp_problem'] ?? 0,
      eyeProblem: json['eye_problem'] ?? 0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'mobileno': mobileno,
      'phoneres': phoneres,
      'dob': dob,
      'diabetes_problem': diabetesProblem,
      'bp_problem': bpProblem,
      'eye_problem': eyeProblem,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class ApiResponse {
  UserData? userData;
  PatientData? patientData;

  ApiResponse({this.userData, this.patientData});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      userData: UserData.fromJson(json['userdata']),
      patientData: PatientData.fromJson(json['patientdata'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userdata': userData?.toJson(),
      'patientdata': patientData?.toJson(),
    };
  }
}
