//Declaration de la class Redacteur 
class Redacteur {
  int? id;
  String nom;
  String prenom;
  String email;
  // Constructeur avec tous les attributs
  Redacteur({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
  });
  // Constructeur sans id 
  Redacteur.sansId({
    required this.nom,
    required this.prenom,
    required this.email,
  }) : id = null;
  // Nous allons convertir object redacteur en maps
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
    };
  }
  // Maps permetde stocker des éléments sous forme de paires clé-valeur
  factory Redacteur.fromMap(Map<String, dynamic> map) {
    return Redacteur(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
    );
  }
}