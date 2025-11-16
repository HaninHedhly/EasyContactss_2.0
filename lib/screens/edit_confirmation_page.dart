import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class EditContactPage extends StatefulWidget {
  final int id;
  final String name;
  final String phone;
  final String email;

  const EditContactPage({
    super.key,
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
    emailController = TextEditingController(text: widget.email);
  }

  Future<void> updateContact() async {
    await DBHelper.updateContact(
      widget.id,
      nameController.text,
      phoneController.text,
      emailController.text,
    );

    Navigator.pop(context); // back to EditListPage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: const Text("Modifier Contact"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Téléphone"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: updateContact,
              child: const Text("Enregistrer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD78EE4),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
