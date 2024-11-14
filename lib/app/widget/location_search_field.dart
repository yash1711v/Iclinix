// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:iclinix/utils/dimensions.dart';
//
// class TypeAheadFieldWidget extends StatelessWidget {
//   TypeAheadFieldWidget({super.key});
//
//   final List<String> suggestions = [
//     'Lajpat Nagar',
//     'Gurgaon',
//     'Malviya Nagar',
//     'Nehru Place'
//
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//       child: TypeAheadField<String>(
//         suggestionsCallback: (pattern) {
//           return suggestions
//               .where((item) => item.toLowerCase().contains(pattern.toLowerCase()))
//               .toList();
//         },
//
//         builder: (context, controller, focusNode) {
//           return TextField(
//             controller: controller,
//             focusNode: focusNode,
//             decoration: InputDecoration(
//               isDense: true,
//               contentPadding: EdgeInsets.symmetric(vertical: 2),
//
//               prefixIcon: const Icon(Icons.search),
//               labelText: 'Search for a Location',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(color: Colors.grey, width: 1.0),
//               ),
//             ),
//           );
//         },
//
//         // Define how each suggestion should be displayed in the list
//         itemBuilder: (context, suggestion) {
//           return ListTile(
//             leading: Icon(Icons.location_on_sharp),
//             title: Text(suggestion),
//           );
//         },
//         onSelected: (suggestion) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Selected: $suggestion')),
//           );
//         },
//       ),
//     );
//   }
// }
