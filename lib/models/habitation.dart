import 'package:agence/models/typeHabitat.dart';

class Habitation {
  int id;
  String image;
  String libelle;
  String adresse;
  int chambres;
  int superficie;
  double prixmois;
  TypeHabitat typeHabitat;
  Habitation(this.id, this.typeHabitat, this.image, this.libelle, this.adresse,
      this.chambres, this.superficie,this.prixmois);
}