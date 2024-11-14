import 'package:flutter/material.dart';

class ContactField extends StatefulWidget {
  const ContactField({super.key});

  @override
  State<ContactField> createState() => _ContactField();
}

class _ContactField extends State<ContactField> {
  int? option;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Divider(height: 1, color: Colors.grey), 
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                  const Text(
                    'Personal', 
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20), 
                  const Text(
                    'Pulsi "Contact" o pulsi el botó de "Continue".', 
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center, 
                  ),
                  const SizedBox(height: 40), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
