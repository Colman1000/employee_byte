import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/globals/theme.dart';
import 'package:employee_byte/models/country.dart';
import 'package:employee_byte/models/input_type.dart';
import 'package:employee_byte/pages/home/add_employee_controller.dart';
import 'package:employee_byte/widgets/button.dart';
import 'package:employee_byte/widgets/cover.dart';
import 'package:employee_byte/widgets/date_picker_widget.dart';
import 'package:employee_byte/widgets/render_form_inputs.dart';
import 'package:flutter/cupertino.dart' hide State;
import 'package:flutter/material.dart' hide State;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';

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
              custom: DatePickerWidget(
                onChanged: (v) {
                  _addEmployeeController.dateOfBirth.value = v;
                },
                value: _addEmployeeController.dateOfBirth.value,
                hintText: 'Select Date of Birth',
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
              custom: Obx(
                () {
                  return TypeAheadFormField<Country>(
                    key: Key(_addEmployeeController.country.value),
                    itemBuilder: (context, country) => ListTile(
                      title: Text(country.name),
                      subtitle: Text(country.code),
                      dense: true,
                      enableFeedback: true,
                    ),
                    initialValue: _addEmployeeController.country.value,
                    suggestionsCallback: (query) async {
                      const _maxResultSet = 15;
                      final _countries = <Country>[];
                      final _appController = Get.find<AppController>();
                      for (final c in await _appController.countries) {
                        if (c.name
                            .toLowerCase()
                            .contains(query.toLowerCase())) {
                          _countries.add(c);
                        }
                        if (_countries.length >= _maxResultSet) {
                          break;
                        }
                      }
                      return _countries;
                    },
                    hideOnEmpty: true,
                    onSuggestionSelected: (country) {
                      _addEmployeeController.country.value = country.name;
                      _addEmployeeController.uiStates.value = country.states;
                    },
                    animationDuration: 200.milliseconds,
                    loadingBuilder: (context) => const SizedBox(
                      height: 50,
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    getImmediateSuggestions: true,
                    noItemsFoundBuilder: (context) => SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'No Such Country Found',
                          style: Get.textTheme.caption,
                        ),
                      ),
                    ),
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: AppTheme.inputDecor(
                        const Icon(Icons.location_searching),
                        'Country',
                      ),
                    ),
                  );
                },
              ),
            ),
            InputType(
              custom: Obx(
                () {
                  return TypeAheadFormField<State>(
                    key: Key(_addEmployeeController.uiState.value),
                    itemBuilder: (context, state) => ListTile(
                      title: Text(state.name),
                      subtitle: Text(state.code),
                      dense: true,
                      enableFeedback: true,
                    ),
                    initialValue: _addEmployeeController.state.value,
                    suggestionsCallback: (query) async {
                      //TODO: Refactor to helper
                      const _maxResultSet = 15;
                      final _states = <State>[];
                      for (final c in _addEmployeeController.uiStates.value) {
                        if (c.name
                            .toLowerCase()
                            .contains(query.toLowerCase())) {
                          _states.add(c);
                        }
                        if (_states.length >= _maxResultSet) {
                          break;
                        }
                      }
                      return _states;
                    },
                    hideOnEmpty: true,
                    onSuggestionSelected: (state) {
                      _addEmployeeController.state.value = state.name;
                      //The line below makes this widget rebuild
                      _addEmployeeController.uiState.value = state.name;
                    },
                    animationDuration: 200.milliseconds,
                    loadingBuilder: (context) => const SizedBox(
                      height: 50,
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    getImmediateSuggestions: true,
                    noItemsFoundBuilder: (context) => const SizedBox(),
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: AppTheme.inputDecor(
                        const Icon(Icons.map_rounded),
                        'State',
                      ),
                      onChanged: (v) {
                        _addEmployeeController.state.value = v.trim();
                      },
                    ),
                  );
                },
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
