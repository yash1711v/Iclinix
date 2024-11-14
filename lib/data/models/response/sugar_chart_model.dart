//
// class SugarChartModel {
//   final DateTime testDate;
//   final int? postMeal;
//   final int fastingValues;
//
//   SugarChartModel({
//     required this.testDate,
//     this.postMeal,
//     required this.fastingValues,
//   });
//
//   // Factory method to create an instance of SugarCheckup from JSON
//   factory SugarChartModel.fromJson(Map<String, dynamic> json) {
//     return SugarChartModel(
//       testDate: DateTime.parse(json['test_date'] as String),
//       postMeal: json['post_meal'] as int?,
//       fastingValues: json['fasting_values'] as int,
//     );
//   }
//
//   // Method to convert a SugarCheckup instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'test_date': testDate.toIso8601String(),
//       'post_meal': postMeal,
//       'fasting_values': fastingValues,
//     };
//   }
// }
