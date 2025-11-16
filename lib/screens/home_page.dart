import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'edit_contact_page.dart';
import 'delete_contact_page.dart';

class ContactsHomePage extends StatefulWidget {
  const ContactsHomePage({super.key});

  @override
  State<ContactsHomePage> createState() => _ContactsHomePageState();
}

class _ContactsHomePageState extends State<ContactsHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> addContact() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();

    if (name.isEmpty || phone.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    await DBHelper.insertContact(name, phone, email);

    nameController.clear();
    phoneController.clear();
    emailController.clear();

    setState(() {}); // refresh page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Mes Contacts 💖"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ---------- Add Contact Form ----------
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nom",
                prefixIcon: Icon(Icons.person, color: Color(0xFFD78EE4)),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Téléphone",
                prefixIcon: Icon(Icons.phone, color: Color(0xFFD19BDB)),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email, color: Color(0xFFCB8CD6)),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: addContact,
              icon: const Icon(Icons.add),
              label: const Text("Ajouter"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC581D1),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),

            // ---------- Big Buttons ----------
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text("Modifier un contact"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditListPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD78EE4),
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text("Supprimer un contact"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeleteListPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA5C1),
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






