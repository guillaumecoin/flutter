
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/habitation.dart';
import '../share/location_style.dart';

class ResaLocation extends StatefulWidget {
  final Habitation _habitation;
  const ResaLocation(this._habitation, {Key? key}) : super(key: key);

  @override
  State<ResaLocation> createState() => _ResaLocationState();
}

class _ResaLocationState extends State<ResaLocation> {
  DateTime dateDebut = DateTime.now();
  DateTime dateFin = DateTime.now();
  String nbPersonnes = '1';
  late OptionPayante optionPayante;
  List<String> listNbPersonnes = <String>['1', '2', '3', '4','5','6','7','8'];
  List<OptionPayanteCheck> optionPayanteChecks = [];
  var format = NumberFormat("### €");
  int prixTotal = 0;

  @override
  Widget build(BuildContext context) {
    _loadOptionPayantes();
    return Scaffold(
      appBar: AppBar(
        title: Text('Réservation'),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          _buildResume(),
          _buildDates(),
           _buildNbPersonnes(),
          _buildOptionsPayantes(context),
          // TotalWidget(prixTotal),
           _buildRentButton(),
        ],
      ),
    );
  }

  _buildResume() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 3,
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text(widget._habitation.typeHabitat.libelle),
            subtitle: Text(widget._habitation.adresse),
          ),
        ),
      ],
    );
  }

  _buildDates() {
    return Row(children: [
      Expanded(
        child: InkWell(
          onTap: () async {
            dateTimeRangePicker();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
                dateDebut == null ? 'Select start date' : dateDebut.toString()),
          ),
        ),
      ),
      CircleAvatar(
        radius: 30,
        child: Icon(Icons.arrow_right),
      ),
      Expanded(
        child: InkWell(
          onTap: () async {
            dateTimeRangePicker();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child:
                Text(dateFin == null ? 'Select end date' : dateFin.toString()),
          ),
        ),
      ),
    ]);
  }

  _buildNbPersonnes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text('Nombre de personnes '),
        DropdownButton(
          value: nbPersonnes,
          items: listNbPersonnes.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              nbPersonnes = value!;
            });
          },
        )
      ],
    );
  }

  TotalWidget(int prixTotal) {}

  _buildRentButton() {

    var format = NumberFormat('### €');

    return Container(
      decoration: BoxDecoration(
        color: LocationStyle.backgroundColorPurple,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                print('Louer habitation');
              },
              child: Text('Louer'),
            ),
          ),
        ],
      ),
    );
  }
  dateTimeRangePicker() async {
    DateTimeRange? datePicked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDateRange: DateTimeRange(start: dateDebut, end: dateFin),
      cancelText: 'Annuler',
      confirmText: 'Valider',
      locale: const Locale("fr", "FR"),
    );
    if (datePicked != null) {
      setState(() {
        dateDebut = datePicked.start;
        dateFin = datePicked.end;
      });
    }
  }

  _loadOptionPayantes() {
    widget._habitation.optionpayantes.forEach((element) {
      optionPayanteChecks.add(OptionPayanteCheck(element.id, element.libelle,false));
    });
    return optionPayanteChecks;
  }

  _buildOptionsPayantes(BuildContext context) {
    // return  Iterable.generate(
    //     optionPayanteChecks.length,
    //         (i) => CheckboxListTile(
    //       title: Text(optionPayanteChecks[i].libelle),
    //       value: false,
    //       onChanged: null)
    // ).toList();

    return CheckboxListTile(
      title: Text(optionPayanteChecks[1].libelle),
      value: optionPayanteChecks[1].checked,
      onChanged: (newValue) {
        setState(() {
          optionPayanteChecks[1].checked = newValue!;
        });
      },
    );
  }
}

