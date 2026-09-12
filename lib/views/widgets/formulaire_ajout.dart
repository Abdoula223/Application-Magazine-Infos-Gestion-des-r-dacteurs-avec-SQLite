import 'package:flutter/material.dart';
class FormulaireAjout extends StatefulWidget {
  final TextEditingController nomController;
  final TextEditingController prenomController;
  final TextEditingController emailController;
  final VoidCallback onAjouter;

  const FormulaireAjout({
    Key? key,
    required this.nomController,
    required this.prenomController,
    required this.emailController,
    required this.onAjouter,
  }) : super(key: key);

  @override
  State<FormulaireAjout> createState() => _FormulaireAjoutState();
}

class _FormulaireAjoutState extends State<FormulaireAjout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Column(
        children: [
          TextField(
            controller: widget.nomController,
            decoration: const InputDecoration(
              labelText: 'Nom',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: widget.prenomController,
            decoration: const InputDecoration(
              labelText: 'Prénom',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: widget.emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: widget.onAjouter,
            icon: const Icon(Icons.add),
            label: const Text('Ajouter un Rédacteur'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}
