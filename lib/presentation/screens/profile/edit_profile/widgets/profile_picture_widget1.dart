// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class ProfilePictureWidget extends StatefulWidget {
//   const ProfilePictureWidget({super.key});

//   @override
//   State<ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
// }

// class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
//   File? _image;

//   Future<void> _pickImage(ImageSource source) async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: source);

//     if (image != null) {
//       setState(() {
//         _image = File(image.path);
//       });
//     }
//   }

//   void _showPicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Gallery'),
//                 onTap: () {
//                   _pickImage(ImageSource.gallery);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_camera),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   _pickImage(ImageSource.camera);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: () {
//               _showPicker(context);
//             },
//             child: CircleAvatar(
//               radius: 80,
//               backgroundImage: _image != null
//                   ? FileImage(_image!)
//                   : const AssetImage('assets/images/profile_placeholder.jpg')
//                       as ImageProvider,
//               backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
