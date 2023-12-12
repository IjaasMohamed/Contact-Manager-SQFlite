import 'package:flutter/material.dart';
import 'sql_helper.dart'; // Import your SQL Helper
import 'edit_contact_page.dart'; // Import your EditContactPage
import 'add_contact_page.dart'; // Import your AddContactPage

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _contacts = [];
  bool _isLoading = true;

  void _refreshContacts() async {
    final data = await SQLHelper.getData('contacts'); // Replace 'contacts' with your table name
    setState(() {
      _contacts = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshContacts();
  }

  void _deleteContact(int id) async {
    await SQLHelper.delete('contacts', id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Contact deleted")),
    );
    _refreshContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Contacts"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _contacts.isEmpty
              ? const Center(
                  child: Text("No contacts yet"),
                )
              : ListView.builder(
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    final contact = _contacts[index];
                    final contactId = contact['id'];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(contact['name']),
                        subtitle: Text(contact['phone'] + '\n' + contact['email']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditContactPage(
                                      id: contactId.toString(),
                                      name: contact['name'],
                                      phone: contact['phone'],
                                      email: contact['email'],
                                    ),
                                  ),
                                ).then((_) => _refreshContacts());
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Delete Contact'),
                                      content: const Text('Are you sure you want to delete this contact?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('CANCEL'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _deleteContact(contactId);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('DELETE'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactPage()),
          ).then((_) => _refreshContacts());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
