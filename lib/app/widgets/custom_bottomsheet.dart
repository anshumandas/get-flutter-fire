// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/bottom_sheet_controller.dart';
// import '../models/bottom_sheet_item.dart';

// class CustomBottomSheet extends StatelessWidget {
//   const CustomBottomSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bottomSheetController = Get.find<BottomSheetController>();

//     return Obx(() {
//       if (bottomSheetController.isBottomSheetVisible) {
//         return Container(
//           color: Colors.white,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: bottomSheetController.items.map((item) {
//               return ListTile(
//                 leading: Icon(item.icon),
//                 title: Text(item.label),
//                 onTap: item.onTap,
//               );
//             }).toList(),
//           ),
//         );
//       } else {
//         return Container();
//       }
//     });
//   }
// }

// class BottomSheetController {
// }
