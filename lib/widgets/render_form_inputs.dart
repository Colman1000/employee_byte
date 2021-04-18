import 'package:employee_byte/models/input_type.dart';
import 'package:flutter/material.dart';

class RenderFormInputs extends StatelessWidget {
  const RenderFormInputs({Key? key, this.inputs = const []}) : super(key: key);
  final List<InputType> inputs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: inputs.map(createInput).toList(),
    );
  }

  Widget createInput(InputType e) {
    const _pad = EdgeInsets.symmetric(vertical: 10);

    if (e.custom != null) {
      return Padding(
        padding: _pad,
        child: e.custom,
      );
    }

    return Padding(
      padding: _pad,
      child: TextFormField(
        key: Key(e.key ?? ''),
        initialValue: e.val.toString(),
        decoration: e.decoration,
        autovalidateMode: e.autoValidateMode,
        onChanged: e.onChanged,
        obscuringCharacter: e.obscuringCharacter,
        validator: e.validator,
        obscureText: e.obscure,
        keyboardType: e.keyboardType,
      ),
    );
  }
}
