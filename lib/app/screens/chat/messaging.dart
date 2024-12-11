import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/response/ticket_model.dart'; // For formatting the time

class Messaging extends StatelessWidget {
  final List<TicketReply> replies;

  Messaging({required this.replies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chat"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: replies.length,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        itemBuilder: (context, index) {
          final reply = replies[index];
          final bool isBlueBackground = reply.replyByUserId != null;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: isBlueBackground
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isBlueBackground ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reply.message ?? '',
                        style: TextStyle(
                          color: isBlueBackground ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _formatTime(reply.createdAt),
                        style: TextStyle(
                          color: isBlueBackground ? Colors.white70 : Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('h:mm a').format(dateTime); // Formats to 12-hour format
  }
}