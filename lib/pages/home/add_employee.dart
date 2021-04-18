import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/globals/theme.dart';
import 'package:employee_byte/models/input_type.dart';
import 'package:employee_byte/pages/home/add_employee_controller.dart';
import 'package:employee_byte/widgets/button.dart';
import 'package:employee_byte/widgets/cover.dart';
import 'package:employee_byte/widgets/render_form_inputs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEmployee extends StatelessWidget {
  AddEmployee() {
    Get.put(AddEmployeeController());
  }

  @override
  Widget build(BuildContext context) {
    return Cover(
      child: Column(
        children: [
          Expanded(
            child: AddEmployeeView(),
          ),
          TextButton(
            onPressed: Get.back,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.close_outlined, size: 16),
                SizedBox(width: 10),
                Text('CANCEL')
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}

class AddEmployeeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _addEmployeeController = Get.find<AddEmployeeController>();

    const _stepsIndexCount = 1;

    return Obx(
      () => Stepper(
        steps: [
          _bioStep(
            totalSteps: _stepsIndexCount,
            currentIndex: _addEmployeeController.step,
          ),
          _geography(
            totalSteps: _stepsIndexCount,
            currentIndex: _addEmployeeController.step,
          ),
        ],
        controlsBuilder: (context, {onStepCancel, onStepContinue}) =>
            const SizedBox(),
        type: StepperType.horizontal,
        currentStep: _addEmployeeController.step,
      ),
    );
  }
}

Step _bioStep({
  required int totalSteps,
  required int currentIndex,
}) {
  final _addEmployeeController = Get.find<AddEmployeeController>();
  const _stepIndex = 0;
  return Step(
    title: const Text('BioData'),
    state: currentIndex == _stepIndex
        ? StepState.editing
        : currentIndex < _stepIndex
            ? StepState.indexed
            : StepState.complete,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RenderFormInputs(
          inputs: [
            InputType(
              key: 'fname',
              onChanged: (v) {
                _addEmployeeController.firstName.value = v.trim();
              },
              val: _addEmployeeController.firstName.value,
              decoration: AppTheme.inputDecor(
                const Icon(Icons.person_outline_rounded),
                'First Name',
              ),
            ),
            InputType(
              key: 'lname',
              onChanged: (v) {
                _addEmployeeController.lastName.value = v.trim();
              },
              val: _addEmployeeController.lastName.value,
              decoration: AppTheme.inputDecor(
                const Icon(Icons.person_outline_rounded),
                'Last Name',
              ),
            ),
            InputType(
              key: 'designation',
              onChanged: (v) {
                _addEmployeeController.designation.value = v.trim();
              },
              val: _addEmployeeController.designation.value,
              decoration: AppTheme.inputDecor(
                const Icon(Icons.assignment_ind_outlined),
                'Designation',
              ),
            ),
            InputType(
              custom: DropdownButtonFormField<String>(
                key: const Key('gender'),
                value: _addEmployeeController.gender.value.isEmpty
                    ? null
                    : _addEmployeeController.gender.value,
                items: const [
                  DropdownMenuItem<String>(
                    value: 'Male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Female',
                    child: Text('Female'),
                  ),
                ],
                onChanged: (v) {
                  _addEmployeeController.gender.value = v?.trim() ?? '';
                },
                validator: Validators.required(),
                isExpanded: true,
                decoration: AppTheme.inputDecor(
                  const Icon(Icons.attribution_outlined),
                  'Gender',
                ).copyWith(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Expanded(
              child: SizedBox(),
            ),
            const Spacer(),
            Expanded(
              child: Button(
                label: 'NEXT \t >',
                onPressed: () => _addEmployeeController.next(totalSteps),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Step _geography({
  required int totalSteps,
  required int currentIndex,
}) {
  final _addEmployeeController = Get.find<AddEmployeeController>();
  const _stepIndex = 1;
  return Step(
    title: const Text('Geography'),
    state: currentIndex == _stepIndex
        ? StepState.editing
        : currentIndex < _stepIndex
            ? StepState.indexed
            : StepState.complete,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RenderFormInputs(
          inputs: [
            InputType(
              key: 'country',
              onChanged: (v) {
                _addEmployeeController.country.value = v.trim();
              },
              val: _addEmployeeController.country.value,
              decoration: AppTheme.inputDecor(
                const Icon(Icons.location_searching),
                'Country',
              ),
            ),
            InputType(
              key: 'state',
              onChanged: (v) {
                _addEmployeeController.state.value = v.trim();
              },
              val: _addEmployeeController.state.value,
              decoration: AppTheme.inputDecor(
                const Icon(Icons.map_rounded),
                'State',
              ),
            ),
            InputType(
              key: 'adddress',
              onChanged: (v) {
                _addEmployeeController.address.value = v.trim();
              },
              val: _addEmployeeController.address.value,
              decoration: AppTheme.inputDecor(
                const Icon(Icons.pin_drop_outlined),
                'Address',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  _addEmployeeController.back();
                },
                child: const Text('< \t BACK'),
              ),
            ),
            const Spacer(),
            Expanded(
              child: Button(
                label: 'CREATE \t >',
                onPressed: () => _addEmployeeController.next(totalSteps),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
