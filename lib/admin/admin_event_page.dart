// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class AdminEventPage extends StatefulWidget {
//   @override
//   _AdminEventPageState createState() => _AdminEventPageState();
// }

// class _AdminEventPageState extends State<AdminEventPage> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _timeController = TextEditingController();
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;

//   Future<void> _addEvent() async {
//     if (_titleController.text.isEmpty ||
//         _descriptionController.text.isEmpty ||
//         _selectedDate == null ||
//         _selectedTime == null) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Please fill out all fields'),
//       ));
//       return;
//     }

//     try {
//       final DateTime eventDateTime = DateTime(
//         _selectedDate!.year,
//         _selectedDate!.month,
//         _selectedDate!.day,
//         _selectedTime!.hour,
//         _selectedTime!.minute,
//       );

//       await FirebaseFirestore.instance.collection('events').add({
//         'title': _titleController.text,
//         'description': _descriptionController.text,
//         'eventDateTime': eventDateTime,
//         'createdAt': Timestamp.now(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Event added successfully!'),
//       ));

//       _clearForm();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error adding event: $e'),
//       ));
//     }
//   }

//   void _clearForm() {
//     _titleController.clear();
//     _descriptionController.clear();
//     _selectedDate = null;
//     _selectedTime = null;
//     setState(() {}); // Update UI to reflect cleared date/time
//   }

//   Future<void> _pickDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   Future<void> _pickTime(BuildContext context) async {
//     TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null && picked != _selectedTime) {
//       setState(() {
//         _selectedTime = picked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add an Event'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextField(
//                 controller: _titleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 readOnly: true,
//                 controller: TextEditingController(
//                   text: _selectedDate == null
//                       ? 'Pick a Date'
//                       : DateFormat.yMMMd().format(_selectedDate!),
//                 ),
//                 decoration: InputDecoration(labelText: 'Date'),
//                 onTap: () => _pickDate(context),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 readOnly: true,
//                 controller: TextEditingController(
//                   text: _selectedTime == null
//                       ? 'Pick a Time'
//                       : _selectedTime!.format(context),
//                 ),
//                 decoration: InputDecoration(labelText: 'Time'),
//                 onTap: () => _pickTime(context),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _addEvent,
//                 child: Text('Add Event'),
//               ),
//               SizedBox(height: 30),
//               Text(
//                 'Upcoming Events',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               // Event list below
//               StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('events')
//                     .orderBy('eventDateTime', descending: false)
//                     .snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (!snapshot.hasData) return CircularProgressIndicator();
//                   var events = snapshot.data!.docs;
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: events.length,
//                     itemBuilder: (context, index) {
//                       var event = events[index];
//                       var eventDateTime = event['eventDateTime'].toDate();
//                       return Card(
//                         child: ListTile(
//                           title: Text(event['title']),
//                           subtitle: Text(
//                             '${DateFormat.yMMMd().format(eventDateTime)} at ${DateFormat.jm().format(eventDateTime)}\n${event['description']}',
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ----------------------------------------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminEventPage extends StatefulWidget {
  @override
  _AdminEventPageState createState() => _AdminEventPageState();
}

class _AdminEventPageState extends State<AdminEventPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _linkController =
      TextEditingController(); // Link controller
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _addEvent() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill out all fields'),
      ));
      return;
    }

    try {
      final DateTime eventDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      await FirebaseFirestore.instance.collection('events').add({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'link': _linkController.text, // Add link to event data
        'eventDateTime': eventDateTime,
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Event added successfully!'),
      ));

      _clearForm();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding event: $e'),
      ));
    }
  }

  Future<void> _deleteEvent(String eventId) async {
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Event deleted successfully!'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error deleting event: $e'),
      ));
    }
  }

  Future<void> _editEvent(String eventId, String title, String description,
      String link, DateTime eventDateTime) async {
    _titleController.text = title;
    _descriptionController.text = description;
    _linkController.text = link;
    _selectedDate = eventDateTime;
    _selectedTime = TimeOfDay.fromDateTime(eventDateTime);

    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(labelText: 'Link (optional)'),
            ),
            SizedBox(height: 10),
            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: _selectedDate == null
                    ? 'Pick a Date'
                    : DateFormat.yMMMd().format(_selectedDate!),
              ),
              decoration: InputDecoration(labelText: 'Date'),
              onTap: () => _pickDate(context),
            ),
            SizedBox(height: 10),
            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: _selectedTime == null
                    ? 'Pick a Time'
                    : _selectedTime!.format(context),
              ),
              decoration: InputDecoration(labelText: 'Time'),
              onTap: () => _pickTime(context),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final DateTime newEventDateTime = DateTime(
                  _selectedDate!.year,
                  _selectedDate!.month,
                  _selectedDate!.day,
                  _selectedTime!.hour,
                  _selectedTime!.minute,
                );
                await FirebaseFirestore.instance
                    .collection('events')
                    .doc(eventId)
                    .update({
                  'title': _titleController.text,
                  'description': _descriptionController.text,
                  'link': _linkController.text,
                  'eventDateTime': newEventDateTime,
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Event updated successfully!'),
                ));
                Navigator.pop(context);
                _clearForm();
              },
              child: Text('Update Event'),
            ),
          ],
        ),
      ),
    );
  }

  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _linkController.clear();
    _selectedDate = null;
    _selectedTime = null;
    setState(() {}); // Update UI to reflect cleared date/time
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _linkController,
                decoration: InputDecoration(
                    labelText: 'Link (optional)'), // Optional link field
              ),
              SizedBox(height: 10),
              TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: _selectedDate == null
                      ? 'Pick a Date'
                      : DateFormat.yMMMd().format(_selectedDate!),
                ),
                decoration: InputDecoration(labelText: 'Date'),
                onTap: () => _pickDate(context),
              ),
              SizedBox(height: 10),
              TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: _selectedTime == null
                      ? 'Pick a Time'
                      : _selectedTime!.format(context),
                ),
                decoration: InputDecoration(labelText: 'Time'),
                onTap: () => _pickTime(context),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addEvent,
                child: Text('Add Event'),
              ),
              SizedBox(height: 30),
              Text(
                'Upcoming Events',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Event list below
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('events')
                    .orderBy('eventDateTime', descending: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  var events = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      var event = events[index];
                      var eventDateTime = event['eventDateTime'].toDate();
                      return Card(
                        child: ListTile(
                          title: Text(event['title']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${DateFormat.yMMMd().format(eventDateTime)} at ${DateFormat.jm().format(eventDateTime)}',
                              ),
                              Text(event['description']),
                              if (event['link'] != null &&
                                  event['link'].isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    // Open link in browser
                                    print('Link: ${event['link']}');
                                  },
                                  child: Text(
                                    event['link'],
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editEvent(
                                      event.id,
                                      event['title'],
                                      event['description'],
                                      event['link'],
                                      eventDateTime);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteEvent(event.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
