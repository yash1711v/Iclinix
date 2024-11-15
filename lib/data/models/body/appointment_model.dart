class AppointmentModel {
  String? patientId;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? gender;
  String? dob;
  String? appointmentDate;
  String? appointmentTime;
  String? diabetesProblem;
  String? bpProblem;
  String? eyeProblem;
  String? otherProblem;
  String? patientType;
  String? branchId;
  String? initial;
  bool includePatientType;
  String? type;
  String? complaint;
  String? address;

  AppointmentModel({
    this.patientId,
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.gender,
    this.dob,
    this.appointmentDate,
    this.appointmentTime,
    this.diabetesProblem,
    this.bpProblem,
    this.eyeProblem,
    this.otherProblem,
    this.patientType,
    this.branchId,
    this.initial,
    this.type,
    required this.includePatientType,
    this.complaint,
    this.address,
  });
}
