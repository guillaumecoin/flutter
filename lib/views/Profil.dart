import 'package:flutter/cupertino.dart';

class Profil extends StatefulWidget {
  static String routeName = '/Profil';
  const Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Profil à faire"),
    );
  }
}
