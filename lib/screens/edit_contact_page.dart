import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'edit_confirmation_page.dart';

class EditListPage extends StatefulWidget {
  const EditListPage({super.key});

  @override
  State<EditListPage> createState() => _EditListPageState();
}

class _EditListPageState extends State<EditListPage> {
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
        title: const Text("Modifier un contact"),
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
                      child: const Text("Modifier"),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditContactPage(
                              id: c['id'],
                              name: c['name'],
                              phone: c['phone'],
                              email: c['email'],
                            ),
                          ),
                        );
                        loadContacts();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD78EE4),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}




