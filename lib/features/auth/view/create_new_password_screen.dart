import 'package:flutter/material.dart';
import 'package:workflowx/core/routes/app_pages.dart';
import 'package:workflowx/features/auth/view/widget/custom_loader_popup.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureRetypePassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }

  void _toggleNewPasswordView() {
    setState(() {
      _obscureNewPassword = !_obscureNewPassword;
    });
  }

  void _toggleRetypePasswordView() {
    setState(() {
      _obscureRetypePassword = !_obscureRetypePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Instruction Text
              const Text(
                'Create Your New password',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),

              const SizedBox(height: 24),

              // New Password Label
              const Text(
                'New Password',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),

              const SizedBox(height: 8),

              // New Password TextField
              TextField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  hintText: 'Enter your Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 12,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: _toggleNewPasswordView,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Re-type Password Label
              const Text(
                'Re-type password',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),

              const SizedBox(height: 8),

              // Re-type Password TextField
              TextField(
                controller: _retypePasswordController,
                obscureText: _obscureRetypePassword,
                decoration: InputDecoration(
                  hintText: 'Enter Re-Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 12,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureRetypePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: _toggleRetypePasswordView,
                  ),
                ),
              ),

              const Spacer(),

              // Create Now Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible:
                          false, // user must wait for process to finish
                      builder: (context) => const CustomLoaderPopup(),
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        Navigator.pop(context); // Close the loader
                        // Navigate to the next screen or show a success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password reset successfully!'),
                          ),
                        );
                        Navigator.pushReplacementNamed(context, Routes.signIn);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Create Now',
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
