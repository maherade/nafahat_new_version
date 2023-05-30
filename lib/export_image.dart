// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:perfume_store_mobile_app/view/custom_widget/custom_text.dart';
// import 'package:q8allo/colors.dart';
// import 'package:q8allo/services/app_imports.dart';
// import 'package:widgets_to_image/widgets_to_image.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
//
// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);
//
//   @override
//   MainPageState createState() => MainPageState();
// }
//
// class MainPageState extends State<MainPage> {
//   // WidgetsToImageController to access widget
//   WidgetsToImageController controller = WidgetsToImageController();
//
//   // to save image bytes of widget
//   Uint8List? bytes;
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: const Text('Widgets To Image'),
//           centerTitle: true,
//         ),
//         body:  Center(
//           child: WidgetsToImage(
//             controller: controller,
//             child: Container(
//               padding:EdgeInsets.only(right: 7),
//               alignment: Alignment.center,
//               width: 130,
//               height: 130,
//               decoration:const BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle
//               ),
//               child: SizedBox(width: 100,height: 100,child: CustomText('ألو',fontSize: 70,color: AppColors.yellowColor,textAlign: TextAlign.center,)),
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.image_outlined),
//           onPressed: () async {
//             final bytes = await controller.capture();
//             setState(() {
//               this.bytes = bytes;
//             });
//             await saveImageToGallery(bytes!);
//           },
//         ),
//       );
//
//
//
//   Widget buildImage(Uint8List bytes) => Image.memory(bytes);
//
//   Future<void> saveImageToGallery(Uint8List imageBytes) async {
//     final result = await ImageGallerySaver.saveImage(imageBytes);
//     if (result['isSuccess']) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Image saved to gallery')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to save image')),
//       );
//     }
//   }
// }
