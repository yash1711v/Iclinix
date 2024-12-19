class SugarCheckupModel {
  final int id;
  final int patientId;
  final String? testDate; // Allow nullable testDate
  final int testType;
  final int checkingTime;
  final String? measuredValue; // Allow nullable measuredValue
  final String? createdAt; // Allow nullable createdAt
  final String? updatedAt; // Allow nullable updatedAt

  SugarCheckupModel({
    required this.id,
    required this.patientId,
    this.testDate, // Nullable
    required this.testType,
    required this.checkingTime,
    this.measuredValue, // Nullable
    this.createdAt, // Nullable
    this.updatedAt, // Nullable
  });

  // Factory constructor for creating a new instance from JSON
  factory SugarCheckupModel.fromJson(Map<String, dynamic> json) {
    return SugarCheckupModel(
      id: json['id'],
      patientId: json['patient_id'],
      testDate: json['test_date'] as String?,
      testType: json['test_type'],
      checkingTime: json['checking_time'],
      measuredValue: json['measured_value'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId,
      'test_date': testDate,
      'test_type': testType,
      'checking_time': checkingTime,
      'measured_value': measuredValue,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
