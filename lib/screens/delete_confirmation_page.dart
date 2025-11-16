import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class DeleteContactPage extends StatelessWidget {
  final int id;
  final String name;

  const DeleteContactPage({super.key, required this.id, required this.name});

  Future<void> deleteContact(BuildContext context) async {
    await DBHelper.deleteContact(id);
    Navigator.pop(context); // go back to DeleteListPage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Supprimer Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Voulez-vous vraiment supprimer ce contact ?",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => deleteContact(context),
              icon: const Icon(Icons.delete),
              label: const Text("Supprimer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA5C1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
