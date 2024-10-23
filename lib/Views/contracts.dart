import 'package:flutter/material.dart';
import 'home.dart'; // Import the Home widget

class Contract {
  final String id;
  final String customerFullName;
  final String musicianFullName;
  final String eventDate;
  final String eventLocation;
  final String reason;

  Contract({
    required this.id,
    required this.customerFullName,
    required this.musicianFullName,
    required this.eventDate,
    required this.eventLocation,
    required this.reason,
  });
}

class ContractsList extends StatelessWidget {
  final List<Contract> contracts = [
    Contract(
      id: '1',
      customerFullName: 'John Doe',
      musicianFullName: 'Jane Smith',
      eventDate: '2023-12-01',
      eventLocation: 'New York',
      reason: 'Wedding',
    ),
    Contract(
      id: '2',
      customerFullName: 'Alice Johnson',
      musicianFullName: 'Bob Brown',
      eventDate: '2023-12-15',
      eventLocation: 'Los Angeles',
      reason: 'Corporate Event',
    ),
    // Add more contracts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: contracts.length,
        itemBuilder: (context, index) {
          final contract = contracts[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(contract.customerFullName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Musician: ${contract.musicianFullName}'),
                  Text('Date: ${contract.eventDate}'),
                  Text('Location: ${contract.eventLocation}'),
                  Text('Reason: ${contract.reason}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContractsList(),
  ));
}