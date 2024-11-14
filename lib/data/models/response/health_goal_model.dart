class MedicalRecord {
  // final int id;
  // final int patientId;
  final String title;
  final String description;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  MedicalRecord({
    // required this.id,
    // required this.patientId,
    required this.title,
    required this.description,
    // required this.createdAt,
    // required this.updatedAt,
  });

  // Factory method to create a MedicalRecord object from a JSON map
  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      // id: json['id'],
      // patientId: json['patient_id'],
      title: json['title'],
      description: json['description'],
      // createdAt: DateTime.parse(json['created_at']),
      // updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'patient_id': patientId,
      'title': title,
      'description': description,
      // 'created_at': createdAt.toIso8601String(),
      // 'updated_at': updatedAt.toIso8601String(),
    };
  }
}
