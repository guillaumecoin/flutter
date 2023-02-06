import 'package:agence/models/habitation.dart';
import 'package:agence/share/location_style.dart';
import 'package:agence/views/share/HabitationOption.dart';
import 'package:agence/views/share/habitation_features_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HabitationDetails extends StatefulWidget {
  final Habitation _habitation;

  const HabitationDetails(this._habitation, {Key? key}) : super(key: key);

  @override
  State<HabitationDetails> createState() => _HabitationDetailsState();

}

class _HabitationDetailsState extends State<HabitationDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._habitation.libelle),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/locations/${widget._habitation.image}',
              fit: BoxFit.fitWidth,
            ),
    ),
              Container(
              margin: EdgeInsets.all(8.0),
              child: Text(widget._habitation.adresse),
            ),
            HabitationFeaturesWidget(widget._habitation),
          _buildItems(),
          _buildOptionsPayantes(),
          _buildRentButton(),
        ],
      ),
    );

  }

  _buildRentButton(){
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
            child: Text(
              format.format(widget._habitation.prixmois),
            ),
          ),
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

  _buildItems() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;

    return Wrap(

      spacing: 2.0,
      children: Iterable.generate(
        widget._habitation.options.length,
          (i) => Container(
            margin: EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Compris"),
                ),
                Text(widget._habitation.options[i].libelle, style: LocationStyle.regularGreyTextStyle),
                Expanded(
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Options"),
                ),
                Text(widget._habitation.options[i].description, style: LocationStyle.regularGreyTextStyle),
              ],
            ),
          ),
      ).toList(),
    );
  }

  _buildOptionsPayantes() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;

    return Wrap(
      spacing: 2.0,
      children: Iterable.generate(
        widget._habitation.optionpayantes.length,
            (i) => Container(
          margin: EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget._habitation.optionpayantes[i].libelle, style: LocationStyle.regularGreyTextStyle),
              Text(widget._habitation.optionpayantes[i].description, style: LocationStyle.regularGreyTextStyle),
            ],
          ),
        ),
      ).toList(),
    );
  }





}

