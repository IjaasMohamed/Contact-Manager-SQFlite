import 'package:flutter/material.dart';
import 'edit_contact_page.dart'; // Import your EditContactPage

class ContactDetailPage extends StatelessWidget {
  final Map<String, dynamic> contact;

  const ContactDetailPage({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(contact['name'], style: TextStyle(fontSize: 18)),
            Divider(),
            Text('Surname', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(contact['surname'], style: TextStyle(fontSize: 18)),
            Divider(),
            Text('Job', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(contact['job'], style: TextStyle(fontSize: 18)),
            Divider(),
            Text('Phone', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(contact['phone'], style: TextStyle(fontSize: 18)),
            Divider(),
            Text('Email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(contact['email'], style: TextStyle(fontSize: 18)),
            Divider(),
            Text('Website', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(contact['website'], style: TextStyle(fontSize: 18)),
            Divider(),
            Text('Is Favorite', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(contact['isFavorite'] == 1 ? 'Yes' : 'No', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditContactPage(
                id: contact['id'].toString(),
                name: contact['name'],
                surname: contact['surname'],
                job: contact['job'],
                phone: contact['phone'],
                email: contact['email'],
                website: contact['website'],
                isFavorite: contact['isFavorite'] == 1,
              ),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
