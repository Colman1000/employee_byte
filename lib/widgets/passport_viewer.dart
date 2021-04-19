import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassportViewer extends StatelessWidget {
  const PassportViewer({Key? key, this.size = 100, this.value, this.user})
      : super(key: key);

  final double size;
  final String? value;
  final String? user;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size),
          color: Get.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          border: Border.all(
            color: Get.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(size),
          child: Padding(
            padding: EdgeInsets.all(size * 0.06),
            child: value == null
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(size),
                    ),
                    child: Center(
                      child: Text(
                        user == null ? '@' : user![0].toUpperCase(),
                        style: Get.textTheme.overline?.copyWith(
                          fontSize: size * 0.4,
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(size),
                      image: DecorationImage(
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
    );
  }
}
