import 'package:flutter/material.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<Map<String, String>> _messages = []; // Stores chat messages
  final TextEditingController _controller = TextEditingController(); // Controller for input field

  void _sendMessage() {
    String userMessage = _controller.text.trim();

    if (userMessage.isEmpty) return;

    // Add user message to the list
    setState(() {
      _messages.add({"sender": "user", "message": userMessage});
    });

    // Clear input field after sending
    _controller.clear();

    // Simulate a chatbot response
    Future.delayed(const Duration(seconds: 1), () {
      _botResponse(userMessage);
    });
  }

  void _botResponse(String query) {
    String botMessage;

    // Basic bot response logic (You can integrate NLP models or APIs here)
    if (query.toLowerCase().contains("help")) {
      botMessage = "Sure, I can help! What would you like assistance with?";
    } else if (query.toLowerCase().contains("price")) {
      botMessage = "Our pricing starts from \$5 per hour for electric cycles.";
    } else {
      botMessage = "I'm not sure about that. Could you please clarify your question?";
    }

    setState(() {
      _messages.add({"sender": "bot", "message": botMessage});
    });
  }

  Widget _buildMessage(Map<String, String> message) {
    bool isUser = message["sender"] == "user";

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.green[100] : Colors.blue[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message["message"]!,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask & Help ChatBot'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          // Message list
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessage(message);
              },
            ),
          ),
          // Input field and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                // Input field
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask something...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Send button
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChatBotScreen(),
  ));
}
