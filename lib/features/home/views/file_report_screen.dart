import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileReportScreen extends StatefulWidget {
  const FileReportScreen({super.key});

  @override
  State<FileReportScreen> createState() => _FileReportScreenState();
}

class _FileReportScreenState extends State<FileReportScreen> {
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  final List<String> userTypes = ['Customer', 'Distributor'];
  List<String> selectedUserTypes = ['Customer'];

  final List<String> issueTypes = ['Hardware', 'Software', 'Battery', 'Others'];
  List<String> selectedIssueTypes = [];

  List<XFile> selectedFiles = [];

  final String droneModel = 'DJI Air 3';

  // Pick multiple images/videos (max 10)
  Future<void> _pickMedia() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        final combinedFiles = [...selectedFiles, ...pickedFiles];
        if (combinedFiles.length > 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You can select up to 10 files only')),
          );
          return;
        }
        setState(() {
          selectedFiles = combinedFiles;
        });
      }
    } catch (e) {
      debugPrint('Pick media error: $e');
    }
  }

  // Toggle selection for User Types
  void _toggleUserType(String userType) {
    setState(() {
      if (selectedUserTypes.contains(userType)) {
        selectedUserTypes.remove(userType);
      } else {
        selectedUserTypes.add(userType);
      }
    });
  }

  // Toggle selection for Issue Types
  void _toggleIssueType(String issueType) {
    setState(() {
      if (selectedIssueTypes.contains(issueType)) {
        selectedIssueTypes.remove(issueType);
      } else {
        selectedIssueTypes.add(issueType);
      }
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  void _submitTicket() {
    // TODO: Implement ticket submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ticket submitted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('File a Report'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: ListView(
            children: [
              // Drone Model
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  children: [
                    const TextSpan(
                      text: 'Drone Model: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: droneModel),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Personal Details header
              const Text(
                'Personal Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),

              // Full Name
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your Gmail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Number
              TextField(
                controller: _numberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter your number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // User Type
              const Text(
                'User Type',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ...userTypes.map((userType) {
                final isSelected = selectedUserTypes.contains(userType);
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(userType),
                  value: isSelected,
                  onChanged: (_) => _toggleUserType(userType),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),
              const SizedBox(height: 20),

              // Issue Type header + See all link
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Issue Type',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement see all
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Issue Types checkboxes
              ...issueTypes.map((issueType) {
                final isSelected = selectedIssueTypes.contains(issueType);
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(issueType),
                  value: isSelected,
                  onChanged: (_) => _toggleIssueType(issueType),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),

              const SizedBox(height: 20),

              // Uploaded Image header
              const Text(
                'Uploaded Image',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              const SizedBox(height: 12),

              // Grid view of selected images
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: selectedFiles.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  if (index == selectedFiles.length) {
                    return GestureDetector(
                      onTap: _pickMedia,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400),
                          color: Colors.grey.shade100,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.blue,
                          size: 36,
                        ),
                      ),
                    );
                  }
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(selectedFiles[index].path),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Submit Ticket button
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitTicket,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit Ticket',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
