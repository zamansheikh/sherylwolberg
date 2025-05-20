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
  String? customIssueText;

  final String droneModel = 'DJI Air 3';

  // Pick multiple images and videos (max 10 total)
  Future<void> _pickMedia() async {
    try {
      final List<XFile> pickedImages = await _picker.pickMultiImage();
      final XFile? pickedVideo = await _picker.pickVideo(
        source: ImageSource.gallery,
      );
      List<XFile> newFiles = [...pickedImages];
      if (pickedVideo != null) {
        newFiles.add(pickedVideo);
      }
      final combinedFiles = [...selectedFiles, ...newFiles];
      if (combinedFiles.length > 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You can select up to 10 files only (photos/videos)'),
          ),
        );
        return;
      }
      setState(() {
        selectedFiles = combinedFiles;
      });
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
        if (issueType == 'Others') customIssueText = null;
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
          icon: const Icon(Icons.arrow_back_ios),
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

              // Issue Type header
              const Text(
                'Select Issue Type',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              const SizedBox(height: 8),

              // Issue Types checkboxes
              ...issueTypes.map((issueType) {
                final isSelected = selectedIssueTypes.contains(issueType);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(issueType),
                      value: isSelected,
                      onChanged: (_) => _toggleIssueType(issueType),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    if (issueType == 'Others' && isSelected)
                      Padding(
                        padding: const EdgeInsets.only(left: 40, bottom: 8),
                        child: TextField(
                          onChanged:
                              (val) => setState(() => customIssueText = val),
                          decoration: const InputDecoration(
                            hintText: 'Please specify your issue',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                  ],
                );
              }).toList(),

              const SizedBox(height: 20),

              // Uploaded Image/Video header
              const Text(
                'Uploaded Image/Video',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              const SizedBox(height: 12),

              // Grid view of selected images and videos
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
                  final file = selectedFiles[index];
                  final isVideo =
                      file.path.toLowerCase().endsWith('.mp4') ||
                      file.path.toLowerCase().endsWith('.mov');
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:
                        isVideo
                            ? Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  color: Colors.black12,
                                  child: const Center(
                                    child: Icon(
                                      Icons.videocam,
                                      size: 40,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Video',
                                      style: TextStyle(
                                        color: Colors.white,
                                        backgroundColor: Colors.black54,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                            : Image.file(File(file.path), fit: BoxFit.cover),
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
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
