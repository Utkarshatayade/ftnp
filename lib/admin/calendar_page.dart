import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarPage extends StatefulWidget {
  final bool isAdmin;

  CalendarPage({required this.isAdmin});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final TextEditingController _eventController = TextEditingController();

  void _addEvent(String event, BuildContext context) async {
    if (event.isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('events').add({
        'event': event,
        'timestamp': Timestamp.now(),
      });
      _eventController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event added!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding event: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Calendar'),
      ),
      body: Column(
        children: [
          if (widget.isAdmin) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _eventController,
                decoration: InputDecoration(
                  labelText: 'Add new event',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _addEvent(_eventController.text, context),
              child: Text('Add Event'),
            ),
          ],
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('events')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (context, index) {
                    var event = snapshot.data!.docs[index];
                    return Card(
                      child: ListTile(
                        title: Text(event['event']),
                        subtitle: Text(
                          (event['timestamp'] as Timestamp).toDate().toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
