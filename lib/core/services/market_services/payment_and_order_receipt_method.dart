// /* ******************************************
//                  *** START***
// ****************************************** */
//
// import 'package:flutter/material.dart';
//
// class LDropDownButton extends StatefulWidget {
//   const LDropDownButton({super.key});
//
//   @override
//   State<LDropDownButton> createState() => _LDropDownButtonState();
// }
//
// class _LDropDownButtonState extends State<LDropDownButton> {
//   String? dropdownValue = 'Green';
//   List<String> dropdownItems = <String>[
//     'Green',
//     'Red',
//     'Yellow',
//     'Blue',
//     'Pink',
//     'Orange'
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: _getColor(dropdownValue!),
//       child: Center(
//         child: DropdownButton<String>(
//           value: dropdownValue,
//           icon: const Icon(Icons.arrow_drop_down),
//           iconSize: 36,
//           elevation: 8,
//           style: const TextStyle(color: Colors.deepPurple, fontSize: 36),
//           onChanged: (String? newValue) {
//             setState(() {
//               dropdownValue = newValue;
//             });
//           },
//           items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
//
//   Color _getColor(String color) {
//     if (color.compareTo('Green') == 0) {
//       return Colors.green;
//     } else if (color.compareTo('Red') == 0) {
//       return Colors.red;
//     } else if (color.compareTo('Yellow') == 0) {
//       return Colors.yellow;
//     } else if (color.compareTo('Pink') == 0) {
//       return Colors.pink;
//     } else if (color.compareTo('Orange') == 0) {
//       return Colors.orange;
//     } else if (color.compareTo('Blue') == 0) {
//       return Colors.blue;
//     } else {
//       return Colors.white;
//     }
//   }
// }
//
// /* ******************************************
// *********************************************
// *********************************************
//               *** END***
// *********************************************
// *********************************************
// ****************************************** */
