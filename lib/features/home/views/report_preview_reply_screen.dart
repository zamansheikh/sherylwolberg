import 'package:flutter/material.dart';

class ReportDetailsWithMessagesScreen extends StatefulWidget {
  const ReportDetailsWithMessagesScreen({super.key});

  @override
  State<ReportDetailsWithMessagesScreen> createState() =>
      _ReportDetailsWithMessagesScreenState();
}

class _ReportDetailsWithMessagesScreenState
    extends State<ReportDetailsWithMessagesScreen> {
  final Map<String, String> personalDetails = const {
    'Full Name': 'John Max',
    'Email': 'John Max@gmail.com',
    'Number': '+96524654684',
    'User Type': 'Customer',
    'Ticket No': '07',
  };

  final Map<String, String> issueDetails = const {
    'Issue': 'Power Issues',
    'Status': 'Process',
  };

  final List<String> uploadedImages = [
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1520022387568-79c35a45ca7c?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?auto=format&fit=crop&w=400&q=80',
  ];

  final List<_ChatMessage> messages = [
    _ChatMessage(
      isSupport: true,
      time: '12:00 AM',
      title: 'Support',
      message:
          'Could you please provide more details about your issue so we can assist you better?',
    ),
    _ChatMessage(isSupport: false, message: 'The battery drains very quickly'),
  ];

  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Widget _buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$key: ',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  Widget _buildMessage(_ChatMessage msg) {
    if (msg.isSupport) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFd8eaff),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(msg.message, style: const TextStyle(fontSize: 14)),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                msg.time ?? '',
                style: TextStyle(fontSize: 11, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      );
    } else {
      // User message
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(msg.message, style: const TextStyle(fontSize: 14)),
      );
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(_ChatMessage(isSupport: false, message: text));
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Details'),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: ListView(
            children: [
              // Personal Details header
              const Text(
                'Personal Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),

              // Personal details key-value pairs
              ...personalDetails.entries.map(
                (entry) => _buildKeyValueRow(entry.key, entry.value),
              ),

              const SizedBox(height: 20),

              // Issue Details header
              const Text(
                'Issue Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),

              // Issue details key-value pairs
              ...issueDetails.entries.map(
                (entry) => _buildKeyValueRow(entry.key, entry.value),
              ),

              const SizedBox(height: 20),

              // Uploaded Images header
              const Text(
                'Uploaded Images',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),

              const SizedBox(height: 12),

              // Images grid 3 columns
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: uploadedImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      uploadedImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Recent Messages header
              const Text(
                'Recent Messages',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),

              // Messages list
              ...messages.map((msg) => _buildMessage(msg)),

              const SizedBox(height: 12),

              // Message input field with send button
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'message...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class _ChatMessage {
  final bool isSupport;
  final String message;
  final String? time;
  final String? title;

  _ChatMessage({
    required this.isSupport,
    required this.message,
    this.time,
    this.title,
  });
}
