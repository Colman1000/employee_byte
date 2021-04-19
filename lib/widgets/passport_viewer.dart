import 'dart:io';

import 'package:employee_byte/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassportViewer extends StatelessWidget {
  const PassportViewer({Key? key, this.size = 100, this.value})
      : super(key: key);

  final double size;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size),
          color: Colors.grey.shade800,
          border: Border.all(
            color: Colors.grey.shade800,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(size),
          child: Padding(
            padding: EdgeInsets.all(size * 0.1),
            child: value == null
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(size),
                    ),
                    child: Center(
                      child: Text(
                        Get.find<AppController>().user.value?.username[0] ??
                            '@',
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
