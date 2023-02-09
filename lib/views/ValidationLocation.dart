import 'package:flutter/cupertino.dart';

class ValidationLocation extends StatefulWidget {
  static String routeName = '/Profil';
  const ValidationLocation({Key? key}) : super(key: key);

  @override
  _ValidationLocationState createState() => _ValidationLocationState();
}

class _ValidationLocationState extends State<ValidationLocation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Confirmation ok"),
    );
  }
}
