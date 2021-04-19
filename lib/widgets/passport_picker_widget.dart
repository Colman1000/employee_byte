import 'dart:io';

import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/globals/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PassportPickerWidget extends StatelessWidget {
  PassportPickerWidget({
    Key? key,
    this.value,
    required this.onChanged,
    this.hintText,
    this.size = 100,
  }) : super(key: key);

  final String? value;

  final String? hintText;
  final double size;

  final PassportPickerCallback onChanged;

  final _state = _State();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size),
              color:
                  Get.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
              border: Border.all(
                color: Get.isDarkMode
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
              ),
            ),
            child: Obx(
              () => _state.pickingImage.value
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : Stack(
                      children: [
                        Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(size),
                          child: InkWell(
                            onTap: () async {
                              _state.pickingImage.value = true;

                              try {
                                final picker = ImagePicker();

                                final pickedFile = await picker.getImage(
                                  source: ImageSource.gallery,
                                );

                                if (pickedFile == null) return;

                                onChanged(pickedFile.path);
                              } catch (e) {
                                return Helpers.showSnackBar(
                                  'An unexpected error occurred',
                                  type: SnackBarType.error,
                                );
                              } finally {
                                _state.pickingImage.value = false;
                              }
                            },
                            borderRadius: BorderRadius.circular(size),
                            child: Padding(
                              padding: EdgeInsets.all(size * 0.06),
                              child: AnimatedContainer(
                                duration: 200.milliseconds,
                                curve: Curves.decelerate,
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(size),
                                  image: (value == null || value!.isEmpty)
                                      ? null
                                      : DecorationImage(
                                          image: FileImage(
                                            File(value!),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.circle,
                              size: 10,
                              color: AppTheme.primaryColorD,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (value == null) ...[
          Align(
            child: Text(
              'TAP ABOVE TO SELECT PASSPORT PHOTO',
              style: Get.textTheme.caption?.copyWith(
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ]
      ],
    );
  }
}

typedef PassportPickerCallback = void Function(String? path);

class _State extends GetxController {
  final pickingImage = false.obs;
}
