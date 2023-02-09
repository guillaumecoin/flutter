class TypeHabitat {
  int id;
  String libelle;

  TypeHabitat.fromJson(Map<String, dynamic> json):
        id = json['id'],
        libelle = json ['libelle'];
}