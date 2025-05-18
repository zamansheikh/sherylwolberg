import 'package:flutter/material.dart';

class CustomLoaderPopup extends StatelessWidget {
  const CustomLoaderPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Blue circle with white check icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.check, color: Colors.blue, size: 32),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Success message text
            const Text(
              'Your password has been reset successfully. You can now log in with your new credentials.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),

            const SizedBox(height: 30),

            // Blue loading spinner (circular progress indicator)
            const SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                strokeWidth: 6,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
