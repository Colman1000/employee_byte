import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    Key? key,
    this.value,
    required this.onChanged,
    this.hintText,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  /// This represents the current date selected...
  /// if null, the widget will not display any date, else
  /// the selected date will be displayed
  final DateTime? value;

  /// The date earliest date allowed to be selected by this widget
  /// e.g. if [firstDate] is Jan. 1st 2021, 2020 and below is
  /// automatically un-selectable
  final DateTime? firstDate;

  /// The date latest date allowed to be selected by this widget
  /// e.g. if [lastDate] is Jan. 1st 2021, only 2020 and below
  /// can be selected
  final DateTime? lastDate;

  /// Message to be shown on DatePicker
  final String? hintText;

  /// Callback when date is selected
  final DatePickerCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade800,
        border: Border.all(
          color: Colors.grey.shade800,
        ),
      ),
      duration: 200.milliseconds,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () async {
            onChanged(
              await showDatePicker(
                context: context,
                firstDate: firstDate ??
                    DateTime.now().subtract(
                      (365 * 200).days,
                    ),
                initialDate: value ?? DateTime.now(),
                lastDate: lastDate ?? DateTime.now(),
                fieldLabelText: hintText,
                helpText: hintText,
              ),
            );
          },
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value == null
                        ? hintText ?? 'Date'
                        : formatDate(value!, [MM, ' ', d, ', ', yyyy]),
                    style: Get.textTheme.bodyText1,
                  ),
                ),
                Icon(
                  Icons.event_note_outlined,
                  color: Get.textTheme.caption?.color,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef DatePickerCallback = void Function(DateTime? date);
