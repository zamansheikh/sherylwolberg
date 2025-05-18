import 'dart:async';

import 'package:flutter/material.dart';

class ForgetPasswordVerifyScreen extends StatefulWidget {
  const ForgetPasswordVerifyScreen({super.key});

  @override
  State<ForgetPasswordVerifyScreen> createState() =>
      _ForgetPasswordVerifyScreenState();
}

class _ForgetPasswordVerifyScreenState
    extends State<ForgetPasswordVerifyScreen> {
  final List<TextEditingController> _codeControllers = List.generate(
    4,
    (_) => TextEditingController(text: '5'),
  );

  int _resendSeconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _resendSeconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _resendSeconds--;
        });
      }
    });
  }

  Widget _buildCodeBox(TextEditingController controller) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          contentPadding: const EdgeInsets.all(0),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const email = 'infogma@gmail.com';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Instruction text with email link styled blue
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                  children: [
                    const TextSpan(text: 'Code has been send to '),
                    TextSpan(
                      text: email,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Code input boxes row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _codeControllers
                    .map((controller) => _buildCodeBox(controller))
                    .toList(),
              ),

              const SizedBox(height: 24),

              // Resend code timer text
              Text(
                _resendSeconds > 0
                    ? 'Resend Code in $_resendSeconds s'
                    : 'Didn\'t receive the code? Resend',
                style: TextStyle(
                  fontSize: 14,
                  color: _resendSeconds > 0 ? Colors.grey : Colors.blue,
                ),
              ),

              const Spacer(),

              // Verify button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement verify action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
