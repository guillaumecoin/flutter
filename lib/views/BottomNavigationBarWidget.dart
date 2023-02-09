import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BadgeWidget.dart';
import 'LocationList.dart';
import 'Profil.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int indexSelected;
  const BottomNavigationBarWidget(this.indexSelected, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isUserNotConnected = true;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: indexSelected,
      items: <BottomNavigationBarItem> [
        const BottomNavigationBarItem (
            icon: Icon(Icons.home),
            label: 'Accueil'
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche'
        ),
        BottomNavigationBarItem(
            icon: isUserNotConnected
                ? const Icon(Icons.shopping_cart_outlined)
                : BadgeWidget(
              value: 0,
              top: 0,
              right: 0,
              child: const Icon(Icons.shopping_cart),
            ),
          label: 'Locations',
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil'
        ),
      ],
      onTap: (index) {
        String page ='/';
        switch (index) {
          case 2:
            page = LocationList.routeName;
            break;
          case 3:
            page = Profil.routeName;
            break;
        }
        Navigator.pushNamedAndRemoveUntil(context, page, (route) => false);
      },
    );
  }


}


