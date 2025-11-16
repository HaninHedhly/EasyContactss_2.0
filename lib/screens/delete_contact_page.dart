import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'delete_confirmation_page.dart'; // Confirmation page

class DeleteListPage extends StatefulWidget {
  const DeleteListPage({super.key});

  @override
  State<DeleteListPage> createState() => _DeleteListPageState();
}

class _DeleteListPageState extends State<DeleteListPage> {
  List<Map<String, dynamic>> contacts = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    final data = await DBHelper.getContacts();
    setState(() {
      contacts = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: const Text("Supprimer un contact"),
        backgroundColor: Colors.purple,
      ),
      body: contacts.isEmpty
          ? const Center(child: Text("Aucun contact 🩷"))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final c = contacts[index];
                return Card(
                  color: Colors.purple[100],
                  child: ListTile(
                    title: Text(c['name']),
                    subtitle: Text("${c['phone']} • ${c['email']}"),
                    trailing: ElevatedButton(
                      child: const Text("Supprimer"),
                      onPressed: () async {
                        // Navigate to confirmation delete page
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeleteContactPage(
                              id: c['id'],
                              name: c['name'],
                            ),
                          ),
                        );
                        loadContacts(); // refresh list
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA5C1),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}




