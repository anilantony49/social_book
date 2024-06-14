import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/widgets/custom_button.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ColorfulSafeArea(
      color: theme.colorScheme.surface,
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kHeight(15),
                const Text(
                  'Post',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text('Select Image(s)'))),
                kHeight(10),
                Container(
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                      color: AppColors.lLightWhite,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_box_outlined,
                            size: 40,
                          ))),
                ),
                kHeight(10),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text('Add Caption'))),
                kHeight(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    maxLines: 5,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: theme.colorScheme.primary, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.5),
                              width: 1.0,
                            ))),
                  ),
                ),
                kHeight(10),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text('Add Location'))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    // maxLines: 5,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: theme.colorScheme.primary, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.5),
                              width: 1.0,
                            ))),
                  ),
                ),
                kHeight(10),
                const CustomButton(buttonText: 'Upload')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
