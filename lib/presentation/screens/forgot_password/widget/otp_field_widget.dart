import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

class OtpFieldWidget extends StatefulWidget {
  const OtpFieldWidget({super.key});

  @override
  State<OtpFieldWidget> createState() => _OtpFieldWidgetState();
}

class _OtpFieldWidgetState extends State<OtpFieldWidget> {
  late List<FocusNode> _focusNodes;

  late List<TextEditingController> _controllers;
    final TextEditingController otpController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _focusNodes = List<FocusNode>.generate(6, (int index) => FocusNode());
    _controllers = List<TextEditingController>.generate(
        6, (int index) => TextEditingController());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _nextField(String value, int index) {
    if (value.length == 1 && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.length == 1 && index == _focusNodes.length - 1) {
      _focusNodes[index].unfocus();
      // You can add logic here to submit the OTP
      _submitOtp();
    }
  }

  void _submitOtp() {
    String otp = _controllers.map((controller) => controller.text).join();
    print("Entered OTP is: $otp");
    // You can handle OTP submission logic here
  }

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 600),
      duration: const Duration(milliseconds: 1000),
      child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('OTP sent'),
                const Text('Enter the OTP sent to to you'),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: const TextStyle(fontSize: 24),
                          decoration: const InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _nextField(value, index);
                          },
                        ),
                      );
                    })),
                      kHeight(20),

                      CustomTextFormField(hintText: 'Next',
                      controller: otpController,)
              ],
            ),
          )),
    );
  }
}
