import 'package:agence/services/habitation_service.dart';
import 'package:agence/share/location_style.dart';
import 'package:agence/share/location_text_style.dart';
import 'package:agence/views/BottomNavigationBarWidget.dart';
import 'package:agence/views/LocationList.dart';
import 'package:agence/views/Login.dart';
import 'package:agence/views/Profil.dart';
import 'package:agence/views/ResaLocation.dart';
import 'package:agence/views/ValidationLocation.dart';
import 'package:agence/views/habitat_list.dart';
import 'package:agence/views/habitation_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/habitation.dart';
import 'models/typeHabitat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Locations',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Mes locations'),
      routes: {
          Profil.routeName: (context) => const Profil(),
          LoginPage.routeName: (context) => const LoginPage('/'),
          LocationList.routeName: (context) => const LocationList(),
          ValidationLocation.routeName: (context) => const ValidationLocation(),
        },
      localizationsDelegates: const[GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('fr')],
    );
  }
}





class MyHomePage extends StatelessWidget {
  final String title;
  final HabitationService service = HabitationService();
  late List<TypeHabitat> _typehabitats;
  late List<Habitation> _habitations;


  MyHomePage({required this.title, Key? key}) : super(key: key) {
    _habitations = service.getHabitationsTop10();
    _typehabitats = service.getTypeHabitats();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            _buildTypeHabitat(context),
            SizedBox(height: 20),
            _buildDerniereLocation(context),

            BottomNavigationBarWidget(0)
          ],
        ),
      ),

    );
    return Container();
  }

  _buildTypeHabitat(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_typehabitats.length,
            (index) => _buildHabitat(context, _typehabitats[index])),
      ),
    );
  }

  _buildHabitat(BuildContext context, TypeHabitat typeHabitat) {
    var icon = Icons.house;
    switch (typeHabitat.id) {
      case 2:
        icon = Icons.apartment;
        break;
      default:
        icon = Icons.home;
    }
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: LocationStyle.backgroundColorPurple,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HabitationList(typeHabitat.id == 1),
                ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white70,
              ),
              SizedBox(width: 5),
              Text(
                typeHabitat.libelle,
                style: LocationTextStyle.regularWhiteTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildDerniereLocation(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
        itemCount: _habitations.length,
        itemExtent: 220,
        itemBuilder: (context, index) =>
            _buildRow(_habitations[index], context),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  _buildRow(Habitation habitation, BuildContext context) {
    var format = NumberFormat("### €");

    return Container(
      width: 240,
      margin: EdgeInsets.all(4.0),
    child: GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HabitationDetails(habitation)),
    );
    },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/locations/${habitation.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
            habitation.libelle,
            style: LocationTextStyle.regularTextStyle,
          ),
          Row(
            children: [
              Icon(Icons.location_on_outlined),
              Text(
                habitation.adresse,
                style: LocationTextStyle.regularTextStyle,
              ),
            ],
          ),
          Text(
            format.format(habitation.prixmois),
            style: LocationTextStyle.regularTextStyle,
          ),
        ],
      ),
    ),
    );
  }
}
