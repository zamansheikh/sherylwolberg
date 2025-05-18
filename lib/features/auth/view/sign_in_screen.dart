import 'package:flutter/material.dart';
import 'package:workflowx/core/constants/app_assets.dart';
import 'package:workflowx/core/utils/svg_icon.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo image (make sure to add this asset in pubspec.yaml)
              SvgIcon(assetName: AppAssets.appLogo, width: 150, height: 80),
              const SizedBox(height: 16),

              // Description text
              const Text(
                'Submit your ticket, upload images, and let our team handle the rest',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 32),

              // Sign In button (blue background)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Handle sign in
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('Sign In', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 12),

              // Sign up button (outlined)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: Handle sign up
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
