import 'package:flutter/material.dart';
import 'package:sqlflite_crud/sql_helper.dart';
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
        child: ListView(
          children: [
            _buildDetailItem('Name', contact['name']),
            _buildDetailItem('Surname', contact['surname']),
            _buildDetailItem('Job', contact['job']),
            _buildDetailItem('Phone', contact['phone']),
            _buildDetailItem('Email', contact['email']),
            _buildDetailItem('Website', contact['website']),
            _buildDetailItem(
              'Is Favorite',
              contact['isFavorite'] == 1 ? 'Yes' : 'No',
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
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
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              await SQLHelper.delete('contacts', contact['id']);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Contact deleted")),
              );
              Navigator.pop(context);
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 18),
        ),
        const Divider(),
      ],
    );
  }
}
