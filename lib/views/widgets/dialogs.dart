import 'package:flutter/material.dart';
import '../../modele/redacteur.dart';
import '../../services/database_manager.dart';
class Dialogs {
  static Future<void> showModifierDialog(
    BuildContext context,
    Redacteur redacteur,
    DatabaseManager dbManager,
    Function() onModified,
  ) async {
    final nomCtrl = TextEditingController(text: redacteur.nom);
    final prenomCtrl = TextEditingController(text: redacteur.prenom);
    final emailCtrl = TextEditingController(text: redacteur.email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier Rédacteur'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomCtrl,
                decoration: const InputDecoration(labelText: 'Nouveau Nom'),
              ),
              TextField(
                controller: prenomCtrl,
                decoration: const InputDecoration(labelText: 'Nouveau Prénom'),
              ),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Nouvel Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                final redacteurModifie = Redacteur(
                  id: redacteur.id,
                  nom: nomCtrl.text.trim(),
                  prenom: prenomCtrl.text.trim(),
                  email: emailCtrl.text.trim(),
                );

                await dbManager.updateRedacteur(redacteurModifie);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rédacteur modifié!')),
                  );
                }
                onModified();
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showSupprimerDialog(
    BuildContext context,
    Redacteur redacteur,
    DatabaseManager dbManager,
    Function() onDeleted,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: Text(
            'Êtes-vous sûr de vouloir supprimer ${redacteur.prenom} ${redacteur.nom}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                await dbManager.deleteRedacteur(redacteur.id!);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rédacteur supprimé!')),
                  );
                }
                onDeleted();
              },
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }
}
