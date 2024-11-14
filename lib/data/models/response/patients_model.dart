class PatientModel {
  int? id;
  int? userId;
  int? parentId;
  int? apiRegId;
  int? branchId;
  String? registrationDate;
  String? registrationTime;
  String? initial;
  String? firstName;
  String? lastName;
  String? careOfType;
  String? careOfName;
  String? mobileNumber;
  String? emergencyNumber;
  String? phoneResidence;
  String? sex;
  String? dateOfBirth;
  int? ageYear;
  int? ageMonth;
  int? ageDays;
  String? areaName;
  String? pinCode;
  String? patientAddress;
  String? cityName;
  String? districtName;
  String? stateName;
  String? countryName;
  String? sourceName;
  String? occupation;
  String? partyName;
  String? emailAddress;
  String? adhaarCardNo;
  String? vip;
  String? isDisabled;
  String? nationality;
  int? creationSource;
  int? diabetesProblem;
  int? bloodPressureProblem;
  int? eyeProblem;
  DateTime? createdAt;
  DateTime? updatedAt;
  PatientModel({
     this.id,
     this.userId,
     this.parentId,
     this.apiRegId,
     this.branchId,
     this.registrationDate,
     this.registrationTime,
     this.initial,
     this.firstName,
     this.lastName,
     this.careOfType,
     this.careOfName,
     this.mobileNumber,
     this.emergencyNumber,
     this.phoneResidence,
     this.sex,
     this.dateOfBirth,
     this.ageYear,
     this.ageMonth,
     this.ageDays,
    this.areaName,
    this.pinCode,
     this.patientAddress,
     this.cityName,
     this.districtName,
     this.stateName,
     this.countryName,
    this.sourceName,
    this.occupation,
    this.partyName,
     this.emailAddress,
     this.adhaarCardNo,
     this.vip,
     this.isDisabled,
    this.nationality,
     this.creationSource,
     this.diabetesProblem,
     this.bloodPressureProblem,
     this.eyeProblem,
     this.createdAt,
     this.updatedAt,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      userId: json['user_id'],
      parentId: json['parent_id'],
      apiRegId: json['api_regid'],
      branchId: json['branchid'],
      registrationDate: json['regdate'],
      registrationTime: json['regtime'],
      initial: json['initial'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      careOfType: json['careoftype'],
      careOfName: json['careofname'],
      mobileNumber: json['mobileno'],
      emergencyNumber: json['emmergencyno'],
      phoneResidence: json['phoneres'],
      sex: json['sex'],
      dateOfBirth: json['dob'],
      ageYear: json['ageyear'],
      ageMonth: json['agemonth'],
      ageDays: json['agedays'],
      areaName: json['areaname'],
      pinCode: json['pincode'],
      patientAddress: json['patientaddress'],
      cityName: json['cityname'],
      districtName: json['districtname'],
      stateName: json['statename'],
      countryName: json['countryname'],
      sourceName: json['sourcename'],
      occupation: json['occupation'],
      partyName: json['partyname'],
      emailAddress: json['emailaddress'],
      adhaarCardNo: json['adharcardno'],
      vip: json['vip'],
      isDisabled: json['isdisabled'],
      nationality: json['nationality'],
      creationSource: json['create_source'],
      diabetesProblem: json['diabetes_problem'],
      bloodPressureProblem: json['bp_problem'],
      eyeProblem: json['eye_problem'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['parent_id'] = parentId;
    map['api_regid'] = apiRegId;
    map['branchid'] = branchId;
    map['regdate'] = registrationDate;
    map['regtime'] = registrationTime;
    map['initial'] = initial;
    map['firstname'] = firstName;
    map['lastname'] = lastName;
    map['careoftype'] = careOfType;
    map['careofname'] = careOfName;
    map['mobileno'] = mobileNumber;
    map['emmergencyno'] = emergencyNumber;
    map['phoneres'] = phoneResidence;
    map['sex'] = sex;
    map['dob'] = dateOfBirth;
    map['ageyear'] = ageYear;
    map['agemonth'] = ageMonth;
    map['agedays'] = ageDays;
    map['areaname'] = areaName;
    map['pincode'] = pinCode;
    map['patientaddress'] = patientAddress;
    map['cityname'] = cityName;
    map['districtname'] = districtName;
    map['statename'] = stateName;
    map['countryname'] = countryName;
    map['sourcename'] = sourceName;
    map['occupation'] = occupation;
    map['partyname'] = partyName;
    map['emailaddress'] = emailAddress;
    map['adharcardno'] = adhaarCardNo;
    map['vip'] = vip;
    map['isdisabled'] = isDisabled;
    map['nationality'] = nationality;
    map['create_source'] = creationSource;
    map['diabetes_problem'] = diabetesProblem;
    map['bp_problem'] = bloodPressureProblem;
    map['eye_problem'] = eyeProblem;
    map['created_at'] = createdAt.toString();
    map['updated_at'] = updatedAt.toString();
    return map;
  }
}