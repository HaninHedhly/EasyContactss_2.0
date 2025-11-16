import '../models/contact.dart';
import '../database/db_helper.dart';

class ContactService {
  // Add a contact (returns the inserted row id)
  Future<int> addContact(Contact contact) async {
    return await DBHelper.insertContact(
      contact.name,
      contact.phone,
      contact.email,
    );
  }

  // Get all contacts as a List<Contact>
  Future<List<Contact>> getContacts() async {
    final rows = await DBHelper.getContacts(); // List<Map<String, dynamic>>
    return rows.map((m) => Contact.fromMap(m)).toList();
  }

  // Update a contact (requires contact.id to be non-null)
  Future<int> updateContact(Contact contact) async {
    if (contact.id == null) {
      throw ArgumentError('Contact id must not be null for update.');
    }
    return await DBHelper.updateContact(
      contact.id!,
      contact.name,
      contact.phone,
      contact.email,
    );
  }

  // Delete a contact by id
  Future<int> deleteContact(int id) async {
    return await DBHelper.deleteContact(id);
  }
}


