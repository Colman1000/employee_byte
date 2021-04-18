import 'package:employee_byte/globals/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required HeaderLeadingWidget title,
    this.action,
    this.padding = const EdgeInsets.symmetric(horizontal: 30),
  })  : _title = title,
        super(key: key);

  final HeaderLeadingWidget _title;
  final Widget? action;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: padding,
          child: Row(
            children: <Widget>[
              Expanded(
                child: _title.child,
              ),
              ...[action ?? const SizedBox()]
            ],
          ),
        ),
        const Divider(
          indent: 30,
          endIndent: 30,
        ),
      ],
    );
  }
}

class HeaderLeadingWidget {
  const HeaderLeadingWidget({this.title, this.leading, this.muted = true})
      : assert(leading != null || title != null);

  final String? title;
  final Widget? leading;
  final bool muted;

  Widget get child =>
      leading ??
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          title ?? '',
          maxLines: 1,
          textAlign: TextAlign.center,
          style: Get.textTheme.headline4?.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 30,
            letterSpacing: 0,
            color: muted ? Colors.grey : AppTheme.primaryColorD,
          ),
        ),
      );
}