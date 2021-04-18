import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/globals/theme.dart';
import 'package:employee_byte/models/input_type.dart';
import 'package:employee_byte/pages/auth/auth_controller.dart';
import 'package:employee_byte/pages/signup/sign_up_controller.dart';
import 'package:employee_byte/widgets/button.dart';
import 'package:employee_byte/widgets/cover.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  SignUp() {
    Get.put<SignUpController>(SignUpController());
  }

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();

    return Cover(
      child: Column(
        children: [
          Expanded(
            child: SingUpView(),
          ),
          TextButton(
            onPressed: () {
              _authController.goTo(AuthPage.signIn);
            },
            child: Text('SIGN IN AS ADMIN'),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}

class SingUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _signUpController = Get.find<SignUpController>();

    const _stepsIndexCount = 2;

    return Obx(
      () => Stepper(
        steps: [
          _bioStep(
            totalSteps: _stepsIndexCount,
            currentIndex: _signUpController.step,
          ),
          _geography(
            totalSteps: _stepsIndexCount,
            currentIndex: _signUpController.step,
          ),
          _login(
            totalSteps: _stepsIndexCount,
            currentIndex: _signUpController.step,
          ),
        ],
        controlsBuilder: (context, {onStepCancel, onStepContinue}) =>
            const SizedBox(),
        type: StepperType.horizontal,
        currentStep: _signUpController.step,
      ),
    );
  }
}

Step _bioStep({
  required int totalSteps,
  required int currentIndex,
}) {
  final _signUpController = Get.find<SignUpController>();
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
        _RenderForms(
          inputs: [
            InputType(
              key: 'fname',
              onChanged: (v) {
                _signUpController.firstName.value = v.trim();
              },
              val: _signUpController.firstName.value,
              decoration: AppTheme.inputDecor(
                const Icon(Icons.person_outline_rounded),
                'First Name',
              ),
            ),
            InputType(
              key: 'lname',
              onChanged: (v) {
                _signUpController.lastName.value = v.trim();
              },
              val: _signUpController.lastName.value,
              decoration: AppTheme.inputDecor(
                const Icon(Icons.person_outline_rounded),
                'Last Name',
              ),
            ),
            InputType(
              custom: DropdownButtonFormField<String>(
                key: const Key('gender'),
                value: _signUpController.gender.value.isEmpty
                    ? null
                    : _signUpController.gender.value,
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
                  _signUpController.gender.value = v?.trim() ?? '';
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
                onPressed: () => _signUpController.next(totalSteps),
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
  final _signUpController = Get.find<SignUpController>();
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
        _RenderForms(
          inputs: [
            InputType(
              key: 'country',
              onChanged: (v) {
                _signUpController.country.value = v.trim();
              },
              val: _signUpController.country.value,
              decoration: AppTheme.inputDecor(
                const Icon(Icons.location_searching),
                'Country',
              ),
            ),
            InputType(
              key: 'state',
              onChanged: (v) {
                _signUpController.state.value = v.trim();
              },
              val: _signUpController.state.value,
              decoration: AppTheme.inputDecor(
                const Icon(Icons.map_rounded),
                'State',
              ),
            ),
            InputType(
              key: 'adddress',
              onChanged: (v) {
                _signUpController.address.value = v.trim();
              },
              val: _signUpController.address.value,
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
                  _signUpController.back();
                },
                child: const Text('< \t BACK'),
              ),
            ),
            const Spacer(),
            Expanded(
              child: Button(
                label: 'NEXT \t >',
                onPressed: () => _signUpController.next(totalSteps),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Step _login({
  required int totalSteps,
  required int currentIndex,
}) {
  final _signUpController = Get.find<SignUpController>();
  const _stepIndex = 2;
  return Step(
    title: const Text('Login'),
    state: currentIndex == _stepIndex
        ? StepState.editing
        : currentIndex < _stepIndex
            ? StepState.indexed
            : StepState.complete,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _RenderForms(
          inputs: [
            InputType(
              onChanged: (v) {
                _signUpController.username.value = v.trim();
              },
              decoration: AppTheme.inputDecor(
                const Icon(Icons.account_circle_outlined),
                'UserName',
              ),
              val: _signUpController.username.value,
            ),
            InputType(
              onChanged: (v) {
                _signUpController.password.value = v.trim();
              },
              decoration: AppTheme.inputDecor(
                  const Icon(Icons.short_text_rounded), 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _signUpController.showPass.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: _signUpController.togglePasswordVisibility,
                  )),
              val: _signUpController.password.value,
              obscure: !_signUpController.showPass.value,
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
                child: Text('< \t BACK'),
                onPressed: () {
                  _signUpController.back();
                },
              ),
            ),
            const Spacer(),
            Expanded(
              child: Button(
                label: 'SIGN IN',
                onPressed: () => _signUpController.next(totalSteps),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _RenderForms extends StatelessWidget {
  const _RenderForms({Key? key, this.inputs = const []}) : super(key: key);
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
