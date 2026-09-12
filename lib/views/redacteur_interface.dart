import 'package:flutter/material.dart';
import '../modele/redacteur.dart';
import '../services/database_manager.dart';
import 'widgets/formulaire_ajout.dart';
import 'widgets/liste_redacteurs.dart';
import 'widgets/dialogs.dart';

class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({Key? key}) : super(key: key);
  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final DatabaseManager _dbManager = DatabaseManager();
  List<Redacteur> _redacteurs = [];
  @override
  void initState() {
    super.initState();
    _chargerRedacteurs();
  }

  Future<void> _chargerRedacteurs() async {
    final redacteurs = await _dbManager.getAllRedacteurs();
    setState(() {
      _redacteurs = redacteurs;
    });
  }

  Future<void> _ajouterRedacteur() async {
    final nom = _nomController.text.trim();
    final prenom = _prenomController.text.trim();
    final email = _emailController.text.trim();

    if (nom.isEmpty || prenom.isEmpty || email.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez remplir tous les champs!')),
        );
      }
      return;
    }

    final redacteur = Redacteur.sansId(
      nom: nom,
      prenom: prenom,
      email: email,
    );

    await _dbManager.insertRedacteur(redacteur);
    await _chargerRedacteurs();

    _nomController.clear();
    _prenomController.clear();
    _emailController.clear();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rédacteur ajouté!')),
      );
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des rédacteurs'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FormulaireAjout(
            nomController: _nomController,
            prenomController: _prenomController,
            emailController: _emailController,
            onAjouter: _ajouterRedacteur,
          ),
          Expanded(
            child: ListeRedacteurs(
              redacteurs: _redacteurs,
              onModifier: (redacteur) => Dialogs.showModifierDialog(
                context,
                redacteur,
                _dbManager,
                _chargerRedacteurs,
              ),
              onSupprimer: (redacteur) => Dialogs.showSupprimerDialog(
                context,
                redacteur,
                _dbManager,
                _chargerRedacteurs,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
