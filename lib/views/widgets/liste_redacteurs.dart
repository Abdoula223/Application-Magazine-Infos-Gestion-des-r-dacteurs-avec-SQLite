import 'package:flutter/material.dart';
import '../../modele/redacteur.dart';
class ListeRedacteurs extends StatelessWidget {
  final List<Redacteur> redacteurs;
  final Function(Redacteur) onModifier;
  final Function(Redacteur) onSupprimer;

  const ListeRedacteurs({
    Key? key,
    required this.redacteurs,
    required this.onModifier,
    required this.onSupprimer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (redacteurs.isEmpty) {
      return const Center(
        child: Text('Aucun rédacteur enregistré'),
      );
    }

    return ListView.builder(
      itemCount: redacteurs.length,
      itemBuilder: (context, index) {
        final redacteur = redacteurs[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: Text('${redacteur.prenom} ${redacteur.nom}'),
            subtitle: Text(redacteur.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => onModifier(redacteur),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => onSupprimer(redacteur),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
